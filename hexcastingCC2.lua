local function findItem(itemName)
    for i = 1, 16 do
        local data = turtle.getItemDetail(i)
        if data and data.name == itemName then
            return i -- Returns the slot number where the item is found
        end
    end
    return nil -- Item not found in inventory
end

while true do
    while findItem("minecraft:amethyst_shard") == nil do
        sleep(0.1)
    end
    turtle.select(findItem("minecraft:amethyst_shard"))
    sleep(5)
    turtle.drop(4)
    turtle.turnLeft()
    turtle.drop(3)
    turtle.turnRight()
    turtle.turnRight()
    while findItem("minecraft:amethyst_shard") ~= nil do
        turtle.select(findItem("minecraft:amethyst_shard"))
        turtle.drop()
    end
    turtle.turnLeft()
    sleep(10)
end