local funnywindow = false
local funnywindowsmall = false

function setDefault(id)
    _G['defaultStrum'..id..'X'] = getActorX(id)
end

function start (song)
    showOnlyStrums = true
    for i=0,3 do
        tweenPosXAngle(i, _G['defaultStrum'..i..'X'] + 1250,getActorAngle(i), 0.5, 'setDefault')
    end
    for i =4,7 do 
        tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 275,getActorAngle(i), 0.5, 'setDefault')
    end
end

function update (elapsed)
    local currentBeat = (songPos / 1000)*(bpm/60)
    if funnywindow then
        setWindowPos(64 * math.sin(currentBeat * math.pi) + 327, 32 * math.sin(currentBeat * 3) + 160)
    end
    if funnywindowsmall then
        setWindowPos(8 * math.sin(currentBeat * math.pi) + 327, 4 * math.sin(currentBeat * 3) + 160)
    end
end

function stepHit(step)
    if curStep == 256 then
        funnywindowsmall = true
    end
    if curStep == 511 then
        funnywindowsmall = false
        funnywindow = true
    end
    if curStep == 1024 then
        funnywindow = false
        funnywindowsmall = true
    end
    if curStep == 1546 then
        funnywindowsmall = false
        funnywindow = true
    end
end