function getItems(slot, item_name)
    while (64-turtle.getItemCount(slot)) ~= 0 do
        items = (64-turtle.getItemCount(slot))
        turtle.select(16)
        turtle.suck(items)
        if turtle.getItemCount(16) ~= 0 then
            if turtle.getItemDetail(16).name == item_name then
                turtle.transferTo(slot)
            end
        else
            print("[Error] No items found to pull")
            sleep(30)
        end
    end
end

while true do
    getItems(1, "minecraft:stone")
    getItems(2, "minecraft:stone")
    getItems(5, "minecraft:stone")
    getItems(6, "minecraft:stone")
    turtle.select(15)
    turtle.craft(64)
    if not turtle.dropUp() then
        print("[Error] Unable to move crafted material to external inventory")
        sleep(5)
        os.shutdown()
    end
end
