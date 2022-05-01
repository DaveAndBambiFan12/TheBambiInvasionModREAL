function onCreate()
  makeLuaSprite('sky', 'bg/sky_fucked', -350, -170)
  setScrollFactor('sky', 0.4, 0.2)
  addLuaSprite('sky')

  makeLuaSprite('hills', 'bg/hills', -500, -20)
  setScrollFactor('hills', 0.3, 0.4)
  scaleObject('hills', 1.35, 1.35)
  addLuaSprite('hills')

  makeLuaSprite('gates', 'bg/gate', -300, -110)
  setScrollFactor('gates', 0.6, 0.6)
  scaleObject('gates', 1.4, 1.4)
  addLuaSprite('gates')

  makeLuaSprite('grass', 'bg/grass', -680, -240)
  scaleObject('grass', 1.7, 1.7)
  addLuaSprite('grass')
end
