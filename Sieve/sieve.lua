local no_items_delay = 20 -- Delay when no more items are found

function onNoMatch(name)
    print("'"..name.."' is not a broken ore.")
    turtle.dropUp()
end

function dropItems(exception)
    for i = 1,16 do
        turtle.select(i)
        if exception == turtle.getSelectedSlot() then
            turtle.transferTo(1)
        else
            turtle.drop()
        end
    end
end

function doCraft()
    local d = turtle.getItemCount(turtle.getSelectedSlot())/4
    turtle.transferTo(2, d)
    turtle.transferTo(5, d)
    turtle.transferTo(6, d)
    if turtle.craft() then
        for i=1,16 do
            turtle.select(i)
            local crafted_item = turtle.getItemDetail()
            if crafted_item then
                local output_name = string.lower(crafted_item.name)
                if string.match(output_name, "broken") then
                    turtle.drop()
                else
                    turtle.turnLeft()
                    turtle.turnLeft()
                    turtle.drop()
                    turtle.turnLeft()
                    turtle.turnLeft()
                end
            end
        end
    else
        dropItems(0)
    end
end

function onSearch()
    skip_slot = 0
    
    for i=1,16 do
        turtle.select(i)
        if turtle.getItemCount() == 0 then
            turtle.suck()
        end
        data = turtle.getItemDetail(turtle.getSelectedSlot())
        if data then
            name = string.lower(data.name)
            if string.match(name, "broken") then
                if turtle.getItemCount() >= 4 then
                    skip_slot=turtle.getSelectedSlot()
                    break
                end
            else
                onNoMatch(name)
                i=i-1
            end
        else
            print("No more items found.")
            sleep(no_items_delay)
            break
        end
    end
    
    dropItems(skip_slot)
    if skip_slot ~= 0 then
        return true
    end
end

while true do
    if onSearch() then
        turtle.select(1)
        local data = turtle.getItemDetail(turtle.getSelectedSlot())
        if data then
            name = string.lower(data.name)
            if string.match(name, "broken") then
                if turtle.getItemCount() >= 4 then
                    doCraft()
                else
                    onSearch()
                end
            else
                onNoMatch(name)
            end
        else
            print("No item found in slot "..turtle.getSelectedSlot()..".")
        end
    end
end
