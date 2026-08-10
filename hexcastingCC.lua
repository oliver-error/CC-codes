peripheral.getMethods("staff")
local staffSide = "left"
Staff = peripheral.wrap(staffSide)

local function cast(spellName)
    Staff.runPattern(spells[spellName].startDir, spells[spellName].angles)
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
}


Staff.pushStack(-454)
Staff.pushStack(69)
Staff.pushStack(-12)
cast("numToVector")
cast("posToPlayer")
Staff.pushStack(0)
Staff.pushStack(10)
Staff.pushStack(0)
cast("numToVector")
cast("impulse")