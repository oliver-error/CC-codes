local forwardMovementSide = "left"
local backwardMovementSide = "top"
local drillPowerSide = "right"
local dockingConnectorSide = "back"
local opticalSensorSide = "bottom"
local activationSide = "front"

local maxBoreSpeed = 11
local openFunnel = 0
local secondsSinceLastActivation = 0
local timeSpentDrilling = 0
local activationSeconds = 30
local drillingSeconds = 60 * 30

while true do
    redstone.setOutput(dockingConnectorSide, true)

    if redstone.getInput(activationSide) then
        secondsSinceLastActivation = 0
        timeSpentDrilling = 0

        redstone.setOutput(dockingConnectorSide, true)
        redstone.setOutput(backwardMovementSide, false)
        redstone.setOutput(forwardMovementSide, true)
        redstone.setAnalogOutput(drillPowerSide, maxBoreSpeed)

        sleep(10)

        redstone.setOutput(dockingConnectorSide, false)

        while secondsSinceLastActivation < activationSeconds and timeSpentDrilling < drillingSeconds do

            if redstone.getInput(opticalSensorSide) then
                secondsSinceLastActivation = 0
            else
                secondsSinceLastActivation = secondsSinceLastActivation + 0.1
            end
            timeSpentDrilling = timeSpentDrilling + 0.1
            sleep(0.1)
        end

        redstone.setOutput(forwardMovementSide, false)
        redstone.setOutput(backwardMovementSide, true)
        redstone.setOutput(dockingConnectorSide, true)

        while not redstone.getInput(activationSide) do
            sleep(0.1)
        end
        sleep(3)

        redstone.setOutput(backwardMovementSide, true)
        redstone.setOutput(forwardMovementSide, false)
        redstone.setAnalogOutput(drillPowerSide, openFunnel)

        while not redstone.getInput(activationSide) do
            sleep(0.1)
        end
        sleep(3)

        redstone.setOutput(backwardMovementSide, false)
        redstone.setOutput(forwardMovementSide, false)
    end

    sleep(0.1)
end