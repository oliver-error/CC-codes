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
    reveal = {
        startDir = "NORTH_EAST",
        angles = "de"
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
    -- setup focus list
    cast("falseRefl")
    pushNum(1)
    cast("scribesRefl")
    pushNum(3)
    cast("flockGam")
        cast("reveal")
    cast("scribesGam")
    -- setup thoths executeable
    -- test if the spell has found alreday
    cast("introspection")
        cast("scribesRefl")
            cast("reveal")
        cast("flockDist")
        cast("rotationGam")
        cast("introspection")
            cast("charonsGam")
        cast("retrospection")
        cast("introspection")
        cast("retrospection")
        cast("augursExal")
        cast("hermesGam")
        -- get if target block air
            pushNum(1)
            cast("reveal")
            cast("novicesGam")
        cast("jestersGam")
        cast("geminiDecp")
        cast("mindsRefl")
        cast("alidadesPurf")
        cast("multiplicativeExal")
        cast("mindsRefl")
        cast("compassesPurf")
        cast("additiveExal")
        cast("sortersPurf")
        cast("rotationGam")
        cast("geminiDecp")
        cast("rotationGam")
        -- end loop logic
        cast("equlityDist")
        -- true logic
        cast("introspection")
            cast("trueRefl")
            cast("rotationGam")
            cast("rotationGam")
            pushNum(3)
            cast("flockGam")
            cast("scribesGam")
        cast("retrospection")
        -- false logic
        cast("introspection")
                pushNum(2)
                cast("reveal")
                cast("novicesGam")
            cast("jestersGam")
            pushNum(1)
            cast("additiveExal")
                pushNum(3)
                cast("reveal")
                cast("novicesGam")
            cast("jestersGam")
            cast("falseRefl")
            cast("rotationGam")
            cast("rotationGam")
            pushNum(3)
            cast("flockGam")
            cast("scribesGam")
        cast("retrospection")
        cast("augursExal")
        cast("hermesGam")
    cast("retrospection")
    -- setup thoths list
    pushNum(0)
    pushNum(31)
    cast("geminiGam")
    pushNum(31)
    cast("flockGam")
    cast("thothsGam")
    -- get data and interpret it
    cast("scribesRefl")
    cast("flockDist")
    cast("rotationGam")
    cast("introspection")
    cast("retrospection")
    cast("introspection")
    cast("charonsGam")
    cast("retrospection")
    cast("augursExal")
    cast("hermesGam")
        pushNum(4)
        cast("reveal")
        cast("novicesGam")
    cast("jestersGam")
    cast("mindsRefl")
    cast("jestersGam")
    cast("blink")
    cast("scribesGam")
    cast("novicesGam")
cast("retrospection")
cast("scribesGam")