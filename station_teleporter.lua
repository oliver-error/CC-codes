local locations = {{-69, 63, 31}}
local modem = peripheral.wrap("top")
local currentLocation = 1
modem.open(43)

while true do
    while channel ~= 10 do
        event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
        sleep(0.1)
    end

    if message == "next" then
        currentLocation = currentLocation + 1
        if currentLocation > #locations then
            currentLocation = 1
        end
        commands.exec("tp @a " .. table.concat(locations[currentLocation], " "))
    elseif message == "previous" then
        currentLocation = currentLocation - 1
        if currentLocation < 1 then
            currentLocation = #locations
        end
        commands.exec("tp @a " .. table.concat(locations[currentLocation], " "))
    end
end
