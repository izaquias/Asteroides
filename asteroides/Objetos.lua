--Code Here
--Objetos.lua
 
local composer = require( "composer" )
local scene = composer.newScene()

local fundoTela = display.newImageRect("espaço-cideral2.png", 800, 1400)
    fundoTela.x = display.contentCenterX
    fundoTela.y = display.contentCenterY