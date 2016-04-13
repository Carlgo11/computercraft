--[[
   Wither spawning script
   Public domain source code created by Carlgo11
   For more information on the code and variables please visit https://github.com/Carlgo11/computercraft/tree/master/WitherSpawner
]]--

local minFuelLevel = 200 -- Lowest acceptable fuel level.
local redstone_input_pos = "back" -- Redstone position (on for making wither)
local redstone_output_pos = "bottom" --Redstone position (on for protecting the area while spawning the wither)
local wither_spawning_delay = 10 -- Delay before spawning a new wither. (10 if the wither is killed instantly on spawning)
local sleep_delay = 20 -- Delay before checking redstone_output_pos again.
local isDebug = false

function checkFuel()
    while turtle.getFuelLevel() < minFuelLevel do
        turtle.turnRight()
        turtle.select(3)
        turtle.suck()
        turtle.refuel()
        turtle.turnLeft()
    end
end

function checkItems()
    for i=1, 2 do
        turtle.select(i)
        n = (64-turtle.getItemCount(turtle.getSelectedSlot()))
        if i == 1 and n ~= 0 then
            turtle.turnLeft()
            turtle.suck(n)
            turtle.turnRight()
        end
        if i == 2 and n ~= 0 then
            turtle.suckUp(n)
        end
    end
end

function waitOnSpawning()
    redstone.setOutput(redstone_output_pos, true)
    sleep(wither_spawning_delay) 
    redstone.setOutput(redstone_output_pos, false)
end

function debugMessage(message)
    if isDebug then
        print(message)
    end
end

while true do
    if redstone.getAnalogInput(redstone_input_pos) == 15 then
        checkItems()
        checkFuel()
        debugMessage("making a wither...")
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
        waitOnSpawning()
        term.clear()
        term.setCursorPos(1,1)
    else
        sleep(sleep_delay) -- Wait on redstone signal
    end
end
