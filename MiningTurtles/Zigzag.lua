-- Create a zigzag pattern with the mining turtle

-- variables
local torchPlacerPerBlock = 4
local curTorchLoop = 0
local maxTotalZigzagLen = 15

-- places torch
funciton placeTorch()
    turtle.back()
    turtle.back()
    turtle.down()
    turtle.place()
    turtle.up()
    turtle.forward()
    turtle.forward()
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

-- starting zigzag
function startZigZag()
    for i = 0, i maxTotalZigzagLen, 1
    do
        -- first line
        for j = 0, maxTotalZigzagLen, 1
        do
            mineForward()

            curTorchLoop = curTorchLoop + 1
            if curTorchLoop == torchPlacerPerBlock
            then
                placeTorch()
            end
        end
        
        -- turn right
        turnRight()

        -- 2nd line
        for j = 0, maxTotalZigzagLen, 1
        do
            mineForward()

            curTorchLoop = curTorchLoop + 1
            if curTorchLoop == torchPlacerPerBlock
            then
                placeTorch()
            end
        end

        -- turn left
        turnLeft()
    end
end


--------------
-- starting prog
--------------
turtle.digUp()
turtle.digDown()
startZigZag()

