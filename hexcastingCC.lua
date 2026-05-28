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
    ten = {
        startDir = "SOUTH_EAST",
        angles = "aqaae"
    },
    zero = {
        startDir = "SOUTH_EAST",
        angles = "aqaa"
    }
}


Staff.pushStack(-384)
Staff.pushStack(92)
Staff.pushStack(-86)
Staff.runPattern(spells.numToVector)
Staff.runPattern(spells.posToPlayer)
Staff.runPattern(spells.zero)
Staff.runPattern(spells.ten)
Staff.runPattern(spells.zero)
Staff.runPattern(spells.numToVector)
Staff.runPattern(spells.impulse)