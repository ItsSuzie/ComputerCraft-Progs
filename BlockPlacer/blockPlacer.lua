-- This program will place blocks down
--  in a straight line.
-- Populate the first slots with what item you want to place.
-- It will destroy any blocks in front and replace with new block.

-- Variables
local blockPlaceColumnDistance = 0     -- how far to move the turtle
local curBlockColumnDistance = 0       -- the current distance moved
local slotUsage = 1
local curSlot = 1

-- Tossing garbage
local tossGarbageAtBlockInterval = 64
local tossCounter = 0
local tossGarbage = ""



-- Start of the program
function start()
    term.clear()
    term.setCursorPos(1,1)

    -- Set the depth, column distance to mine
    io.write("How far out to place blocks: ")
    blockPlaceColumnDistance = io.read()
    blockPlaceColumnDistance = tonumber(blockPlaceColumnDistance)
    
    -- Determine how many slots to use for the block placing
    if (blockPlaceColumnDistance > 64)
    then
        slotUsage = math.floor(blockPlaceColumnDistance/64)
    end
    -- Do this after math
    blockPlaceColumnDistance = blockPlaceColumnDistance - 1
 
    
    io.write("Do you want to drop garbage blocks if any digged up?")
    io.write("Ideal if placing blocks in long distances: [yes/no]")
    tossGarbage = io.read()


    -- Setting up the inventory
    turtle.select(1)
end


function info()
    -- Sets up the UI
    term.clear()
    term.setCursorPos(1,1)


    print("---------------------------------------")
    print("Placing ".. blockPlaceColumnDistance .. " blocks forward")

    -- Prints current placing progress
    print("")
    print("Current progress: " .. curBlockColumnDistance .. "/" .. blockPlaceColumnDistance)
    print("Current inventory slot: " .. curSlot)
    print("Max inventory slots to be used: " .. slotUsage)

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
end


-- Runs every update of the program 
function Update()
    -- If we havent reached the end yet
    while (curBlockColumnDistance <= blockPlaceColumnDistance)
    do
        --  Update ui info
        info()

        -- if block exists in front, remove it
        if (turtle.detect())
        then
            removeBlockInFront()
        end
        -- move forward
        turtle.forward()

        -- place block down
        placeBlock()

        curBlockColumnDistance = curBlockColumnDistance + 1
    end

end

-- Places block below
function placeBlock()
    
    -- If current slot is empty, move onto next slot
    if (turtle.getItemCount() == 0)
    then
        curSlot = curSlot + 1
        turtle.select(curSlot)
    end

    
    -- If block exists below, remove block, then place block
    if(turtle.detectDown())
    then
        turtle.digDown()
    end

    -- place block


    turtle.placeDown()
end

function removeBlockInFront()
    turtle.dig()
end

start()
Update()