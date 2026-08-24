local backThruster = {peripheral.wrap("redstone_relay_3"), "left"}
local frontRightThruster = {peripheral.wrap("redstone_relay_5"), "right"}
local frontLeftThruster = {peripheral.wrap("redstone_relay_4"), "back"}
local backRightThruster = {peripheral.wrap("redstone_relay_5"), "back"}
local backLeftThruster = {peripheral.wrap("redstone_relay_4"), "left"}
local burner = {""}
local function activateThruster(side, strength)
    side[1].setAnalogOutput(side[2], strength)
end
print(backThruster[1].getMethods())
activateThruster(backThruster, 15)


