math.randomseed(os.time())
Xoffset = -5
Yoffset = 52
Zoffset = 8
Alternate = true
local forestTile = false
local stoneTile = false
BlockSets = {
    grass = {"moss_block", "grass_block"},
    stone = {"terracotta", "brown_terracotta"},
    forest = {"coarse_dirt", "podzol"},
    water = {"water", "water"},
    empty = {"air", "air"}
}
Map = {}
local seeds = {"stone", "forest"}

local function tableShuffle(t)
    for i = #t, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i] -- Swap elements
    end
end

local function placeBlock(x, y, z, block)
    commands.exec("setblock " .. (Xoffset + x) .. " " .. (Yoffset + y) .. " " .. (Zoffset + z) .. " " .. block)
end

local function makeTile(x, y, z, tileType)
    for xb = 1, 3 do
        for zb = 1, 3 do
            if Alternate then
                placeBlock(xb + x, y, zb + z, BlockSets[tileType][1])
            else
                placeBlock(xb + x, y, zb + z, BlockSets[tileType][2])
            end
            Alternate = not Alternate
        end
    end
end

for x = 0, 8 do
    for y = 0, 8 do
        if not (x < 9 and y < 3) then
            table.insert(seeds, "empty")
        end
    end
end

tableShuffle(seeds)

for x = 0, 8 do
    for y = 0, 8 do
        if x < 9 and y < 3 then
            table.insert(Map, {"grass", x, y})
        else
            table.insert(Map, {seeds[x + y], x, y})
        end
    end
end

for index, value in ipairs(Map) do
    makeTile(value[2]*3, 0, value[3]*3, value[1])
end
