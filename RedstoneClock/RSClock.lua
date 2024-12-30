-- variables
clockTimer = 1
redstonePos = "back"

function start()
    term.clear()
    term.setCursorPos(1,1)

    -- Ask user for clock time --
    io.write("Welcome to the redstone clock!\n")
    io.write("How many seconds do you want the clock to tick?\n> ")
    clockTimer = io.read()

    -- TODO: ask user for redstone position --
    io.write("\n\nWhere is the redstone output in relevence to this computer?")
    io.write("Possible options are: back, front, right, left, bottom, top. \n> ")
    redstonePos = io.read()
end

function doClock()
    while (true)
    do
    io.write("Redstone On...")
    redstone.setOutput(redstonePos, true)
    os.sleep(tonumber(clockTimer))
    io.write("Redstone Off...")
    redstone.setOutput(redstonePos, false)
    os.sleep(tonumber(clockTimer))
    end
end


start()
doClock()