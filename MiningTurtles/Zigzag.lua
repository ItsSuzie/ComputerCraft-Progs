-- Create a zigzag pattern with the mining turtle

-- variables
curTorchLoop = 0
torchPlacerPerBlock = 8
local curItemSlot = 0
turtle.select(1)
-- local maxTotalZigzagLen = 15

-- if dig or place
local mineorPlace = "mine"

-- movement variables, for pathfinding back home
local zigzagDepth = 0
local zigzagWidth = 0
local curZZDepth = 0 -- z axis, forward and back
local curZZWidth = 0 -- x axis, left and right

local whenToReturnHomeInterval = 128
local moveCounter = 0

local lastMiningPositionX = 0
local lastMiningPositiony = 0
local lastMiningPositionz = 0

-- every zigzag you flip this toggle
-- 0 = forward, 1 = back
local mineDirection = 0

-- moving home and dig down
local digDown = "no"
local digDownAmount = 0

-- Tossing garbage
local tossGarbageAtBlockInterval = 64
local tossCounter = 0


local tossGarbage = "no"
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


-- pathfinding back home
local posX = 0  -- Left and right
local posY = 0  -- Up and down
local posZ = 0  -- forwards and back


-- The start of the program
function start()
    term.clear()
    term.setCursorPos(1,1)

    -- ask if we want to mine the blocks or place them
    -- io.write("Do you want to mine or place the blocks? [mine/place] ")
    io.write("Welcome to Minnie's zigzag mining tool!")
    -- mineorPlace = io.read()

    -- set depth and width to mine
    io.write("Rows: ")
    zigzagWidth = io.read()

    io.write("Columns: ")
    zigzagDepth = io.read()

    zigzagWidth = zigzagWidth - 1
    zigzagDepth = zigzagDepth - 2

    -- if the bot will toss garbage items
    -- io.write("Do you want to drop garbage blocks? [yes/no] ")
    -- tossGarbage = io.read()

    -- updates garbage counter
    tossCounter = 0
    
    -- ask if want to dig down
    -- io.write("Do you want me to return home and dig down? [yes/no] ")
    -- digDown = io.read()

    -- if digDown == "yes"
    -- then
    --     io.write("How deep do you want me to dig? ")
    --     digDownAmount = io.read()
    -- end

    -- Updates ui
    info()
    end

-- Create basic ui
function info()
    -- Sets up the UI
    term.clear()
    term.setCursorPos(1,1)
    

    print("---------------------------------------")
    print("Mining size: " .. zigzagWidth + 1 .. " Wide | by " .. zigzagDepth + 1 .. " Deep")
    print("Mode: " .. mineorPlace)

    
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

    -- counting when garbage will be tossed
    if tossGarbage == "yes"
    then
        print("Next garbage toss: " .. tossCounter .."/" .. tossGarbageAtBlockInterval)
    end

    if digDown == "yes"
    then
        print("Current dig down counter: " .. digDownAmount)
    end
    

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



-- **************************************
-- Zigzag placing code


-- turn the turtle right and mine
function floorturnRight()
    nextInvSlot()
    turtle.placeDown()
    turtle.turnRight()
    turtle.forward()
    turtle.turnRight()
end

-- turn left
function floorturnLeft()
    nextInvSlot()
    turtle.placeDown()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
end

-- mines forward
function floorForward()
    nextInvSlot()
    turtle.placeDown()
    turtle.forward()
end

function nextInvSlot()
    -- checs to see if current cursor in inv has a block
    -- if so, place block. otherwise move to next cursor
    if turtle.getItemCount() == 0
    then 
        -- increment to next slot
        curItemSlot = curItemSlot + 1
        print(curItemSlot)
        turtle.select(curItemSlot)
    end
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

function returnHome()
    -- rotate()

    -- Sets last mining position to return to
    lastMiningPositionX = curZZWidth
    lastMiningPositiony = posY
    lastMiningPositionZ = zigzagDepth

    step = 0
    for step = posY - 1, 0, -1 
    do
        turtle.up()
    end
    -- for step = posX - 1, 0, -1 do -- x axis
    for step = curZZWidth, 0, -1
    do
        turtle.forward()
    end
    turtle.turnLeft()
    -- for step = posZ - 1, 0, -1 do -- z axis
    for step = zigzagDepth, 0, -1
    do
        turtle.forward()
    end


    -- empty inventory
