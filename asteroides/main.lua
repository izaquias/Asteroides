-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local widget = require("widget")
local composer = require("composer")
local scene = composer.newScene()

display.setStatusBar( display.HiddenStatusBar )

math.randomseed(os.time())

audio.reserveChannels( 1 ) 
audio.setVolume( 0.5 , {channel = 1} )
--composer.gotoScene("Game")Funcionando! 
--composer.gotoScene("Start")
composer.gotoScene("Menu")


