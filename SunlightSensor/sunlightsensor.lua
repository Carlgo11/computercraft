local minlevel = 3
local offValue = false -- Redstone value to output when sunlight is less than the minlevel
local onValue = true -- Redstone value to output when sunlight is more than the minlevel
while true do
  os.pullEvent("redstone")
  sunlight = redstone.getAnalogInput("top")
  if sunlight > minlevel then
    if redstone.getOutput("left") ~= onValue then
      redstone.setOutput("left", onValue)
    end
  else
    if redstone.getOutput("left") ~= offValue then
      redstone.setOutput("left", offValue)
    end
  end
end
