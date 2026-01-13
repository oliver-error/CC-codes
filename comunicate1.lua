local function setup1(mycomputerID)
    while(sendcomputerID == nil)do
    sendcomputerID = rednet.receive(nil , 10)
    end
    rednet.send(sendcomputerID, mycomputerID)
    return sendcomputerID
end

print("running!")
rednet.open("back")
local mycomputerID = 2
local sendcomputerID = setup1(mycomputerID)
print("my ID: " .. mycomputerID .. " other computer's ID: " .. sendcomputerID)