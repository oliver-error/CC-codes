peripheral.getMethods("staff")
local staffSide = "left"
local allayThreshold = 3
Staff = peripheral.wrap(staffSide)

local function findItem(itemName)
    for i = 1, 16 do
        local data = turtle.getItemDetail(i)
        if data and data.name == itemName then
            return i -- Returns the slot number where the item is found
        end
    end
    return nil -- Item not found in inventory
end

local spells = {
    overgrow = {
        startDir = "NORTH_EAST",
        angles = "wqaqwawqaqw"
    },
    numToVector = {
        startDir = "EAST",
        angles = "eqqqqq"
    },
    writeToScroll = {
        startDir = "EAST",
        angles = "deeeee"
    },
    readFocus = {
        startDir = "EAST",
        angles = "aqqqqq"
    },
    executeScroll = {
        startDir = "SOUTH_EAST",
        angles = "deaqq"
    },
    posToPlayer = {
        startDir = "SOUTH_EAST",
        angles = "qqqqqdaqaawe"
    },
    explosion = {
        startDir = "EAST",
        angles = "aawaawaa"
    },
    placeBlock = {
        startDir = "SOUTH_WEST",
        angles = "eeeeede"
    },
    impulse = {
        startDir = "SOUTH_WEST",
        angles = "awqqqwaqw"
    },
    equal = {
        startDir = "EAST",
        angles = "ad"
    },
    removeFromList = {
        startDir = "SOUTH_WEST",
        angles = "edqdewaqa"
    },
    zoneDistLiving = {
        startDir = "SOUTH_EAST",
        angles = "qqqqqwdeddwd"
    },
    flockDist = {
        startDir = "NORTH_WEST",
        angles = "qwaeawq"
    },
    hermesGambit = {
        startDir = "SOUTH_EAST",
        angles = "deaqq"
    },
    Jesters = {
        startDir = "EAST",
        angles = "aawdd"
    },
    removeTop = {
        startDir = "SOUTH_EAST",
        angles = "a"
    },
    fisherMan = {
        startDir = "WEST",
        angles = "ddad"
    },
    gemini = {
        startDir = "EAST",
        angles = "aadaa"
    },
    blackSun = {
        startDir = "SOUTH_WEST",
        angles = "qqqqqaewawawe"
    },
    blink = {
        startDir = "SOUTH_WEST",
        angles = "awqqqwaq"
    }
}

local function cast(spellName)
    Staff.runPattern(spells[spellName].startDir, spells[spellName].angles)
end

while true do
    while findItem("minecraft:amethyst_block") == nil do
        sleep(0.1)
    end
    sleep(10)
    Staff.pushStack(-540)
    Staff.pushStack(67)
    Staff.pushStack(122)
    cast("numToVector")
    Staff.pushStack(10)
    cast("zoneDistLiving")
    cast("flockDist")
    Staff.pushStack(-541)
    Staff.pushStack(68)
    Staff.pushStack(122)
    cast("numToVector")
    while true do
        local stack = Staff.getStack()
        local top = 0
        local found = false

        for i in pairs(stack) do
            if i > top then
                top = i
            end
        end

        local numberOfAllays = 0

        for i = 1, top, 1 do
            local entry = stack[i]
            if entry and entry["iota$serde"] == "hextweaks:entity" then
                local isAllay = entry.name:find("allay")
                if isAllay then
                    numberOfAllays = numberOfAllays + 1
                end
            end
        end

        if numberOfAllays < allayThreshold then
            for i = top, 0, -1 do
                local entry = stack[i]

                if entry and entry["iota$serde"] == "hextweaks:entity" then
                    local isAllay = entry.name:find("allay")
                    if isAllay then
                        break
                    else
                        local fisherIndex = top - i

                        Staff.pushStack(fisherIndex)
                        cast("fisherMan")
                        cast("removeTop")

                        found = true
                        break
                    end
                end
            end
        else
            found = true
        end
        
        if not found then
            break
        end
        sleep(0.1)
    end
    log = fs.open("log.txt", "w")
    log.writeLine(textutils.serialise(Staff.getStack()))
    log.close()
    turtle.select(1)
    cast("Jesters")
    cast("gemini")
    Staff.pushStack(2)
    cast("fisherMan")
    cast("readFocus")
    cast("hermesGambit")
    Staff.pushStack(10)
    Staff.pushStack(1)
    cast("blackSun")

    while findItem("minecraft:amethyst_shard") == nil do
        turtle.select(findItem("minecraft:amethyst_shard"))
        turtle.dropUp()
    end

    turtle.dig()
    if findItem("hexcasting:quenched_allay_shard") == nil then
        turtle.select(findItem("minecraft:amethyst_block"))
        turtle.place()
        return
    end
    turtle.select(findItem("hexcasting:quenched_allay_shard"))
    turtle.turnRight()
    turtle.turnRight()
    while findItem("hexcasting:quenched_allay_shard") ~= nil do
        turtle.drop()
    end
    turtle.turnRight()
    turtle.turnRight()
    while findItem("minecraft:amethyst_block") == nil do
        sleep(0.1)
    end
    turtle.select(findItem("minecraft:amethyst_block"))
    turtle.place()
    turtle.select(findItem("minecraft:amethyst_shard"))
    turtle.dropUp()
end