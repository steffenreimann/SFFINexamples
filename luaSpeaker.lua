Speaker1 = component.proxy('BF5235264354E9825382BEA89C93AD54')
Speaker2 = component.proxy('A8B5685D4BD19C3E50FF028FD16F50F1')


local repS =  {}
repS.playing = true
repS.repetitions = 0

function repS.play(components, file, startTime, repetitions)
    for _,component in pairs(components) do 
        component:playSound(file,startTime)
    end
    while repS.playing do
        event.ignoreAll()
        for _,component in pairs(components) do 
            event.listen(component)
        end
        local name, type, stat, idk = event.pull()
        if stat>1 then 
            repS.repetitions = repS.repetitions + 1
            for _,component in pairs(components) do 
                component:playSound(file,startTime)
            end
        elseif stat == 1 then
        --[[repS.stop(components)
            return 1--]]
        elseif repetitions ~= nil and repS.repetitions >= repetitions then
          --[[  print('Return in rep ')
            repS.stop(components)
            return 2--]]
        end
    end
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

function repS.getVolume(components, volume)
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

function repS.getRange(components, volume)
    local rArr = {}
    for _,component in pairs(components) do
        table.insert(rArr, component:getRange())
    end
    return rArr
end

--[[ getAllSpeakerNicks --]]
function repS.getASN(comps)
    print('comps')
    print(comps)
    local rArr = {}

    for _, comp in pairs(comps) do
        print('comp')
        print(comp)
        if comp == 'SpeakerPole' then
            
            table.insert(rArr, comp.nick)
        end
    end
    print('rArr')
    print(rArr)
    return rArr
end

speakers = component.proxy(component.findComponent("SpeakerPole"))

repS.play({Speaker1, Speaker2} ,'1111', 0) 
