local function inspectBlock()
 local success,blk = turtle.inspect()
 if(success) then
     return blk.name
 else
     return "none/air"
 end
end

while true do
    press, key = os.pullEvent()
    
    if(press == "key_up") then
    
        if(press == "key_up" and key == keys.q) then
        break
        
        elseif(key == keys.space) then
            print("Space")
            turtle.dig()
            print(inspectBlock())
                
        elseif(key == keys.a) then
            print("Left")
            turtle.turnLeft()
            print(inspectBlock())
        
        elseif(key == keys.d) then
            print("Right")
            turtle.turnRight()
            print(inspectBlock())
            
        elseif(key == keys.s) then
            print("Back")
            turtle.back()
            print(inspectBlock())
            
        elseif(key == keys.w) then 
            print("Forward")
            turtle.forward()
            print(inspectBlock())

        elseif(key == keys.e) then
            print("Up")
            turtle.up()    
            print(inspectBlock())

        elseif(key == keys.x) then
            print("Down")
            turtle.down()
            print(inspectBlock())
            
        elseif(key == keys.z) then 
            print(inspectBlock())

        elseif(key == keys.f) then 
            print("Fuel: "..turtle.getFuelLevel())

        else
            if(press ~= nil and key ~= nil) then
                print("press: "..press.." key: "..key)
            end
        end
    end
end