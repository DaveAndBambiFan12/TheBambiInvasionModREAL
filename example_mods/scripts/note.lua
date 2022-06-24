--[[
chars = {'choco', 'amogus', 'nerd', 'nerd_dumb', 'expunged', 'jadi', 'voidbi', 'dave-house'}
penis = false

function onCreatePost()
  for k, v in pairs(chars) do
    if dadName == v or boyfriendName == v then penis = true end
  end
  for i=0, getProperty('unspawnNotes.length')-1 do
    if penis then
      if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
        setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets_3D')
      else
        local is3D = getRandomBool(25)
        if is3D then
          setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets_3D')
        end
      end
      for i=0,3 do
        setPropertyFromGroup('opponentStrums', i, 'texture', 'NOTE_assets_3D')
      end
    end
  end
end
]]
