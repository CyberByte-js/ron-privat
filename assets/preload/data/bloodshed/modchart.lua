local funnywindow = false
local funnywindowsmall = false
local NOMOREFUNNY = false
local daNoteMove = false

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
        setWindowPos(127 * math.sin(currentBeat * math.pi) + 327, 127 * math.sin(currentBeat * 3) + 160)
    end
    if funnywindowsmall then
        setWindowPos(24 * math.sin(currentBeat * math.pi) + 327, 24 * math.sin(currentBeat * 3) + 160)
    end
    if NOMOREFUNNY then
        setWindowPos(0 * math.sin(currentBeat * math.pi) + 327, 0 * math.sin(currentBeat * 3) + 160)
    end
    if daNoteMove then
        for i=0,7 do
            setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.25) * math.pi), i)
            setActorY(defaultStrum0Y + 75 * math.cos((currentBeat + i*2.5) * math.pi), i)
        end
    end
end
-- fixed the step they start at BECAUSE CYBER'S A IDIOT AND OFFSET ALL OF THEM
function stepHit(step)
    if curStep == 129 then
        funnywindowsmall = true
    end
    if curStep == 258 then
        funnywindowsmall = false
        funnywindow = true
    end
    if curStep == 518 then
        funnywindow = false
        funnywindowsmall = true
    end
    if curStep == 776 then
        funnywindowsmall = false
        funnywindow = true
        daNoteMove = true
    end
    if curStep == 1053 then
        NOMOREFUNNY = true
        funnywindow = false
        funnywindowsmall = false
    end
end