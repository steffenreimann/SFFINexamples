Speaker1 = component.proxy('BF5235264354E9825382BEA89C93AD54')
Speaker2 = component.proxy('A8B5685D4BD19C3E50FF028FD16F50F1')
pan = component.proxy('544D779941C0B561EC939A8D6BADDCCF')





local repS =  {}
repS.playing = true
repS.thread = {
 threads = {},
 current = 1
}

function repS.thread.create(func)
 local t = {}
 t.co = coroutine.create(func)
 function t:stop()
  for i,th in pairs(repS.thread.threads) do
   if th == t then
    table.remove(repS.thread.threads, i)
   end
  end
 end
 table.insert(repS.thread.threads, t)
 return t
end

function repS.thread:run()
 while true do
  if #repS.thread.threads < 1 then
   return
  end
  if repS.thread.current > #repS.thread.threads then
   repS.thread.current = 1
  end
  coroutine.resume(true, repS.thread.threads[repS.thread.current].co)
  repS.thread.current = repS.thread.current + 1
 end
end

function repS.play(components, file, startTime, duration)
        
    start = computer.millis()
    local function durationCheck()
        while repS.playing do
            
            now = computer.millis()
            print('duration '..now)
            if now - start >= duration then
                repS.stop(components)
            end
        end
    end
    local function mtplay()
        for _,component in pairs(components) do 
            component:playSound(file,startTime)
        end
        while repS.playing do
        
        event.ignoreAll()
        for _,component in pairs(components) do 
            event.listen(component)
        end
        local name, type, stat, idk = event.pull()
        print('stat')
        print(stat)
        if stat>1 then
            print('stat>1')
            for _,component in pairs(components) do
                component:playSound(file,startTime)
            end
        elseif stat == 1 then
            print('stat == 1')
            return 1
        end
    end
    end
    tPlay = repS.thread.create(mtplay)
    if duration ~= nil then
        tduration = repS.thread.create(durationCheck)
    end
    
    repS.thread.run()
end

function repS.stop(components)
    repS.playing = false
    repS.repetitions = 0
    for _,component in pairs(components) do 
        component:stopSound()
    end
end

function repS.setVolume(components, volume)
    for _,component in pairs(components) do 
        component:setVolume(volume)
    end
end

function repS.getVolume(components)
    local rArr = {}
    for _,component in pairs(components) do
        table.insert(rArr, component:getVolume())
    end
    return rArr
end

function repS.setRange(components, volume)
    for _,component in pairs(components) do 
        component:setVolume(volume)
    end
end

function repS.getRange(components)
    local rArr = {}
    for _,component in pairs(components) do
        table.insert(rArr, component:getRange())
    end
    return rArr
end

function repS.thread.sleep()
 event.pull(0.0)
end


--[[
not working now
speakers = component.proxy(component.findComponent("SpeakerPole"))
--]]

--[[
Playing File with duration
repS.play({Speaker1, Speaker2} ,'file', 0, 5000)
--]]

--[[
Playing File infinite ... is not currently repeated
repS.play({Speaker1, Speaker2} ,'file', 0)
--]]

repS.play({Speaker1, Speaker2} ,'1111', 0)


