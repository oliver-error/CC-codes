local function setup2(mycomputerID)
    while(sendcomputerID == nil) do
        rednet.broadcast(mycomputerID)
        sendcomputerID = rednet.receive(nil, 1)
    end
    return sendcomputerID
end

print("running!")
rednet.open("right")
local mycomputerID = 5
local sendcomputerID = setup2(mycomputerID)
print(" my ID: " .. mycomputerID .. " other computer's ID: " .. sendcomputerID)