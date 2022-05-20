function onCreate()
  makeLuaSprite('bg', 'choco/bg', -1680, -710)
  setProperty('bg.antialiasing', false)
  scaleObject('bg', 2, 2)
  addShader('bg')
  addLuaSprite('bg')
end
