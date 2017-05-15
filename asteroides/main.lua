-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

--local principal = require("principal")

local composer = require("composer")
--local scene = composer.newScene()
composer.gotoScene( "principal") 

--[[
local physics = require("physics")

physics.start()

physics.getGravity( 9.8, 0)

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

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- asteroid1
            x=48,
            y=285,
            width=26,
            height=30,

        },
        {
            -- asteroid01
            x=1,
            y=285,
            width=45,
            height=46,

        },
        {
            -- laser
            x=76,
            y=285,
            width=10,
            height=50,

        },
        {
            -- ship
            x=1,
            y=1,
            width=190,
            height=282,

            sourceX = 65,
            sourceY = 13,
            sourceWidth = 320,
            sourceHeight = 320
        },
    },
    
    sheetContentWidth = 192,
    sheetContentHeight = 336
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


--local conjuntoTela = display.newImageRect("sprites/sprite.png",200,240)


--physics.addBody( fundoTela, static, {friction = 0, bounce = 0, density = 0, radius =0} )



vidaTexto = display.newText( uiGrupo, "vidas: ".. vidas, 200, 80, native.systemFont, 36 )
pontosTexto = display.newText( uiGrupo, "pontos: "..pontos, 600, 80, native.systemFont, 36 )

local function atualizarStatusPlayer()

	vidaTexto.text = "vidas: "..vidas
	pontosTexto.text = "pontos: "..pontos

end


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

]]--

