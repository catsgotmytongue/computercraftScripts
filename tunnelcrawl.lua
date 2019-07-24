local tunnelLength = 20
local pickup = {
    ["air"] = false,
    ["block"] = false, 
    ["gravel"] = false,
    ["ore"] = true
}
local function getBlockName(blk)
    "minecraft"

    return blk.name
end
local function inspectBlock(blockFunc)
    local success,blk = blockFunc()
    if(success) then
        return getBlockName(blk)
    end
end
local function blockDownName()
    return inspectBlock(turtle.inspectDown)
end
local function blockFrontName()
    return inspectBlock(turtle.inspect)
end
local function blockUpName(turtle.inspectUp)
    return inspectBlock(turtle.inspectUp)
end
local function digForward()
    turtle.dig()
    turtle.forward()
end
local function getReplacementSlot()
-- find a replacement material like cobble
end
local function replaceBlock(placeFunc)
    local selectedSlot = turtle.getSelectedSlot()
    turtle.select( getReplacementSlot() )
    placeFunc()
    turtle.select(selectedSlot)
    return true
end
local function digWhileGravelOrSand()
-- dig until we should stop
end
local function getDesiredBlockAndReplace(direction)
    if(direction == "up" and pickup[blockUpName()]) then 
        turtle.digUp()
        os.sleep(.5) -- wait for gravel/sand/water/lava etc...
        replaceBlock(turtle.placeUp)
        return true
    end
    if(direction == "down" and pickup[blockDownName()]) then 
        turtle.digDown()
        replaceBlock(turtle.placeDown)
        return true
    end
    if(direction == "left") then 
        turtle.turnLeft()
        if(pickup[blockFrontName()]) then 
            turtle.dig()
            digWhileGravelOrSand()
        end
        turtle.turnRight()
        return true
    end
    if(direction == "right") then 
        turtle.turnRight()
        if(pickup[blockFrontName()]) then 
            turtle.dig()
            digWhileGravelOrSand()
        end
        turtle.turnLeft()
        return true
    end
end

-- main
for 1, tunnelLength do
    digForward()

    getDesiredBlockAndReplace("down")
    getDesiredBlockAndReplace("left")
    getDesiredBlockAndReplace("right")
    
    getDesiredBlockAndReplace("up")
    
end