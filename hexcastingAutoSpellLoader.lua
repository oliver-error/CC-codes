Staff = peripheral.wrap("right")
local spells = {
    equlityDist = {
        startDir = "EAST",
        angles = "ad"
    },
    surgeonExal = {
        startDir = "SOUTH_WEST",
        angles = "edqdewaqa"
    },
    flockDist = {
        startDir = "NORTH_WEST",
        angles = "qwaeawq"
    },
    flockGam = {
        startDir = "SOUTH_WEST",
        angles = "ewdqdwe"
    },
    hermesGam = {
        startDir = "SOUTH_EAST",
        angles = "deaqq"
    },
    jestersGam = {
        startDir = "EAST",
        angles = "aawdd"
    },
    novicesGam = {
        startDir = "SOUTH_EAST",
        angles = "a"
    },
    fisherManGam = {
        startDir = "WEST",
        angles = "ddad"
    },
    geminiDecp = {
        startDir = "EAST",
        angles = "aadaa"
    },
    blink = {
        startDir = "SOUTH_WEST",
        angles = "awqqqwaq"
    },
    mindsRefl = {
        startDir = "NORTH_EAST",
        angles = "qaq"
    },
    introspection = {
        startDir = "WEST",
        angles = "qqq"
    },
    retrospection = {
        startDir = "WEST",
        angles = "eee"
    },
    scribesGam = {
        startDir = "EAST",
        angles = "deeeee"
    },
    scribesRefl = {
        startDir = "EAST",
        angles = "aqqqqq"
    },
    sortersPurf = {
        startDir = "EAST",
        angles = "qaqqaea"
    },
    falseRefl = {
        startDir = "NORTH_EAST",
        angles = "dedq"
    },
    trueRefl = {
        startDir = "SOUTH_EAST",
        angles = "aqae"
    },
    geminiGam = {
        startDir = "EAST",
        angles = "aadaadaa"
    },
    rotationGam = {
        startDir = "EAST",
        angles = "aaeaa"
    },
    thothsGam = {
        startDir = "NORTH_EAST",
        angles = "dadad"
    },
    charonsGam = {
        startDir = "SOUTH_WEST",
        angles = "aqdee"
    },
    augursExal = {
        startDir = "SOUTH_EAST",
        angles = "awdd"
    },
    alidadesPurf = {
        startDir = "EAST",
        angles = "wa"
    },
    multiplicativeExal = {
        startDir = "SOUTH_EAST",
        angles = "waqaw"
    },
    additiveExal = {
        startDir = "NORTH_EAST",
        angles = "waaw"
    },
    compassesPurf = {
        startDir = "EAST",
        angles = "aa"
    },
}

local function cast(spellName)
    Staff.runPattern(spells[spellName].startDir, spells[spellName].angles)
end
local function pushNum(number)
    -- a crime against humanity
    local pattern = {"SOUTH_EAST", "aqaa"}
    for i = 1, number, 1 do
        pattern[2] = pattern[2] .. "w"
    end
    Staff.runPattern(pattern[1], pattern[2])
end


cast("introspection")
pushNum(10)
cast("retrospection")
print(textutils.serialise(Staff.getStack()))
cast("scribesGam")
print(textutils.serialise(Staff.getStack()))