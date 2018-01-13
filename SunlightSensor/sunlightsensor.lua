local minlevel = 3
local offValue = 0 -- Redstone value to output when sunlight is less than the minlevel
local onValue = 15 - Redstone value to output when sunlight is more than the minlevel

local time
while true do
  os.pullEvent("redstone")
  sunlight = redstone.getAnalogInput("top")
  print(sunlight) -- Prints sunlight level
  if sunlight > minlevel then
    if redstone.getAnalogOutput("left") ~= onValue then
      redstone.setAnalogOutput("left", onValue)
    end
  else
    if redstone.getAnalogOutput("left") ~= offValue then
      redstone.setAnalogOutput("left", offValue)
    end
  end
end
