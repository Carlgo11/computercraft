materials = {
  ceiling = "minecraft:stonebrick",
  floor = "chisel:basalt2",
  left_wall = "minecraft:stonebrick",
  right_wall = "minecraft:stonebrick"
}

dimensions = {
  x = 4,
  y = 4
}

function replace(direction, name)
  for i = 1, 16 do
    if turtle.getItemDetail(i) ~= nil and turtle.getItemDetail(i).name == name then
      turtle.select(i)
      if direction == nil then
        local _, data = turtle.inspect()
        if data.name ~= name then
          turtle.dig()
          turtle.place()
        end
        return
      elseif direction == "up" then
        local _, data = turtle.inspectUp()
        if data.name ~= name then
          turtle.digUp()
          turtle.placeUp()
        end
        return
      elseif direction == "down" then
        local _, data = turtle.inspectDown()
        if data.name ~= name then
          turtle.digDown()
          turtle.placeDown()
        end
        return
      elseif direction == "left" then
        turtle.turnLeft()
        replace(nil, name)
        turtle.turnRight()
        return
      elseif direction == "right" then
        turtle.turnRight()
        replace(nil, name)
        turtle.turnLeft()
        return
      end
    elseif i == 16 then
      print("Out of " .. name)
      os.exit() -- Throws exception in CC :shrug:
    end
  end
end

args = {...}

-- Check if z iterations is available
if tonumber(args[1]) == nil then
  print("Usage: <command> <length>")
  return
end

for z = 1, args[1] do
  -- Check fuel
  if turtle.getFuelLevel() < 19 then
    print("Need food :(")
    return
  end

  -- horisontal (x) digging
  for h = 1, dimensions.x do
    -- vertical (y) digging
    for v = 1, dimensions.y do
      turtle.dig()

      -- Left wall
      if h == 1 then
        replace("left", materials.left_wall)
      end

      -- Right wall
      if h == 4 then
        replace("right", materials.right_wall)
      end

      -- Ceiling
      if (v == 1 and h % 2 == 0) or (v == 4 and h % 2 ~= 0) then
        replace("up", materials.ceiling)
      end

      -- Floor
      if (v == 1 and h % 2 ~= 0) or (v == 4 and h % 2 == 0) then
        replace("down", materials.floor)
      end

      -- Go up if odd row number, down if even
      if h % 2 == 0 then
        turtle.down()
      else
        turtle.up()
      end
    end

    -- Go to first row
    if h == dimensions.x then
      turtle.turnLeft()

      -- Go back to starting x pos
      for a = 1, dimensions.x do
        turtle.forward()
      end

      turtle.turnRight()

      -- Go down to starting y pos if odd x number
      if dimensions.x % 2 ~= 0 then
        for b = 1, dimensions.y do
          turtle.down()
        end
      end

      -- Go forward to new z pos
      turtle.forward()
    else
      -- Next row
      turtle.turnRight()
      turtle.forward()
      turtle.turnLeft()
    end
  end
end
