local function setup1(mycomputerID)
    while(sendcomputerID == nil)do
    sendcomputerID = rednet.receive(nil , 10)
    end
    rednet.send(sendcomputerID, mycomputerID)
    return sendcomputerID
end

local function equipPick()
    for i = 1, 16 do
        local item = turtle.getItemDetail(i)
        if (item and item.name == "minecraft:diamond_pickaxe") then
            turtle.select(i)
            break
        end
    end
end

local function equipModem()
    for i = 1, 16 do
        local item = turtle.getItemDetail(i)
        if (item and item.name == "cc-tweaked:ender_modem") then
            turtle.select(i)
            break
        end
    end
end

local function ore(direction)
    -- this looks garbage and NOTHING will change that
    if(direction == "forward") then
        if(turtle.detect()) then
            blockData = turtle.inspect()
            if blockData and blockData.tags and blockData.tags.minecraft_ore then
                return true
            else
                return false
            end
        end
    elseif(direction == "up")then
        if(turtle.detectUp()) then
            blockData = turtle.inspect()
            if blockData and blockData.tags and blockData.tags.minecraft_ore then
                return true
            else
                return false
            end
        end
    elseif(direction == "down")then
        if(turtle.detectDown()) then
            blockData = turtle.inspect()
            if blockData and blockData.tags and blockData.tags.minecraft_ore then
                return true
            else
                return false
            end
        end
    elseif(direction == "left")then
        turtle.turnLeft()
        if(turtle.detect()) then
            blockData = turtle.inspect()
            if blockData and blockData.tags and blockData.tags.minecraft_ore then
                return true
            else
                return false
            end
        end
        turtle.turnRight()
    elseif(direction == "right")then
        turtle.turnRight()
        if(turtle.detect()) then
            blockData = turtle.inspect()
            if blockData and blockData.tags and blockData.tags.minecraft_ore then
                return true
            else
                return false
            end
        end
        turtle.turnLeft()
    end
end

local function veinminer()
    local veinmove = {}
    turtle.dig()
    turtle.forward()
    while(true) do
        if(ore("forward")) then
            turtle.dig()
            turtle.forward()
            table.insert(veinmove, "forward")
        elseif (ore("down")) then
            turtle.digDown()
            turtle.down()
            table.insert(veinmove, "down")
        elseif (ore("up")) then
            turtle.digUp()
            turtle.up()
            table.insert(veinmove, "up")
        elseif (ore("right")) then
            turtle.turnRight()
            turtle.dig()
            turtle.forward()
            table.insert(veinmove, "right")
        elseif (ore("left")) then
            turtle.turnLeft()
            turtle.dig()
            turtle.forward()
            table.insert(veinmove, "left")
        else
            local direction = veinmove[#veinmove]
            if(direction == "down")then
                turtle.up()
                table.remove(veinmove, #veinmove)
            elseif(direction == "up")then
                turtle.down()
                table.remove(veinmove, #veinmove)
            elseif(direction == "right")then
                turtle.turnLeft()
                turtle.forward()
                table.remove(veinmove, #veinmove)
            elseif(direction == "left")then
                turtle.turnRight()
                turtle.forward()
                table.remove(veinmove, #veinmove)
            elseif(direction == "forward")then
                turtle.back()
                table.remove(veinmove, #veinmove)
            else
                break
            end
        end
    end
    turtle.back()
end

local function check()
    if(ore("forward")) then
        veinminer()
    end
    turtle.turnRight()
    if(ore("forward")) then
        veinminer()
    end
    turtle.turnLeft()
    turtle.turnLeft()
    if(ore("forward")) then
        veinminer()
    end
    turtle.turnRight()
end

local function refuel(movements)
    local entry = #movements
    while(true) do
        local direction = movements[entry]
        if(direction == "forward")then
            turtle.back()
        elseif(direction == "up")then
            turtle.down()
        elseif(direction == "down")then
            turtle.down()
        elseif(direction == "right")then
            turtle.turnLeft()
            turtle.back()
        elseif(direction == "left")then
            turtle.turnRight()
            turtle.back()
        else
            break
        end
        entry = entry-1
    end
    turtle.up()
    for i = 1, 16 do
        turtle.select(i)
        turtle.drop(64)
    end
    turtle.down()
    turtle.turnRight()
    turtle.turnRight()
    turtle.select(1)
    local count = 0
    while(turtle.getFuelLevel() <= 2000)do
        while(true)do
            if(refuel(0))then
                refuel(64)
                break
            end
            if(turtle.getSelectedSlot() >= 16)then
                turtle.select(turtle.getSelectedSlot() + 1)
            else
                turtle.select(1)
                turtle.suck(64)
            end
            count = count + 1
            if(count > 100) then
                return false
            end
        end
    end
    local entry = 1
    while(true) do
        local direction = movements[entry]
        if(direction == "forward")then
            turtle.forward()
        elseif(direction == "up")then
            turtle.up()
        elseif(direction == "down")then
            turtle.down()
        elseif(direction == "right")then
            turtle.turnRight()
            turtle.forward()
        elseif(direction == "left")then
            turtle.turnLeft()
            turtle.forward()
        else
            break
        end
        entry = entry+1
    end
end

equipPick()
local direction = {["d"] = "down", ["u"] = "up", ["f"] = "forward", ["r"] = "right", ["l"] = "left" }
local mycomputerID = 8
local sendcomputerID = setup1(mycomputerID)
local movements = {}
local checks = nil
rednet.send(sendcomputerID, "what is my Y?")
local ylevel = rednet.receive()
for i = 16, ylevel, -1 do
    turtle.digDown()
    turtle.down()
    table.insert(#movements, direction["d"])
end 
check()
while(true) do
    if(not turtle.getFuelLevel() < #movements + 60)then
        turtle.dig()
        turtle.forward()
        table.insert(#movements, direction["f"])
        equipModem()
        msg = rednet.receive(sendcomputerID, 0.1)
        if(msg ~= false) then -- you CANNOT put == true since it return false on a failure and it NEVER returns true
            if(msg == "return" or msg == "refuel")then
                refuel()
                rednet.send(sendcomputerID, "returning!")
            end
        end
        equipPick()
        check()
    else
        checks = refuel(movements) -- full refuel code
        if(checks == false)then
        while(turtle.getFuelLevel() <= 2000)do
            while(true)do
                if(refuel(0))then
                    refuel(64)
                    break
                end
                if(turtle.getSelectedSlot() >= 16)then
                    turtle.select(turtle.getSelectedSlot() + 1)
                else
                    turtle.select(1)
                    turtle.suck(64)
                end
                count = count + 1
                if(count > 100) then
                    rednet.send(sendcomputerID, "insufficient fuel")
                end
            end
        end
        end
    end
end
