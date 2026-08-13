peripheral.getMethods("staff")
local staffSide = "left"
Staff = peripheral.wrap(staffSide)

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
    }
}

local function cast(spellName)
    Staff.runPattern(spells[spellName].startDir, spells[spellName].angles)
end


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
print(textutils.serialise(Staff.getStack()))
turtle.select(13)
cast("readFocus")
turtle.select(1)
cast("hermesGambit")
turtle.dig()
turtle.select(14)
turtle.equipRight()
turtle.select(15)
for i = 2, 9, 1 do
    turtle.transferTo(i, 1)
end
turtle.select(14)
turtle.equipRight()
turtle.craft()