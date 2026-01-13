slotNum = 5 -- slot that contains the log type
first = true
term.clear()
turtle.select(slotNum)

local chop = function() -- chop code
    print("runniong chop")
    while turtle.detectUp() do
        turtle.select(slotNum)
        if turtle.compareUp() then
            turtle.digUp()
            turtle.up()
        end
    end
    while not turtle.detectDown() do
            turtle.down()
    end
    turtle.back()
end


while true do -- main code
    if turtle.compare() then
        if turtle.getFuelLevel() > 128 then
            turtle.dig()
            turtle.forward()
            chop()
            while true do -- sapling
                print("saplining")
                turtle.suckDown()
                local itemDetails = turtle.getItemDetail(turtle.getSelectedSlot())
                if turtle.getItemCount(turtle.getSelectedSlot()) ~= 0 then
                    itemName = itemDetails.name
                end
               
                if itemName == "minecraft:oak_sapling" then
                    turtle.place()
                        while true do -- bonemeal
                        print("saplining")
                        turtle.suckDown()
                        local itemDetails = turtle.getItemDetail(turtle.getSelectedSlot())
                        if turtle.getItemCount(turtle.getSelectedSlot()) ~= 0 then
                            itemName = itemDetails.name
                        end
                        if itemName == "minecraft:" then
                            turtle.place()
                        else
                            if turtle.getSelectedSlot() == 16 then
                                turtle.select(1)
                            else
                            turtle.select(turtle.getSelectedSlot() + 1)
                            end
                        end
                    end
                else
                    if turtle.getSelectedSlot() == 16 then
                        turtle.select(1)
                    else
                       turtle.select(turtle.getSelectedSlot() + 1)
                    end
                end
            end
        else
            while true do -- fueling
                print("insufficient fuel")
                turtle.suckDown()
                local itemDetails = turtle.getItemDetail(turtle.getSelectedSlot())
                if turtle.getItemCount(turtle.getSelectedSlot()) ~= 0 then
                    itemName = itemDetails.name
                end
               
                if itemName == "minecraft:coal" or itemName == "minecraft:charcoal" then
                    print("fueling")
                    while true do
                    turtle.refuel(turtle.getSelectedSlot())
                    if (turtle.getFuelLevel() > 128) then
                        break
                    end
                    end
                else
                    if turtle.getSelectedSlot() == 16 then
                        turtle.select(1)
                    else
                       turtle.select(turtle.getSelectedSlot() + 1)
                    end
                    print(itemName)
                end
            end
        end
    end
end
