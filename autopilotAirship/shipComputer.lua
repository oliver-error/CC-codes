local function getProgressOnLine(A, B, P)
    -- find distance along line AB where A is starting B is ending and P is current
    -- 1. Define the vectors
    local ab_x = B.x - A.x
    local ab_y = B.y - A.y
    
    local ap_x = P.x - A.x
    local ap_y = P.y - A.y
    
    -- 2. Compute dot product and magnitude squared
    local dot_product = (ap_x * ab_x) + (ap_y * ab_y)
    local ab_magnitude_sq = (ab_x * ab_x) + (ab_y * ab_y)
    
    -- Prevent division by zero if A and B are the exact same point
    if ab_magnitude_sq == 0 then 
        return 0
    end
    
    -- 3. Find the parameter t (0 = start, 1 = end)
    local t = dot_product / ab_magnitude_sq
    
    return t
end

-- Helper function to normalize any angle error (no clue why its required)
local function normalizeAngleError(target, current)
    local error = target - current
    return (error + math.pi) % (2 * math.pi) - math.pi
end

local function getPosition(CurrentPosition, forwardReading, rightReading, rotation, dt)
    local distanceForward = forwardReading * dt
    local distanceRight = rightReading * dt

    local deltaX = (distanceForward * math.sin(rotation)) + (distanceRight * math.cos(rotation))
    local deltaZ = (distanceForward * math.cos(rotation)) - (distanceRight * math.sin(rotation))

    CurrentPosition[1] = CurrentPosition[1] + deltaX
    CurrentPosition[3] = CurrentPosition[3] + deltaZ
    
    return CurrentPosition
end

function createPID(p, i, d, initial_i)
    return {
        p = p,
        i = i,
        d = d,
        integral = initial_i or 0,
        previous_error = 0
    }
end

function tick(pid, target, current, dt)
    local error = target - current

    -- Integral term
    pid.integral = pid.integral + error * dt

    -- Derivative term
    local derivative = (error - pid.previous_error) / dt

    -- PID output
    local output =
        pid.p * error +
        pid.i * pid.integral +
        pid.d * derivative

    -- Store error for the next tick
    pid.previous_error = error

    return output, pid
end

rednet.open("back")

-- constants
OFF = 0
ON = 15

-- config
HeightPid = createPID(1.0, 0.1, 0.05, 0)
AnglePid = createPID(1.0, 0.1, 0.05, 0)
DistancePid = createPID(1.0, 0.1, 0.05, 0)
HOVERING_HEIGHT = 200

-- varible setup
local file = fs.open("data.txt", "r")
local mainID
LastTarget = nil
TargetPosition = nil
DeltaTime = 0
LastTime = 0
CurrentPosition = {0, 0, 0}
StartingPosition = CurrentPosition
TargetHeight = HOVERING_HEIGHT
HeightActive = true
Landing = false
LastTime = os.clock()

if file then
    -- non-first iteration, read file then close file
    mainID = textutils.unserializeJSON(file.readAll())
    file.close()
else
    -- first itertion, pair to main and write data to file
    write("enter main computer ID:")
    mainID = tonumber(read())
    file.close()
    local newFile = fs.open("data.txt", "w")
    if newFile then
        newFile.write(textutils.serializeJSON(mainID))
        newFile.close()
    end

    print()
    write("enter new ship ID:")
    local id = read()
    print()
    write("enter new password:")
    local password = read()
    local payload = {
        id = id, 
        password = password, 
        pocket = false,
    }

    rednet.send(mainID, textutils.serializeJSON(payload))
end

local function rednetListener()
    while true do 
        local id = nil
        local message, protocol

        while id == nil do
            sleep(0.1)
            id, message, protocol = rednet.receive(10)
        end

        if id == mainID then
            LastTarget = TargetPosition
            TargetPosition = textutils.unserializeJSON(message) -- formatted as: {x, y, z}
        end
    end
end

local function travel()
    while true do
        while not TargetPosition do
            sleep(0.1)
            StartingPosition = CurrentPosition
            TargetHeight = HOVERING_HEIGHT
            HeightActive = true
            Landing = false
            LastTime = os.clock()
            -- TODO: get velocity sensor readings and delta time
            CurrentPosition = getPosition(CurrentPosition, forwardReading, rightReading, currentAngle, DeltaTime)
            -- TODO: set all thrusters/burners to OFF
        end

        -- TODO: get data currentHeight, currentAngle (in radians), forwardReading, rightReading
        currentTime = os.clock()
        DeltaTime = currentTime - LastTime

        CurrentPosition = getPosition(CurrentPosition, forwardReading, rightReading, currentAngle, DeltaTime)

        if HeightActive then
            output, HeightPid = tick(HeightPid, 100, currentHeight, DeltaTime)
            output = math.floor(math.max(0, math.min(15, output)))
            -- TODO: make output go to burner
        end

        if AngleActive then
            targetAngle = math.atan2(TargetPosition[3] - CurrentPosition[3], TargetPosition[1] - CurrentPosition[1])
            targetAngle = currentAngle + normalizeAngleError(targetAngle, currentAngle)
            
            output, AnglePid = tick(AnglePid, targetAngle, currentAngle, DeltaTime)
            -- clamp values to -ON and ON
            output = math.floor(math.max(-15, math.min(15, output)))
            -- TODO: make output go to rotation thrusters
        end

        local dx = TargetPosition[1] - CurrentPosition[1]
        local dz = TargetPosition[3] - CurrentPosition[3]
        local distanceToTarget = math.sqrt(dx*dx + dz*dz)

        if DistanceActive then
            starting = {
                x = StartingPosition[1],
                y = StartingPosition[3]
            }
            target = {
                x = TargetPosition[1],
                y = TargetPosition[3]
            }
            current = {
                x = CurrentPosition[1],
                y = CurrentPosition[3]
            }
            currentDistance = getProgressOnLine(starting, target, current)
            output, DistancePid = tick(DistancePid, 1, currentDistance, DeltaTime)
            output = math.floor(math.max(0, math.min(15, output)))
            -- TODO: make output go to travel trusters
        end

        if math.abs(currentHeight - TargetHeight) <= 2 and not Landing then
            -- if current height within 2 blocks of target, start angle PID
            AngleActive = true
        elseif Landing then
            -- shut everything off
            HeightActive = false
            TargetPosition = nil
        end

        if math.abs(currentAngle - targetAngle) <= 0.05 and not Landing then
            -- if current angle within 3 degrees (0.05 radaians) of target, start distance PID
            DistanceActive = true
        end

        if DistanceActive and distanceToTarget <= 1.5 and not Landing then
            -- if current distance within 1.5 blocks of target, start landing sequence
            AngleActive = false
            DistanceActive = false
            Landing = true
            TargetHeight = TargetPosition[2] + 1
        end

        LastTime = currentTime
        sleep(0.05)
    end
end

parallel.waitForAny(rednetListener, travel)