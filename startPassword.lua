normalPullEvent = os.pullEvent
os.pullEvent = os.pullEventRaw
local clear = function()
local width, height = term.getSize()
term.clear()
term.setCursorPos(1,2)
for loop = 0, width do
    write("=")
end
term.setCursorPos(1, height)
for loop = 0, width do
    write("=")
end
term.setCursorPos(1,2)
end

local file = fs.open("pass.txt", "r")
local password = file.readAll()
file.close()

while true do
    input = read("*")
    if input == password then
        print("welcome")
        sleep(4)
        break
    end
    if input ~= password then
        write("incorrect, enter password: ")
    end
end
term.setCursorPos(1,1)
print("welcome to the mine operation enter 'help' for a list of commands")
clear()
