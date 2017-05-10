-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


local physics = require("physics")

physics.start()

physics.getGravity( 0, 9.8)

math.randomseed( os.time() )


--local meteoro = display.newImage("asteroid01.png")
--local meteoro2 = display.newImage("asteroid1.png")
--meteoro:translate( 200, 100 )
--meteoro2:translate( 400, 20 )

--physics.addBody( meteoro, "dynamic", {density = 1, friction = 1, bounce = 1} )
--physics.addBody( meteoro2, "dynamic", {density = 1, friction = 1, bounce = 1} )

local w = display.contentWidth
local h = display.contentHeight




local widget = require("widget")

local butoes = {}

local spaceScreen = {

 espacoTela = {
	objeto, -- = display.newImageRect("fundo.png", 768, 1024)
	x = 0,
	y = 0,
	width = 768,
	height = 1024  
},

 meteoro = {
	objeto, -- = display.newImageRect("asteroid01.png", width = 80, height = 80 )
	x = 0,
	y = 0,
	width = 80,
	height = 80
},

 meteoro2 = {
     objeto, -- = display.newImageRect("asteroid1.png", width = 50, height = 50 )
     x = 0,
     y = 0,
     width = 50,
     height = 50	
},

 nave = {
	objeto,-- = display.newImageRect("ship.png", 600, 200),
	x = 0, 
	y = 0,
	width = 40,
	height = 40	
},

laser = {
	objeto,-- = display.newImageRect( "laser.png", 20, 50)
	x = 0,
	y = 0,
	width = 20,
	height = 20 
}

}

local asteroidsTable = {}

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

local fundoTela = display.newImageRect(grupoPlanodeFundo, "fundo.png", 800, 1400)
fundoTela.x = display.contentCenterX
fundoTela.y = display.contentCenterY


--physics.addBody( fundoTela, static, {friction = 1, bounce = 2, density = 0.3, radius =10} )

--nave = display.newImageRect( menuJogo, objeto, 4, 98, 79 )
--[[
spaceScreen.nave = display.newImageRect( menuJogo, objeto, 4, 98, 79 )
spaceScreen.nave.x = display.contentCenterX
spaceScreen.nave.y = display.contentHeight - 100
physics.addBody( nave, {radius = 30} )
spaceScreen.nave.nome = "nave"
]]

vidaTexto = display.newText( uiGrupo, "vidas: ".. vidas, 200, 80, native.systemFont, 36 )
pontosTexto = display.newText( uiGrupo, "pontos: "..pontos, 600, 80, native.systemFont, 36 )

local function atualizarStatusPlayer()

	vidaTexto.text = "vidas: "..vidas
	pontosTexto.text = "pontos: "..pontos

end

--tiro = display.newImageRect( "laser.png", 20, 50)
--tiro.x = display.contentCenterX
--tiro.y = display.contentCenterY
local player = display.newImageRect("ship.png", 200, 200)

--physics.addBody( player, {radius = 30})




player.x = w * .5 + 10
player.y = h * .5 + 150


local buttons = {}

--buttons[1]  = display.newRect(0, 0, 60, 80)
buttons[1] = display.newImage("button.png")
buttons[1].x = 495
buttons[1].y = 880
buttons[1].move = "up"
buttons[1].rotation = -90

--buttons[2] = display.newRect(0, 0, 60, 80)
buttons[2] = display.newImage("button.png")
buttons[2].x = 495
buttons[2].y = 1020
buttons[2].move = "down"
buttons[2].rotation = 90

--buttons[3] = display.newRect(0, 0, 80, 60)
buttons[3] = display.newImage("button.png")
buttons[3].x = 380 
buttons[3].y = 950
buttons[3].move = "left"
buttons[3].rotation = 180

--buttons[4] = display.newRect(0, 0, 80, 60)
buttons[4] = display.newImage("button.png")
buttons[4].x = 600
buttons[4].y = 950
buttons[4].move = "right"


local rotacionarObjeto = function(e)
	local eventName = e.phase
	local direction = e.target.move
	
	if eventName == "began" or eventName == "moved" then
		if direction == "up" then 
			player.rotation = 0
		elseif direction == "down" then 
			player.rotation = 180
		elseif direction == "right" then
			player.rotation = 90
		elseif direction == "left" then
			player.rotation = -90
		end
	
	end
end

local j=1

for j=1, #buttons do 
	buttons[j]:addEventListener("touch", rotacionarObjeto)
end



