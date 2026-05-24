local XCordSlot = 1
local YCordSlot = 2
local ZCordSlot = 3
local staffSide = "left"
local scrollSide = nil
local staff = peripheral.wrap(staffSide)
local spells = {
    overgrow = "NORTH_EAST wqaqwawqaqw",
    numToVector = "EAST eqqqqq",
    writeToScroll = "EAST deeeee",
    readScroll = "EAST aqqqqq",
    executeScroll = "SOUTH_EAST deaqq",
    posToPlayer = "SOUTH_EAST qqqqqdaqaawe",
    explosion = "EAST aawaawaa",
    impulse = "SOUTH_WEST awqqqwaqw",
    ten = " SOUTH_EAST aqaae",
    zero = "SOUTH_EAST aqaa"
}

local function getpos()
    for i = 1, 3 do
        turtle.select(i)
        staff.runPattern(spells.readScroll)
        staff.runPattern(spells.executeScroll)
    end
    staff.runPattern(spells.numToVector)
end

if staffSide == "left" then
    scrollSide = "right"
else
    scrollSide = "left"
end

getpos()
staff.runPattern(spells.posToPlayer)
staff.runPattern(spells.zero)
staff.runPattern(spells.ten)
staff.runPattern(spells.zero)
staff.runPattern(spells.numToVector)
staff.runPattern(spells.impulse)