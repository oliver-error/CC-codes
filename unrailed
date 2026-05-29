Xoffset = -5
Yoffset = 52
Zoffset = 8
Alternate = true
BlockSets = {
    grass = {"moss_block", "grass_block"},
    stone = {"terracotta", "brown_terracotta"},
    forest = {"coarse_dirt", "podzol"},
    water = {"water", "water"},
}

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

for x = 1, 7 do
    for y = 1, 7 do
        makeTile(x*3, 0, y*3, "grass")
    end
end