end

function returnToMiningLocation()
    step = 0
    for step = lastMiningPositiony, 0, -1 do
        turtle.up()
    end
    -- for step = posX - 1, 0, -1 do -- x axis
    for step = lastMiningPositionX, 0, -1
    do
        turtle.forward()
    end
    turtle.turnLeft()
    -- for step = posZ - 1, 0, -1 do -- z axis
    for step = lastMiningPositionZ, 0, -1
    do
        turtle.forward()
    end
end

-- *************************************
-- Zigzag mining


-- starting zigzag
function startZigZag()
    for i = 0, zigzagWidth, 1
    do
        zigzagForward()


        -- Updates z width
        curZZWidth = curZZWidth + 1

        --  if turtle as reached end of the program,
        -- return home and dig down
        if (mineDirection == 0 and curZZWidth == zigzagWidth and digDown == "yes")
        then
            if digDownAmount >= 1
            then
                digDownFromEnd()
                digDownAmount = digDownAmount - 1
            end
        end
        

        -- Updates ui
        info()
    end
end


function digDownFromEnd()
    -- loop return home
    turtle.turnLeft()
    for i = curZZWidth, 0, -1
    do
        turtle.forward()
    end
    -- reached home, turn right and restart program
    turtle.turnRight()
    turtle.digDown()
    turtle.down()
    turtle.digDown()
    turtle.down()
    turtle.digDown()
    turtle.down()
    

    curZZWidth = 0
    curZZDepth = 0

    -- Update ui
    info()
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
        if (mineorPlace == "mine") then
            mineForward()
        elseif (mineorPlace == "place") then
            floorForward()
        end



        -- Place torch down
        -- curTorchLoop = curTorchLoop + 1
        -- if mineDirection == 0
        -- then
        --     if curTorchLoop == torchPlacerPerBlock
        --     then
        --         placeTorch()
        --     end
        -- end


        
        -- Updates zigzag progress
        -- If going forward
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
                if (mineorPlace == "mine") then
                    turnRight()
                elseif (mineorPlace == "place") then
                    floorturnRight()
                end


            -- from return to forward
            elseif mineDirection == 1
            then
                mineDirection = 0

                -- turn drone left
                if (mineorPlace == "mine") then
                    turnLeft()
                elseif (mineorPlace == "place") then
                    floorturnLeft()
                end
            end
        end

        -- Update UI
        info()

        -- updates iteration for tossing garbage
        if tossCounter > tossGarbageAtBlockInterval
        then
            -- Check if the inventory is full
            checkFull()
            tossCounter = 0
        end
        tossCounter = tossCounter + 1


        -- todo, add retrun and dorp items funcion
    
        -- -- updates iteration when to return home
        -- if moveCounter > whenToReturnHomeInterval
        -- then
        --     returnHome()
        --     moveCounter = 0
        -- end
        -- moveCounter = moveCounter + 1

    end
end

-- Checks how many slots in the inventory are full
function checkFull()
    print("Tossing Garbage...")
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

-- stores all garbage to drop sadly
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
    elseif turtle.getItemDetail().name == "minecraft:cobbled_deepslate" then
        turtle.drop()
    elseif turtle.getItemDetail().name == "minecraft:tuff" then
        turtle.drop()
    elseif turtle.getItemDetail().name == "minecraft:granite" then
        turtle.drop()
    elseif turtle.getItemDetail().name == "minecraft:andesite" then
        turtle.drop()
    elseif turtle.getItemDetail().name == "minecraft:magma_block" then
        turtle.drop()
    end

end



--------------
-- starting prog
--------------

-- inits project
start()

-- starts digging
if (mineorPlace == "mine")  then
    turtle.digUp()
    turtle.digDown()
end
    startZigZag()

-- emptyInventory()

