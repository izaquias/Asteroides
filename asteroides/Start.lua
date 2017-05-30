--Code Here
--Start.lua

local composer = require("composer")
local widget = require("widget")

local scene = composer.newScene()


local botao

local function scene:create(evento)
	
	local grupoCena = self.view
    local phase = evento.phase

    botao = widget.newButton( {label = "Jogar", width = 40, height = 80, y = display.contentWidth/2, x = display.contentHeigth/2, onPress = iniciarJogo} )
    grupoCena:insert(botao)

end

local function iniciarJogo(evento)
	if (evento.phase == "began") then
	    composer.gotoScene("Game")	
	end
end
--[[
local function scene:show(evento)
	local phase = evento.phase
 
    if ( phase ==  "did") then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
		 
    end
end

local function scene:hide(evento)
	local CenaGrupo = self.view
    local phase = evento.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        
    end
	
end

local function scene:destroy(evento)
	local CenaGrupo = self.view
    -- Code here runs prior to the removal of scene's view 
end]]

scene:addEventListener( "create", scene ) -- adiciona o evento da funcao de criar 
--scene:addEventListener( "show", scene ) -- adiciona o evento da funcao de entre 
--scene:addEventListener( "hide", scene ) -- adiciona o evento da funcao de sair
--scene:addEventListener( "destroy", scene )-- adiciona o evento da funcao de destruir 

return scene