local minFuelLevel = 200 -- Lowest acceptable fuel level.

function checkFuel()
    while turtle.getFuelLevel() < minFuelLevel do
        turtle.turnRight()
        turtle.select(3)
        turtle.suck()
        turtle.refuel()
    end
end

function checkItems()
    for i=1, 2 do
        turtle.select(i)
        n = (64-turtle.getItemCount(turtle.getSelectedSlot()))
        if i == 1 and n ~= 0 then
            turtle.turnLeft()
            turtle.suck(n)
        end
        if i == 2 and n ~= 0 then
            turtle.turnRight()
            turtle.suckUp(n)
        end
    end
end

while true do
    if redstone.getAnalogInput("back") == 15 then
        checkItems()
        checkFuel()
        print("Making a wither...")
        turtle.select(1)
        turtle.forward()
        turtle.forward()
        turtle.down()
        turtle.place()
        turtle.up()
        turtle.place()
        turtle.turnLeft()
        turtle.forward()
        turtle.turnRight()
        turtle.place()
        turtle.select(2)
        turtle.up()
        turtle.place()
        turtle.turnRight()
        turtle.forward()
        turtle.turnLeft()
        turtle.place()
        turtle.down()
        turtle.select(1)
        turtle.turnRight()
        turtle.forward()
        turtle.turnLeft()
        turtle.place()
        turtle.up()
        turtle.select(2)
        turtle.place()
        turtle.down()
        turtle.turnLeft()
        turtle.forward()
        turtle.turnRight()
        turtle.back()
        turtle.back()
        redstone.setOutput("bottom", true)
        sleep(10) -- Time for spawning a Wither.
        redstone.setOutput("bottom", false)
    else
        sleep(20)
    end
end
