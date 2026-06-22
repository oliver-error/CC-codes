local frontRelay = peripheral.wrap("redstone_relay_0")
local backRelay = peripheral.wrap("redstone_relay_2")
local rightRelay = peripheral.wrap("redstone_relay_3")
local leftRelay = peripheral.wrap("redstone_relay_1")
local gimbal = peripheral.wrap("gimbal_sensor_0")

local TILT_MAX = 15

-- Minimum throttle required to enable stabilization
local MIN_ACTIVE_POWER = 1

local P = 0.025 --0.18
local I = 0.015 --0.015
local D = 0.08 --0.08

-- PID SETTINGS
local forwardPID = {
    kp = P,
    ki = I,
    kd = D,

    integral = 0,
    lastError = 0
}

local rightPID = {
    kp = P,
    ki = I,
    kd = D,

    integral = 0,
    lastError = 0
}

local function clamp(n, min, max)
    return math.min(max, math.max(min, n))
end

local function clampToRedstone(n)
    return clamp(math.floor(n + 0.5), 0, 15)
end

local function getRotForward()
    return gimbal.getAngles()[2]
end

local function getRotRight()
    return gimbal.getAngles()[1]
end

local function setBackLeft(pow)
    rightRelay.setAnalogOutput("bottom", pow)
end

local function setBackRight(pow)
    backRelay.setAnalogOutput("bottom", pow)
end

local function setFrontLeft(pow)
    frontRelay.setAnalogOutput("bottom", pow)
end

local function setFrontRight(pow)
    leftRelay.setAnalogOutput("bottom", pow)
end

local function stopAll()
    setBackLeft(0)
    setBackRight(0)
    setFrontLeft(0)
    setFrontRight(0)
end

local function resetPID(pid)
    pid.integral = 0
    pid.lastError = 0
end

local function updatePID(pid, target, current, dt)
    local error = target - current

    -- Integral
    pid.integral = pid.integral + error * dt

    -- Anti-windup
    pid.integral = clamp(pid.integral, -100, 100)

    -- Derivative
    local derivative = (error - pid.lastError) / dt

    pid.lastError = error

    return
        error * pid.kp +
        pid.integral * pid.ki +
        derivative * pid.kd
end

local lastTime = os.clock()

while true do
    local now = os.clock()
    local dt = now - lastTime
    lastTime = now

    if dt <= 0 then
        dt = 0.05
    end

    local targetPow = frontRelay.getAnalogInput("top")

    -- Disable stabilization under threshold
    if targetPow < MIN_ACTIVE_POWER then
        stopAll()

        resetPID(forwardPID)
        resetPID(rightPID)

        sleep(0.05)
    else
        local currentForward = getRotForward()
        local currentRight = getRotRight()

        print("Forward:")
        print(currentForward)

        print("Right:")
        print(currentRight)

        -- Target tilt angles
        local TILT_ANGLE = 10

        local targetForward = (leftRelay.getAnalogInput("top") - 8) / 15 * TILT_ANGLE
        local targetRight = (rightRelay.getAnalogInput("top") - 8) / 15 * TILT_ANGLE

        -- PID corrections
        local forwardCorrection =
            updatePID(forwardPID, targetForward, currentForward, dt)

        local rightCorrection =
            updatePID(rightPID, targetRight, currentRight, dt)

        -- Motor mixing
        local backLeft =
            targetPow
            + forwardCorrection
            + rightCorrection

        local backRight =
            targetPow
            + forwardCorrection
            - rightCorrection

        local frontLeft =
            targetPow
            - forwardCorrection
            + rightCorrection

        local frontRight =
            targetPow
            - forwardCorrection
            - rightCorrection

        -- Output
        setBackLeft(clampToRedstone(backLeft))
        setBackRight(clampToRedstone(backRight))
        setFrontLeft(clampToRedstone(frontLeft))
        setFrontRight(clampToRedstone(frontRight))

        sleep(0.2)
    end
end