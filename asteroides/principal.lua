--code here
--Cena principal

local composer = require("composer")
local scene = composer.newScene()

local widget = require("widget")

local physics = require("physics")

physics.start()

physics.setGravity( 0, 9.8)

physics.setDrawMode("normal")

math.randomseed( os.time() )

local sheetInfo = require("sprites.sprite")
local sheetObjects = graphics.newImageSheet( "sprites/sprite.png", sheetInfo:getSheet() )

local w = display.contentWidth
local h = display.contentHeight

local asteroidsTable = {}
--local fundo = {}

local buttons = {}

local vidaTexto
local pontosTexto

local vidas = 3
local pontos = 0
local morreu = false

local navePlayer
local gameLoopTimer

local grupoPlanodeFundo = display.newGroup()
local menuJogo = display.newGroup()
local uiGrupo = display.newGroup()

local novoAsteroid = {}

local	asteroid

local fundoTela

--[[

	--buttons[1]  = display.newRect(0, 0, 60, 80)
	
    buttons[1] = display.newImage("button.png")
    buttons[1].x = 495
    buttons[1].y = 880
    buttons[1].move = "up"
    buttons[1].rotation = -90

    buttons[2] = display.newImage("button.png")
    buttons[2].x = 495
    buttons[2].y = 1020
    buttons[2].move = "down"
    buttons[2].rotation = 90

    buttons[3] = display.newImage("button.png")
    buttons[3].x = 380 
    buttons[3].y = 950
    buttons[3].move = "left"
    buttons[3].rotation = 180

    buttons[4] = display.newImage("button.png")
    buttons[4].x = 600
    buttons[4].y = 950
    buttons[4].move = "right"

function scene:create(evento)
 
    local CenaGrupo = self.view

    phase = evento.phase
    
    fundoTela = display.newImageRect(grupoPlanodeFundo, "fundo.png", 800, 1400)
    fundoTela.x = display.contentCenterX
    fundoTela.y = display.contentCenterY
    CenaGrupo:insert(fundoTela)
   
    vidaTexto = display.newText( uiGrupo, "vidas: ".. vidas, 200, 80, native.systemFont, 36 )
    pontosTexto = display.newText( uiGrupo, "pontos: "..pontos, 600, 80, native.systemFont, 36 )
 
    CenaGrupo:insert(vidaTexto)
	CenaGrupo:insert(pontosTexto)

	navePlayer = display.newImageRect("ship.png", 200, 200)

    --physics.addBody( navePlayer, {radius = 30})

    navePlayer.x = w * .5 + 10
    navePlayer.y = h * .5 + 150    
    CenaGrupo:insert(navePlayer)

    --buttons[1]  = display.newRect(0, 0, 60, 80)
    
    CenaGrupo:insert(buttons[1]) 

    --buttons[2] = display.newRect(0, 0, 60, 80)
   
    CenaGrupo:insert(buttons[2])

    --buttons[3] = display.newRect(0, 0, 80, 60)
    
    CenaGrupo:insert(buttons[3])

    --buttons[4] = display.newRect(0, 0, 80, 60)
    
    CenaGrupo:insert(buttons[4])



end
 

-- show()
function scene:show(evento)
 
    local CenaGrupo = self.view
    local phase = evento.phase
 
    if ( phase ==  "did") then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
		
		 
    end
end
 
 
-- hide()
function scene:hide(evento)
 
    local CenaGrupo = self.view
    local phase = evento.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    end
end
 
 
-- destroy()
function scene:destroy(evento)
 
    local CenaGrupo = self.view
    -- Code here runs prior to the removal of scene's view
 
end
  
local function criarAsteroid(evento)

	asteroid = display.newCircle( menuJogo, display.contentCenterX, display.contentCenterY, 30)
	asteroid:setFillColor( 0.2 )

	asteroid.strokeWidth = 5
	asteroid:setStrokeColor( 1, 0, 0 )
	table.insert( novoAsteroid, asteroid)
	physics.addBody( asteroid, "dinamic", {radius = 40, bounce = 0.8} )
	asteroid.myName = "asteroid"

	local geraPosiAsteroid = math.random(3)

	if geraPosiAsteroid == 1 then -- esquerda
		asteroid.x = -60
		asteroid.y = math.random(512)
		asteroid:setLinearVelocity( math.random( 40, 120 ), math.random( 20, 60 ) )
     
     elseif geraPosiAsteroid == 2 then -- cima
     	asteroid.x = math.random( display.contentWidth )
     	asteroid.y = -60
     	asteroid:setLinearVelocity( math.random(-40, 40), math.random(40,120) )
     
     elseif geraPosiAsteroid == 3 then -- direita
        asteroid.x = display.contentWidth + 60
        asteroid.y = math.random( 512 )	
        asteroid:setLinearVelocity( math.random( -120, -40 ), math.random( 20, 60 ) )
	end	
	    asteroid:applyTorque( math.random(-6,6) )
end

criarAsteroid()

local function gerarLaser(evento)
	local laser = display.newImageRect( menuJogo, "laser.png",  14, 40 )
	physics.addBody( laser, "dinamic", {isSensor = true})
	laser.isBullet = true
	laser.myName = "laser"
	laser.x = navePlayer.x
	laser.y = navePlayer.y
	laser:toBack( )
	
	transition.to( laser, {y= -40, time = 500, onComplete = function()
		display.remove( laser )
	end} )
   
end	

--navePlayer:addEventListener( "tap", gerarLaser )

local function atualizarStatusPlayer()

	vidaTexto.text = "vidas: "..vidas
	pontosTexto.text = "pontos: "..pontos

end
 
local rotacionarObjeto = function(e)
	local eventName = e.phase
	local direction = e.target.move
	
	if eventName == "began" or eventName == "moved" then
		if direction == "up" then 
			navePlayer.rotation = 0
		elseif direction == "down" then 
			navePlayer.rotation = 180
		elseif direction == "right" then
			navePlayer.rotation = 90
		elseif direction == "left" then
			navePlayer.rotation = -90
		end
	
	end
end 

local xAxis = 0
local yAxis = 0

local function moverNavePlayer(evento)
	local eventName = evento.phase
	local direction = evento.target.move
	
	if eventName == "began" or eventName == "moved" then
		if direction == "up" then 
			yAxis = -5
			xAxis = 0
		elseif direction == "down" then 
			yAxis = 5
			xAxis = 0
		elseif direction == "right" then
			xAxis = 5
			yAxis = 0
		elseif direction == "left" then
			xAxis = -5
			yAxis = 0
		end
	else 
		yAxis = 0
		xAxis = 0
	end
end

for j=1, #buttons do 
	buttons[j]:addEventListener("touch", moverNavePlayer)
end

local function movimentarObjeto(evento)
	if evento.phase == "ended" then
       transition.to( navePlayer, {x = evento.x, y = evento.y})
    end
end
 
local function atualizarCordenadasObjeto(evento)
	if evento.phase == "began" then
		local j=1

        for j=1, #buttons do 
	       buttons[j]:addEventListener("touch", rotacionarObjeto)
	      --Runtime:addEventListener("touch", movimentarObjeto)
		end 
	else if evento.phase == "ended" or evento.phase == "canceled" then

	end	
end
end

local atualizarPosicaoPlayer = function()
	navePlayer.x = navePlayer.x + xAxis
	navePlayer.y = navePlayer.y + yAxis

	if navePlayer.x <= navePlayer.width * .1 then 
		navePlayer.x = navePlayer.width * .1
	elseif navePlayer.x >= w - navePlayer.width * .1 then 
		navePlayer.x = w - navePlayer.width * .1
	end

	if navePlayer.y <= navePlayer.height * -5 then
		navePlayer.y = navePlayer.height * -5
	elseif navePlayer.y >= h - navePlayer.height * -5 then 
		navePlayer.y = h - navePlayer.height * -5
	end 
end

Runtime:addEventListener("enterFrame", atualizarPosicaoPlayer) 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------

       
 
 --Runtime:addEventListener("touch", movimentarObjeto)
 Runtime:addEventListener("touch", atualizarCordenadasObjeto)

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene
]]