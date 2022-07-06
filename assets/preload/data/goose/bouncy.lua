strumsX = {}
function onCreatePost()
  for i=0,3 do
    table.insert(tableName, _G['defaultOpponentStrumX'..i])
  end
  for i=0,3 do
    table.insert(tableName, _G['defaultPlayerStrumX'..i])
  end
end
function setStrumPos(member, x, y)
  setPropertyFromGroup('strumLineNotes', member, 'x', x)
  setPropertyFromGroup('strumLineNotes', member, 'y', y)
end
function addStrumPos(member, x, y)
  local y = (y ~= nil) and y or 0
  setPropertyFromGroup('strumLineNotes', member, 'x', getPropertyFromGroup('strumLineNotes', member, 'x') + x)
  setPropertyFromGroup('strumLineNotes', member, 'y', getPropertyFromGroup('strumLineNotes', member, 'y') + y)
end
function getStrumPos(member)
  ok = {x = getPropertyFromGroup('strumLineNotes', member, 'x'), y = getPropertyFromGroup('strumLineNotes', member, 'y')}
  return ok
end
function onBeatHit()
  if curBeat % 4 == 0 then
    bounceNote(true)
  elseif curBeat % 4 == 2 then
    bounceNote(false)
  end
end
function onCountdownTick(daTick)
  if daTick % 2 == 0 then
    bounceNote(true)
  else
    bounceNote(false)
  end
end
function bounceNote(which)
  if modCharts then
    if which then
      for i=0,7,2 do
        addStrumPos(i, -35)
        setPropertyFromGroup('strumLineNotes', i, 'angle', -35)
        noteTweenX('yeayea'..i, i, strumsX[i+1], crochet*0.002, 'cubeOut')
        noteTweenAngle('okok'..i, i, 0, crochet*0.002, 'cubeOut')
      end
      for i=1,8,2 do
        addStrumPos(i, 35)
        setPropertyFromGroup('strumLineNotes', i, 'angle', 35)
        noteTweenX('yeayea'..i, i, strumsX[i+1], crochet*0.002, 'cubeOut')
        noteTweenAngle('okok'..i, i, 0, crochet*0.002, 'cubeOut')
      end
    else
      for i=0,7,2 do
        addStrumPos(i, 35)
        setPropertyFromGroup('strumLineNotes', i, 'angle', 35)
        noteTweenX('yeayea'..i, i, strumsX[i+1], crochet*0.002, 'cubeOut')
        noteTweenAngle('okok'..i, i, 0, crochet*0.002, 'cubeOut')
      end
      for i=1,8,2 do
        addStrumPos(i, -35)
        setPropertyFromGroup('strumLineNotes', i, 'angle', -35)
        noteTweenX('yeayea'..i, i, strumsX[i+1], crochet*0.002, 'cubeOut')
        noteTweenAngle('okok'..i, i, 0, crochet*0.002, 'cubeOut')
      end
    end
  end
end
