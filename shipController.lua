local forwardJoystickSide = "front" -- on computer
local backwardsJoystickSide = "back" -- on computer
local rightJoystickSide = "right" -- on computer
local leftJoystickSide = "left" -- on computer
local frontThruster = "front"
local backThruster = "left"
local frontRightTruster = "right"
local backRightTruster = "back"
local frontLeftTruster = "top" -- on computer
local backLeftTruster = "bottom"
local relay = peripheral.wrap("redstone_relay_0")

while true do
    relay.setAnalogOutput(frontThruster, redstone.getAnalogInput(forwardJoystickSide))
    relay.setAnalogOutput(backThruster, redstone.getAnalogInput(backwardsJoystickSide))
    relay.setAnalogOutput(frontRightTruster, redstone.getAnalogInput(leftJoystickSide))
    relay.setAnalogOutput(backLeftTruster, redstone.getAnalogInput(leftJoystickSide))
    relay.setAnalogOutput(backRightTruster, redstone.getAnalogInput(rightJoystickSide))
    redstone.setAnalogOutput(frontLeftTruster, redstone.getAnalogInput(rightJoystickSide))
    sleep(0.1)
end