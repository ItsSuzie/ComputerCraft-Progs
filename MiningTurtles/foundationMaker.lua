-- creates the foundations of  a square build
-- at the current block the turtle is at,


-- at starting point, check if block below, if there is
-- a block below the turtle, mine out block, and then place
-- foundation block
-- move onto the next block

function placeFoundation()
    -- if block below turtle, remove and replace
    if turtle.inspectDown() == true
    then
        turtle.digDown()
    end
    turtle.placeDown()
end

-- Variables
local xLength = 6
local yLength = 4

-- loop foundation placement
-- 4 walls
for i = 0, 1, 1
do
    -- x walls
    for j = 0, xLength, 1
    do
        placeFoundation()
    end

    turtle.turnRight()

    -- y walls
    for j = 0, yLength, 1
    do
        placeFoundation()
    end

    -- turn the turtle
    turtle.turnRight()

end