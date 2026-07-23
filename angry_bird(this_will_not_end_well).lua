local screen = peripheral.wrap("top")

screen.clear()
screen.setCursorPos(1, 1)
screen.setTextScale(0.5)


for i = 1, screen.getSize(2), 1 do
    for i = 1, screen.getSize(1), 1 do
        screen.write("■")
    end
    screen.setCursorPos(1, i + 1)
end