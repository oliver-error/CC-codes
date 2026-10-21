rednet.open("back")
local file = fs.open("data.txt", "r")
local mainID

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
end

local function userInput()
    while true do
        write("enter ship ID:")
        local id = read()
        print()
        write("enter ship password:")
        local password = read("*")
        print()
        write("target destination in format x, y, z:")
        local destinationStr = read()
        local destination = {}
        for numStr in string.gmatch(destinationStr, "%d+") do
            table.insert(destination, tonumber(numStr)) 
        end

        local payload = {
            id = id, 
            password = password, 
            pocket = true, 
            location = destination
        }

        term.clear()

        local success = rednet.send(mainID, textutils.serializeJSON(payload))
        
        if not success then
            print("messsage was not sent. This is either due to the main computer ID being put in wrong or the system being offline")
            print("please contact Mr. andersen to restart the system or fix your pocket computer.")
        end

        sleep(2)
        print()
        write("enter anything to re-enter the command or summon another ship")
        read()
    end
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
            data = textutils.unserializeJSON(message) -- formatted as: str (error message) or table {ETA = 60}
            if type(data) == "table" then
                print("data sent succesfully! ETA: " .. data["ETA"] .. " seconds!")
            else
                print(data)
            end
        end
    end
end

parallel.waitForAny(userInput, rednetListener)