args = {...}
if #args ~= 5 then
    print("Usage: <command> <sensor_position> <redstone_position> <accesslevel> <group> <url>")
    return
end

-- Edit the settings below
local sensor_position = args[1]
local redstone_position = args[2]
local accesslevel = tonumber(args[3])
local group = args[4]


-- Advanced settings
local sensor = peripheral.wrap(sensor_position)
local url = args[5]
local version = "1.2"
local redstone_closedstate=true
local redstone_openstate=false
local delay = 3
local info =
{
    ["ID"] = os.getComputerID(),
    ["Rednet"] = tostring(rednet.isOpen()),
    ["AccessLevel"] = accesslevel,
    ["Group/Table"] = group,
    ["Sensor position"] = sensor_position,
    ["Redstone position"] = redstone_position
}

-- Functions
function setTextColor(color_code)
    if term.isColor() then
        term.setTextColor(color_code) 
    end
end

function startupText()
    setTextColor(32)
    print("Starting DoorAPI v"..version)
    print("")
    setTextColor(16)
    print("--- INFO ---")
    print("")
    setTextColor(1)
    for k,v in pairs(info) do
        print(k..": "..v)
    end
    print("")
    setTextColor(16)
    print("--- [END INFO] ---")
    print("")
    setTextColor(16384)
end

function listenForPlayer()
    print("Listening for players...")
    while true do
        redstone.setOutput(redstone_position, redstone_closedstate)
        players = sensor.getPlayers()
        for _, player in pairs(players) do
            local headers = {
                ["User-agent"] = "Carlgo11 Browser 1.0"
            }
            responce = 0
            if accesslevel ~= 0 then
                request = http.get(url.."?player="..player["name"].."&group="..group, headers)
                responce = tonumber(request.readAll())
            end
            if type(responce) == "number" then
                if responce >= accesslevel then
                    redstone.setOutput(redstone_position, redstone_openstate)
                    sleep(delay)
                end
            else
                print("[Error] Repsonce: "..request.readAll())
            end
        end
    end
end

-- Load functions
startupText()
listenForPlayer()
