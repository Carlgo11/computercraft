local args = {...}
local delay = 20
local direction -- 0 = Right, 1 = Left
local minFuelLevel = 200

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
  for i = 16,1,-1 do
    if turtle.getFuelLevel() > minFuelLevel then
      turtle.refuel()
      turtle.select(turtle.getSelectedSlot()+1)
    else
      break
    end
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

function checkGrowth()
  local success, data = turtle.inspectDown()
  if success then
    if data.name == "minecraft:wheat" then
      if data.metadata == 7 then
        return 1
      else
        --print("Not ready for harvest yet. "..data.metadata)
        return 0
      end
    else
      --print("name: "..data.name)
    end
  else
    return 1
  end
  return 0
end

function isRightItem()
  if turtle.getItemCount() > 0 then
    local data = turtle.getItemDetail()
    if data.name == "minecraft:wheat_seeds" then
      return true
    end
  end
  return false
end
if checkArgs() then
  return
end

function unloadAllItems()
  turtle.turnLeft()
  for i = 16,2,-1 do
    turtle.select(i)
    turtle.drop()
  end
  turtle.turnRight()
end

--checkFuel()
turtle.select(1)
for x=0, (args[2]-1) do
  for z=1, args[1] do
    while isRightItem() == false do
      if turtle.getSelectedSlot() == 16 then
        print("No items left.")
        print("Waiting "..delay.." seconds...")
        sleep(delay)
        turtle.select(1)
      else

        turtle.select(turtle.getSelectedSlot()+1)
      end
    end
    local growth = checkGrowth()
    if growth == 1 then
      turtle.digDown()
      turtle.placeDown()
    end
    if z < tonumber(args[1]) then
      if turtle.detect() then
        if not turtle.dig() then
          print("[error] Can't go forward.")
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
    unloadAllItems()
  end
end
