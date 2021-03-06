local args = {...}
local delay = 20
local direction -- 0 = Right, 1 = Left

function checkArgs()
    if #args == 3 then
        if string.lower(args[3]) == "left" then
            direction = 1
        elseif string.lower(args[3]) == "right" then
            direction = 0
        end
    else
        print("Usage: <command> <x> <z> <direction>")
        return 1
    end
end

function checkFuel()
    while turtle.getFuelLevel() > minFuelLevel do
        turtle.refuel()
        turtle.select(turtle.getSelectedSlot()+1)
    end
end

function turnLeft()
    turtle.turnRight()
    turtle.forward()
    turtle.turnRight()
end

function turnRight()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
end

function doNormalTurn(x)
    if x % 2 == 0 then
        if direction == 0 then
            turnRight()
        else
            turnLeft()
        end
    else
        if direction == 0 then
            turnLeft()
        else
            turnRight()
        end
    end
end

function doFinalTurn(x)
    turtle.turnRight()
    turtle.turnRight()
    print("Done!")
end

if checkArgs() then
    return
end

turtle.select(1)
for x=0, (args[2]-1) do
    for z=1, args[1] do
        while turtle.getItemCount() == 0 do
            if turtle.getSelectedSlot() == 16 then
                print("No items left.")
                print("Waiting "..delay.." seconds...")
                sleep(delay)
                turtle.select(1)
            else
                turtle.select(turtle.getSelectedSlot()+1)
            end
        end
        turtle.placeDown()
        if z < tonumber(args[1]) then
            if turtle.detect() then
                if not turtle.dig() then
                    print("Can't go forward.")
                    return
                end
            end
            turtle.forward()
        end
    end
    if x < tonumber(args[2]-1) then
        doNormalTurn(x)
    else
        doFinalTurn(x)
    end
end
