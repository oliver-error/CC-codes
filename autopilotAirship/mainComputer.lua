local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

local Content = {}
local ids = {}
local lastPocket = 0

local file = fs.open("data.txt", "r")
if file then
    local fileData = file.readAll()
    file.close()
    
    Content = textutils.unserializeJSON(fileData) or {} -- format: { {"id" = "id thing", "password" = 1000, "shipID" = 10}, {"id" = "id things", "password" = 100, "shipID" = 11} }
    for _, item in ipairs(Content) do
        table.insert(ids, item["id"])
    end
else
    -- first iteration
    print("ID:" .. os.getComputerID())
    local newFile = fs.open("data.txt", "w")
    if newFile then
        newFile.write(textutils.serializeJSON({}))
        newFile.close()
    end
end

rednet.open("top")

while true do
    local id = nil
    local message, protocol

    while id == nil do
        sleep(0.1)
        id, message, protocol = rednet.receive(10)
    end
    
    if message then
        local data = textutils.unserializeJSON(message) -- format:  {"id" = "id thing", "password" = 1000, "pocket" = true, "location"(pocket specific) = {10, 0, -100}}
        local sent = false

        if data["pocket"] then
            -- pocket packet
            lastPocket = id
            for _, item in ipairs(Content) do
                if data and item["id"] == data["id"] and data["password"] == item["password"] then
                    rednet.send(item["shipID"], textutils.serializeJSON(item["location"]))
                    sent = true
                    break
                end
            end

            if not sent then
                rednet.send(id, textutils.serializeJSON("Error logging in (you provided the wrong password/ID)"))
            end
        else
            -- ship packet
            if not has_value(ids, data["id"]) then
                table.insert(Content, {id = data["id"], password = data["password"], shipID = id})
                table.insert(ids, data["id"])
                
                local writeFile = fs.open("data.txt", "w")
                if writeFile then
                    writeFile.write(textutils.serializeJSON(Content))
                    writeFile.close()
                end
            else
                rednet.send(lastPocket, data) -- forward data to pocket if ship is regestered
            end
        end
    end
end