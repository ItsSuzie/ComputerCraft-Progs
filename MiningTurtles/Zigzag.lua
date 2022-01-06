-- Create a zigzag pattern with the mining turtle

-- variables
local curTorchLoop = 0
local torchPlacerPerBlock = 8
-- local maxTotalZigzagLen = 15
local zigzagDepth = 0
local zigzagWidth = 0
local curZZDepth = 0
local curZZWidth = 0

-- every zigzag you flip this toggle
-- 0 = forward, 1 = back
local mineDirection = 0

local tossGarbage = ""
local garbageItems = {}
garbageItems[1] = "minecraft:cobblestone"
garbageItems[2] = "minecraft:stone"
garbageItems[3] = "minecraft:dirt"
garbageItems[4] = "minecraft:gravel"
garbageItems[5] = "chisel:marble2"
garbageItems[6] = "chisel:limestone2"
garbageItems[7] = "minecraft:netherrack"
garbageItems[8] = "natura:nether_tainted_soil"
garbageItems[9] = "minecraft:diorite"



-- The start of the program
function start()
    term.clear()
    term.setCursorPos(1,1)

    -- set depth and width to mine
    io.write("Rows: ")
    zigzagWidth = io.read()

    io.write("Columns: ")
    zigzagDepth = io.read()

    zigzagWidth = zigzagWidth - 1
    zigzagDepth = zigzagDepth - 1

    -- if the bot will toss garbage items
    io.write("Do you want to drop garbage blocks? [yes/no]")
    tossGarbage = io.read()

    -- Updates ui
    info()
    end

-- Create basic ui
function info()
    -- Sets up the UI
    term.clear()
    term.setCursorPos(1,1)
    

    print("---------------------------------------")
    print("Mining size: " .. zigzagWidth .. " Wide | by " .. zigzagDepth .. " Deep")

    
    -- Prints current mining progress
    print("")
    if mineDirection == 0 then print("Mining forward...")
    elseif mineDirection == 1 then print("Returning...") end
    print("Current progress | Column: " .. curZZDepth .. " | Row: ".. curZZWidth)
    
    -- prints off the fuel level to the console
    print("")
    print("Fuel level: " .. turtle.getFuelLevel())

    -- Printing if garbage iwll be tossed
    print("")
    print("Will garbage be tossed? " .. tossGarbage)


end


-- **************************************
-- Zigzag mining code

-- places torch down
function placeTorch()
    turtle.select(1)
    turtle.placeDown()
    curTorchLoop = 0
end

-- turn the turtle right and mine
function turnRight()
    turtle.turnRight()
    turtle.dig()
    turtle.forward()
    turtle.digUp()
    turtle.digDown()
    turtle.turnRight()
end

-- turn left
function turnLeft()
    turtle.turnLeft()
    turtle.dig()
    turtle.forward()
    turtle.digUp()
    turtle.digDown()
    turtle.turnLeft()
end

-- mines forward
function mineForward()
    turtle.dig()
    turtle.forward()
    turtle.digUp()
    turtle.digDown()
end

-- Iterate through each slot of the inventory and drop it into the chest below it
function emptyInventory(startingSlot)
    -- do pathfinding stuff here or before in another function

    -- loop through each indext in the inventory and drop item
    for i = startingSlot, 16, 1
    do
        turtle.select(i)
        turtle.dropDown()
    end

    turtle.select(1)
end


-- *************************************
-- Zigzag mining


-- starting zigzag
function startZigZag()
    for i = 0, zigzagWidth, 1
    do
        zigzagForward()

        curZZWidth = curZZWidth + 1
        info()
        -- -- every loop set a flag, if 0, go forward, if 1 go back
        -- if mineDirection == 0 then zigzagForward() end

        -- if mineDirection == 1 then zigzagReturn() end
    end
end


-- going forward
function zigzagForward()
     -- first line
    for j = 0, zigzagDepth, 1
    do



        -- If first time runing, set this run to 0
        if j == 0
        then
            if mineDirection == 0
            then
                curZZDepth = 0
            
            elseif mineDirection == 1
            then
                print()
                curZZDepth = zigzagDepth
            end
        end

        -- Mine forward
         mineForward()



        -- Place torch down
        curTorchLoop = curTorchLoop + 1
        if curTorchLoop == torchPlacerPerBlock
        then
            placeTorch()
        end


        
        -- Updates zigzag progress
        if mineDirection == 0
        then
            curZZDepth = curZZDepth + 1

        elseif mineDirection == 1
        then
            curZZDepth = curZZDepth - 1
        end



        -- Checs if end
        if j == zigzagDepth
        then
            -- Set new mine direction - from forward to return
            if mineDirection == 0
            then
                mineDirection = 1
                
                -- turns drone right
                turnRight()


            -- from return to forward
            elseif mineDirection == 1
            then
                mineDirection = 0

                -- turn drone left
                turnLeft()
            end
        end

        -- Update UI
        info()

        -- Check if the inventory is full
        checkFull()
    end
end

-- Checks how many slots in the inventory are full
function checkFull()
    if tossGarbage == "yes"
    then
        fullSlots = 0
        local search = 0
    
        -- Iterate though all inventory slots
        for search = 16, 2, -1
        do
            -- At each iteration check if current inventory slot is full
            turtle.select(search)
            if turtle.getItemCount() > 0
            then
                -- -- for key, value in pairs(garbageItems)
                -- for index, value in ipairs(garbageItems)
                -- do
                --     -- print(key .. " -- " .. value)
                --     -- if item exists in garbage itms list, then drop item
                --     -- if turtle.getItemDetail().name == value
                --     -- then
                --     --     print("Dropping " .. value)
                --     --     turtle.drop()
                --     -- end
                -- end

                -- forgoing for loop fo rnow, doing function
                dropGarbage()
            end
            if turtle.getItemCount() > 0 then
                fullSlots = fullSlots + 1
            end
        end
        if fullSlots == 16 then
            empty()
        end
    end
end


function dropGarbage()

    if turtle.getItemDetail().name == "minecraft:cobblestone" then
        turtle.drop()
    elseif turtle.getItemDetail().name == "minecraft:stone" then
        turtle.drop()
    elseif turtle.getItemDetail().name == "minecraft:dirt" then
        turtle.drop()
    elseif turtle.getItemDetail().name == "minecraft:gravel" then
        turtle.drop()
    elseif turtle.getItemDetail().name == "chisel:marble2" then
        turtle.drop()
    elseif turtle.getItemDetail().name == "chisel:limestone2" then
        turtle.drop()
    elseif turtle.getItemDetail().name == "minecraft:netherrack" then
        turtle.drop()
    elseif turtle.getItemDetail().name == "natura:nether_tainted_soil" then
        turtle.drop()
    elseif turtle.getItemDetail().name == "minecraft:diorite" then
        turtle.drop()
    end

end



--------------
-- starting prog
--------------

-- inits project
start()

-- starts digging
turtle.digUp()
turtle.digDown()
startZigZag()

-- emptyInventory()

