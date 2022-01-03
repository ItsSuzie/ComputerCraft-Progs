-- creates the foundations of  a square build
-- at the current block the turtle is at,


-- at starting point, check if block below, if there is
-- a block below the turtle, mine out block, and then place
-- foundation block
-- move onto the next block

function placeFoundation(curItemSlot)
    -- if block below turtle, remove and replace
    if turtle.inspectDown() == true
    then
        turtle.digDown()
    end
    if turtle.inspect() == true
    then
        turtle.dig()
    end

    -- checs to see if current cursor in inv has a block
    -- if so, place block. otherwise move to next cursor
    if turtle.getItemCount() == 0
    then 
        -- increment to next slot
        curItemSlot[1] = curItemSlot[1] + 1
        turtle.select(curItemSlot[1])
    end
    turtle.placeDown()
end

function ifStartsOnGroundLevel()
    -- check if placed on ground level. if so, move up 1
    if turtle.inspectDown() == true
    then
        --  if blocs above, remove it
        if turtle.inspectUp() == true
        then 
            turtle.digUp()
        end
        -- move up
        turtle.up()
    end
end
    


function foundationLoop()
    -- Variables
    local xLength = 6
    local zLength = 4
    local yLength = 3

    -- item slots
    local curItemSlot = {1}



    -- foundation placer loop
    -- height
    for y = 0, yLength, 1
    do
        -- if turtle starts at ground level
        ifStartsOnGroundLevel()

        -- loop foundation placement
        -- 4 walls
        for i = 0, 1, 1
        do
            -- x walls
            for j = 0, xLength, 1
            do
                placeFoundation()
                turtle.forward()
            end

            turtle.turnRight()

            -- y walls
            for j = 0, zLength, 1
            do
                placeFoundation()
                turtle.forward()
            end

            -- turn the turtle
            turtle.turnRight()
        end
    end
end


foundationLoop()