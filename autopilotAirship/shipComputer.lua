function create(p, i, d, initial_i)
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

-- local pid = create(1.0, 0.1, 0.05, 0)

-- local output
-- output, pid = tick(pid, 100, 80, 0.1)

rednet.open("back")
HeightPid = create(1.0, 0.1, 0.05, 0)
AnglePid = create(1.0, 0.1, 0.05, 0)
DistancePid = create(1.0, 0.1, 0.05, 0)

local file = fs.open("data.txt", "r")
local mainID
LastTarget = nil
TargetPosition = nil
DeltaTime = 0
LastTime = os.time()

if file then
    mainID = textutils.unserializeJSON(file.readAll())
    file.close()
else
    write("enter main computer ID:")
    mainID = tonumber(read("*"))
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
        end
        -- TODO: make travel PID's
        DeltaTime = os.time() - lastTime
        if heightActive then
            output, HeightPid = tick(HeightPid, 100, currentHeight, deltaTime)
        end
        LastTime = os.time()
    end
end

parallel.waitForAny(rednetListener, travel)