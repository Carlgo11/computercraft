local args = {...}
local direction

-- Print usage
if #args ~= 3 then
  print("Usage: harvest <x> <z> <left|right>")
  return
else
  -- left = 0; right = 1
  direction = argument == "right" and 1 or 0
end

function checkItem(item)
  for i = 1, 16 do
    if turtle.getItemDetail(i) ~= nil and turtle.getItemDetail(i).name == item then
      return turtle.select(i)
    end
  end
  return false
end

function checkGrowth()
  local _, data = turtle.inspectDown()
  return (data ~= nil and data.name == "minecraft:wheat" and data.metadata == 7)
end

function placeSeed()
  if checkItem("minecraft:wheat_seeds") then
    turtle.placeDown()
  end
end

function nextRow(z)
  if z % 2 == 0 then
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
  else
    turtle.turnRight()
    turtle.forward()
    turtle.turnRight()
  end
end

function turn(z)
  if (z) % 2 == 0 then
    turtle.turnLeft()
  else
    turtle.turnRight()
  end
end

for z = 1, args[2] do
  for x = 1, args[1] do
    -- Harvest fully grown wheat
    if checkGrowth() then
      turtle.digDown()
    end

    -- Place seed. Only successful if above dirt.
    placeSeed()

    if x == tonumber(args[1]) then
      if z == tonumber(args[2]) then
        -- Back up if odd z level
        if z % 2 ~= 0 then
          for i = 1, x do
            turtle.back()
          end
        end

        turn(z + direction - 1)
        for _ = 1, z - 1 do
          turtle.forward()
        end
        turn(z + direction - 1)
      else
        -- Turn facing specified direction to next x row
        nextRow(z + direction)
      end
    else
      while not turtle.forward() do
        turtle.dig()
      end
    end
  end
end
