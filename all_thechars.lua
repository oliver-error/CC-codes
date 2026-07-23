local function numberToChar(num)
    -- Input validation
    if type(num) ~= "number" or num < 0 or num > 0x10FFFF then
        return nil, "Invalid code point. Must be a number between 0 and 1114111 (0x10FFFF)."
    end

    -- Convert number to character
    local success, char = pcall(string.char, num)
    if not success then
        return nil, "Conversion failed. Possibly invalid code point for this Lua build."
    end

    return char
end

local text = ""

for i = 3, 1, 10000 do
  text = text..numberToChar(i)
end
print(text)