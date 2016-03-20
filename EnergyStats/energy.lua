local refreshRate = 1 -- Refresh rate. Counted in seconds
local prevEnergyStored = 0 -- Previous Energy Stored
local diff = 0
local side = {"bottom", "up", "back", "right", "left"}

local function findModem()
    for k,v in pairs(side) do
        local p = peripheral.wrap(v)
        if (p) then
            if (string.find(p.getNamesRemote(v)[1],"draconic")) then
                return {p.getNamesRemote(v)[1], v, p}
            end
        end
    end
    if modemSide == nil then
        exit("No modem found.")
    end
    return nil
end

local function comma_value(amount)
    local formatted = amount
    local k = 0
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end

local function getEnergyStored()
    return modem.callRemote(modemName, "getEnergyStored")
end

local function getMaxEnergyStored()
    return modem.callRemote(modemName, "getMaxEnergyStored")
end

local function displayInfo()
    while true do
        local energyStored = getEnergyStored()
        local maxEnergy = getMaxEnergyStored()
        local percent = energyStored/maxEnergy*100
        diff = (energyStored - prevEnergyStored)/(refreshRate*20)
        term.clear()
        term.setCursorPos(1,1)
        print("Max Energy: \n\t"..comma_value(maxEnergy))
        print("Current Energy: \n\t"..comma_value(energyStored).." ("..percent.."%)\n")
        if (diff > 0) then
            io.write("\tAvg. RF/t: ")
            term.setTextColor(colors.green)
            io.write("+"..comma_value(diff))
            term.setTextColor(colors.white)
        else
            io.write("\tAvg. RF/t: ")
            term.setTextColor(colors.red)
            io.write("-"..comma_value(diff))
            term.setTextColor(colors.white)
        end
        prevEnergyStored = energyStored
        os.sleep(refreshRate)
    end
end

local m = findModem()
local modemName = m[1]
local modemSide = m[2]
local modem = m[3]

displayInfo()
