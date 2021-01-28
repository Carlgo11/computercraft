ports = {
  modem = "bottom",
  monitor = "left"
}
authorizedComputer = 49
monitor = peripheral.wrap(ports.monitor)
monitor.clear()
monitor.setCursorPos(1, 1)
lines = {}

function getTime()
  date = os.date("*t")
  hour = date.hour
  if hour < 10 then
    hour = "0" .. hour
  end
  min = date.min
  if min < 10 then
    min = "0" .. min
  end
  return hour .. ":" .. min
end

function getMonitorSize()
  local w, h = monitor.getSize()
  return {
    w = w,
    h = h
  }
end

size = getMonitorSize()

function writeHeader()
  monitor.setTextColor(colors.yellow)
  monitor.write("Door log:")
  monitor.setTextColor(colors.white)
end

function write(msg)
  table.insert(lines, msg)
  if #lines > size.h - 1 then
    table.remove(lines, 1)
  end
  monitor.clear()
  monitor.setCursorPos(1, 1)
  writeHeader()
  for _, line in pairs(lines) do
    local x_pos, y_pos = monitor.getCursorPos()
    monitor.setCursorPos(1, y_pos + 1)
    monitor.setTextColor(line[2])
    monitor.write(line[1])
    monitor.setCursorPos(size.w - 4, y_pos + 1)
    monitor.write(line[3])
    monitor.setTextColor(colors.white)
  end
end

rednet.open(ports.modem)
writeHeader()

while true do
  local id, data, protocol = rednet.receive(5)
  if id == authorizedComputer then
    event = data.event
    player = data.player

    if lines[#lines] ~= nil then
      old = string.sub(lines[#lines][1], 3)
      old_time = lines[#lines][3]
      old_event = lines[#lines][4]
    end

    if lines[#lines] == nil or player ~= old or getTime() ~= old_time or event ~= old_event then
      if event == "allowed" then
        write({"< " .. player, colors.green, getTime(), event})
      elseif event == "denied" then
        write({"! " .. player, colors.red, getTime(), event})
      elseif event == "exited" then
        write({"> " .. player, colors.orange, getTime(), event})
      end
    end
  end
end
