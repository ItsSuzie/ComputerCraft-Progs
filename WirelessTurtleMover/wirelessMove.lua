function start()
    while (true)
    do
        moveForwards()
        wait(1000)
        moveBack()
        wait(1000)
    end
end

function moveForwards()
    turtle.forward()
end

function moveBack()
    turtle.back()
end

start()