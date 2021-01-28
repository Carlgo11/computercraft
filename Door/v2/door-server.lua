local ports = {
  input = "right",
  output = "bottom",
  radar = "left",
  modem = "back",
  exit = "front"
}
range = 4
sleepTime = 1
playerFile = "players.txt"
monitorID = 59
agent = "TCP/InternetPiston"
radar = peripheral.wrap(ports.radar)
modem = rednet.open(ports.modem)

function loadPlayers(playerFile)
  local file = fs.open(playerFile, "r")
  local players = {}
  while true do
    local player = file.readLine()
    if player == nil then
      return players
    end
    table.insert(players, player)
  end
end

function open()
  redstone.setOutput(ports.output, true)
end

function close()
  redstone.setOutput(ports.output, false)
end

function containsItem(_array, item)
  for _, value in pairs(_array) do
    if value == item then
      return true
    end
  end
end

function checkPlayers(auth)
  players = radar.getPlayers()
  for _, player in pairs(players) do
    if player.distance < range then
      if auth then
        if containsItem(allowed, player.name) then
          rednet.send(
            monitorID,
            {
              player = player.name,
              event = "allowed"
            },
            agent
          )
          return true
        else
          rednet.send(
            monitorID,
            {
              player = player.name,
              event = "denied"
            },
            agent
          )
        end
      else
        rednet.send(
          monitorID,
          {
            player = player.name,
            event = "exited"
          },
          agent
        )
        return true
      end
    end
  end
  return false
end

allowed = loadPlayers(playerFile)

-- main
while true do
  close()
  -- Wait for redstone event
  local _, event = os.pullEvent("redstone")
  -- Make sure even is triggered by the plates
  if redstone.getInput(ports.input) then
    while checkPlayers(true) do
      open()
      sleep(sleepTime)
    end
  elseif redstone.getInput(ports.exit) then
    while checkPlayers(false) do
      open()
      sleep(sleepTime)
    end
  end
end
