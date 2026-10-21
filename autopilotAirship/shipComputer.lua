rednet.open("back")
local file = fs.open("data.txt", "r")
local mainID
LastTarget = nil
TargetPosition = nil

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
    end
end

parallel.waitForAny(rednetListener, travel)