args = {...}
if #args ~= 2 then
    print("Usage: <command> <x> <z>")
    return
end
turtle.select(1)
for x=0, args[2] do
    for z=1, args[1] do
        while turtle.getItemCount(turtle.getSelectedSlot()) == 0 do
            if turtle.getSelectedSlot() == 16 then
                print("No items left.")
                print("Waiting 20 seconds...")
                sleep(20)
                turtle.select(1)
            else
                turtle.select(turtle.getSelectedSlot()+1)
            end
        end
        turtle.placeDown()
        turtle.forward()
    end
    if x % 2 == 0 then
        turtle.turnRight()
        turtle.forward()
        turtle.turnRight()
    else
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()
    end
    turtle.forward()
end
