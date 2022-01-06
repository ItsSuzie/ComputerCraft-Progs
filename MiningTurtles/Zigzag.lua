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

    -- prints off the fuel level to the console
    print("")
    print("Fuel level: " .. turtle.getFuelLevel())

    -- Prints current mining progress
    print("")
    if mineDirection == 0 then print("Mining forward...")
    elseif mineDirection == 1 then print("Returning...") end
    print("Current progress | Column: " .. curZZDepth .. " | Row: ".. curZZWidth)

end


-- **************************************
-- Zigzag mining code

-- places torch down
function placeTorch()
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
                print("Mining forwards...")
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
    end
end


-- -- The return trip
-- function zigzagReturn()
--     -- 2nd line
--     for j = 0, zigzagDepth, 1
--     do
--         -- If first time running, set to max
--         if j == zigzagDepth
--         then
--             curZZDepth = curZZDepth - 1
--         end

--         mineForward()

--         -- Place torch down
--         curTorchLoop = curTorchLoop + 1
--         if curTorchLoop == torchPlacerPerBlock
--         then
--             placeTorch()
--         end

--         -- Checs if end
--         if j == zigzagDepth
--         then
--             mineDirection = 0

--             -- turn drone left
--             turnLeft()
--         end

--         -- update current zz progress
--         curZZDepth = curZZDepth - 1

--         -- Update UI
--         info()
--     end
-- end

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

