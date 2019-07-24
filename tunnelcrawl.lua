local tunnelLength = 20
local tunnelHeight = 3

-- blocknames to accumulate
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
local function isDesiredBlock(inspectFunc)
  return pickup[inspectFunc()]
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
local function digUp()
  turtle.digUp()
  os.sleep(.5) -- wait for gravel/sand/water/lava etc...
end
local function digAndReplaceUp()
  digUp()
  replaceBlock(turtle.placeUp)
  return true
end
local function digAndReplaceDown()
  turtle.digDown()
  replaceBlock(turtle.placeDown)
  return true
end
local function digSideAndReplace(startTurnFunc, endTurnFunc)
  startTurnFunc()
  if(isDesiredBlock(blockFrontName)) then 
    turtle.dig()
    digWhileGravelOrSand()
  end
  endTurnFunc()
  return true
end
local function digAndReplaceLeft()
  return digSideAndReplace(turtle.turnLeft, turtle.turnRight)
end
local function digAndReplaceRight()
  return digSideAndReplace(turtle.turnRight, turtle.turnLeft)
end
local function getDesiredBlockAndReplace(direction)
    if(direction == "up" and isDesiredBlock(blockUpName) then 
      return digAndReplaceUp()
    end
    if(direction == "down" and isDesiredBlock(blockDownName)) then 
      return digAndReplaceDown()
    end
    if(direction == "left") then 
      return digAndReplaceLeft()
    end
    if(direction == "right") then 
      return digAndReplaceRight()
    end
end

-- main
for 1, tunnelLength do
  digForward()
  getDesiredBlockAndReplace("down")

  for 1, tunnelHeight do
    getDesiredBlockAndReplace("left")
    getDesiredBlockAndReplace("right")
    digUp()
    turtle.up()
  end
    
end