--Code Here
--Game.lua

local composer = require( "composer" )
local scene = composer.newScene()

local widget = require "widget"
local physics = require("physics")

physics.start( )
physics.setGravity(0,0)

--math.randomseed(os.time())

--Localização imagens
 local sheetInfo = require("sprites.sprite")
 local sheetObjects = graphics.newImageSheet( "sprites/sprite.png", sheetInfo:getSheet() )

 local w = display.contentWidth
 local h = display.contentHeight

 local asteroidsTable = {}
 local buttons = {}

 local vidaTexto
 local pontosTexto

 local fundoTela
 local navePlayer
 local laser
 local asteroid
 local loopTimerAsteroid
 local loopTimerInimigo

 local vidas = 3
 local pontos = 0
 local morreu = false
 --local  tiroLazer

 local function criarAsteroid(evento)
 	--local asteroid = display.newImageRect( menuJogo, sheetObjects, 2, 102, 85 )
 	--print( menuJogo )
 	asteroid = display.newImageRect("meteoro.png", 102,85)

 	asteroid:setFillColor( 0,1,0 )
 	 --asteroid = display.newCircle( menuJogo, 100, 100, 30 )
 	table.insert( asteroidsTable,  asteroid )
 	physics.addBody( asteroid, "dinamic", {radius = 40, bounce = 1, friction = 0.8} )
 	asteroid.myName = "asteroid" --asteroid1
 	--asteroid:setFillColor( 0,0.4,0 )

 	local geraPosiAsteroid = math.random(3)

	if geraPosiAsteroid == 1 then -- esquerda
		asteroid.x = -60
		asteroid.y = math.random(512)
		--asteroid:applyForce( 100, 0 )
		asteroid:setLinearVelocity( math.random( 40, 120 ), math.random( 20, 60 ) )
        --timer.performWithDelay
     elseif geraPosiAsteroid == 2 then -- cima
     	asteroid.x = math.random( display.contentWidth )
     	asteroid.y = -60
     	--asteroid:applyForce( 10, -20 )
     	asteroid:setLinearVelocity( math.random(-40, 40), math.random(40,120) )
     
     elseif geraPosiAsteroid == 3 then -- direita
        asteroid.x = display.contentWidth + 60
        asteroid.y = math.random( 512 )	

        asteroid:setLinearVelocity( math.random( -120, -40 ), math.random( 20, 60 ) )
	end	
	    asteroid:applyTorque( math.random(-10,2) )
        --asteroid:applyTorque( math.random(-6,6) )
end

local function chamarAsteroid()
	criarAsteroid()--cria os asteroides na tela!
    
    for i = #asteroidsTable, 1, -1 do
       local asteroidAlvo = asteroidsTable[i]
       if vidas ~= 0 then
       if asteroidAlvo.x < -100 or asteroidAlvo.x > w + 100 or 
       	  asteroidAlvo.y < -100 or asteroidAlvo.y > h + 100
       then
       display.remove( asteroidAlvo )	  
       table.remove( asteroidsTable, i )
       end	
      end
    end

end

local function criarInimigo(evento)
    
    inimigo = display.newCircle( menuJogo, 100, 100, 30 )
 	inimigo:setFillColor( 1,1,1 )
 	 
 	table.insert( asteroidsTable,  inimigo )
 	physics.addBody( inimigo, "dinamic", {radius = 40, bounce = 1, friction = 0.8} )
 	inimigo.myName = "inimigo" 
 	
 	local geraPosiInimigo = math.random(3)

	if geraPosiAsteroid == 1 then -- esquerda
		inimigo.x = -60
		inimigo.y = math.random(512)
		--asteroid:applyForce( 100, 0 )
		inimigo:setLinearVelocity( math.random( 40, 100 ), math.random( 20, 60 ) )
        --timer.performWithDelay
     elseif geraPosiInimigo == 2 then -- cima
     	inimigo.x = math.random( display.contentWidth )
     	inimigo.y = -60
     	--asteroid:applyForce( 10, -20 )
     	inimigo:setLinearVelocity( math.random(-40, 40), math.random(40,100) )
     
     elseif geraPosiInimigo == 3 then -- direita
        inimigo.x = display.contentWidth + 60
        inimigo.y = math.random( 512 )	

        inimigo:setLinearVelocity( math.random( -100, -40 ), math.random( 20, 60 ) )
	end	
	    inimigo:applyTorque( math.random(-10,2) )
end

local function chamarInimigo()
	
	criarInimigo()--cria os inimigos na tela!
    
    for i = #asteroidsTable, 1, -1 do
       local inimigoAlvo = asteroidsTable[i]
        if vidas ~= 0 then
            if inimigoAlvo.x < -100 or inimigoAlvo.x > w + 100 or 
       	       inimigoAlvo.y < -100 or inimigoAlvo.y > h + 100
            then
                display.remove( inimigoAlvo )	  
                table.remove( asteroidsTable, i )
            end	
        end
    end

end

local function gameOver()
	composer.setVariable( "finalScore", pontos)
	composer.removeScene( "ScoreHank" )
	composer.gotoScene( "ScoreHank" )
	--composer.gotoScene("Menu")
end

local function restaurarNave()
	navePlayer.isBodyActive = false
	navePlayer:setLinearVelocity(0, 0)
	navePlayer.x = display.contentCenterX
	navePlayer.y = h - 100
	transition.to( navePlayer, {alpha = 1, time = 4000,
	 onComplete = function()
		 navePlayer.isBodyActive = true
		 morreu = false
	end })
end

local function checarColisoes(event)
	
	if (event.phase == "began") then
		
		local obj1 = event.object1
		local obj2 = event.object2
		
		if (obj1.myName == "laser" and obj2.myName == "asteroid") or 
			(obj1.myName == "asteroid" and obj2.myName == "laser") then
			
			           display.remove( obj1 )
			           display.remove( obj2 )

			           for i = #asteroidsTable, 1, -1 do
                            if asteroidsTable[i] == obj1 or asteroidsTable[i] == obj2 then
                                table.remove( asteroidsTable, i )
                                break
                            end	
		                end
		   
		                pontos = pontos + 100
		                pontosTexto.text = "Pontos:"..pontos   
		   
		    else if (obj1.myName == "laser" and obj2.myName == "inimigo") or 
			        (obj1.myName == "inimigo" and obj2.myName == "laser") then
			
			           display.remove( obj1 )
			           display.remove( obj2 )

			            for i = #asteroidsTable, 1, -1 do
                            if asteroidsTable[i] == obj1 or asteroidsTable[i] == obj2 then
                                table.remove( asteroidsTable, i )
                                break
                            end	
		                end
		                
		                pontos = pontos + 100
		                pontosTexto.text = "Pontos:"..pontos
         
 		            elseif (obj1.myName == "ship" and obj2.myName == "asteroid") or 
			               (obj1.myName == "asteroid" and obj2.myName == "ship") then      
		                    if (morreu == false) then
		        	            morreu = true
		        	            vidas = vidas - 1
		        	            vidaTexto.text = "Vidas:"..vidas
		        	            if (vidas == 0) then
		        	   	            physics.pause()
		        	   	            display.remove( navePlayer )
		        	   	            
		        	   	            timer.performWithDelay( 2000, gameOver)
		        	            else
		        	               navePlayer.alpha = 0
		        	               timer.performWithDelay(1000,restaurarNave)	   
		        	            end
                            end
                    elseif (obj1.myName == "ship" and obj2.myName == "inimigo") or 
			               (obj1.myName == "inimigo" and obj2.myName == "ship") then      
		                    if (morreu == false) then
		        	            morreu = true
		        	            vidas = vidas - 1
		        	            vidaTexto.text = "Vidas:"..vidas
		        	            if (vidas == 0) then
		        	   	            physics.pause()
		        	   	            display.remove( navePlayer )
		        	   	            
		        	   	            timer.performWithDelay( 2000, gameOver)
		        	            else
		        	               navePlayer.alpha = 0
		        	               timer.performWithDelay(1000,restaurarNave)	   
		        	            end
                            end         		     
		            end 
        end
	end
end

local function criarLaserInimigo(evento)


    local geraDirecaoLaserInimigo = math.random(4)

        if geraDirecaoLaserInimigo == 1 then
            

            local laserInimigo = display.newImageRect( "laserInimigo.png", 14, 30 )
	        physics.addBody( laserInimigo, "dinamic", {isSensor = true})
	        laserInimigo.isBullet = true
	        laserInimigo.myName = "laserInimigo"
            laserInimigo.x = inimigo
            laserInimigo.y = inimigo      
      
            laserInimigo:toBack( )
     
          --laserInimigo.rotation = math.random(512)
            --para baixo
            transition.to( laserInimigo, {y = 900, time = 300,
	              onComplete = function ()
		      display.remove(laserInimigo)
            end} )
        
        elseif geraDirecaoLaserInimigo == 2 then
            local laserInimigo = display.newImageRect( "laserInimigo.png", 14, 30 )
            physics.addBody( laserInimigo, "dinamic", {isSensor = true})
	        laserInimigo.isBullet = true
	        laserInimigo.myName = "laserInimigo"
            laserInimigo.x = inimigo
            laserInimigo.y = inimigo      
      
            laserInimigo:toBack( )

            --para direita  
	        transition.to( laser, {x = 900, time = 500,
	              onComplete = function ()
		       display.remove(laser)
	        end} )
        elseif geraDirecaoLaserInimigo == 3 then
            local laserInimigo = display.newImageRect( "laserInimigo.png", 14, 30 )
            physics.addBody( laserInimigo, "dinamic", {isSensor = true})
	        laserInimigo.isBullet = true
	        laserInimigo.myName = "laserInimigo"
            laserInimigo.x = inimigo
            laserInimigo.y = inimigo      
      
            laserInimigo:toBack( )
            --para esquerda
            transition.to( laser, {x = -50, time = 500,
	             onComplete = function ()
	           display.remove(laser)
	  end} )
        elseif geraDirecaoLaserInimigo == 4 then
            local laserInimigo = display.newImageRect( "laserInimigo.png", 14, 30 )
            physics.addBody( laserInimigo, "dinamic", {isSensor = true})
	        laserInimigo.isBullet = true
	        laserInimigo.myName = "laserInimigo"
            laserInimigo.x = inimigo
            laserInimigo.y = inimigo      
      
            laserInimigo:toBack( )
            --para cima
            transition.to( laser, {y= -110, time = 500, 
	               onComplete = function()
	            display.remove( laser )
	 end} ) 
        end	        

end

--Runtime:addEventListener("enterFrame", criarLaserInimigo)

local function criarLaser(evento)
   if   navePlayer.rotation == 90 then
    local laser = display.newImageRect( menuJogo, sheetObjects, 3, 14, 40 )
	physics.addBody( laser, "dinamic", {isSensor = true})
	laser.isBullet = true
	laser.myName = "laser"
	laser.x = navePlayer.x
	laser.y = navePlayer.y
	
	--laser.collType = "laser"
	
	laser:toBack( )
    
	--laser:translate( deltaX, deltaY )
	
	--atira para direita
	laser.rotation = 90
	transition.to( laser, {x = 900, time = 500,
	onComplete = function ()
		display.remove(laser)
	end} )
elseif navePlayer.rotation == -90 then
	local laser = display.newImageRect( menuJogo, sheetObjects, 3, 14, 40 )
	physics.addBody( laser, "dinamic", {isSensor = true})
	laser.isBullet = true
	laser.myName = "laser"
	laser.x = navePlayer.x
	laser.y = navePlayer.y
	
	laser:toBack( )
      
      --atira para esquerda!
      laser.rotation = -90
	  transition.to( laser, {x = -50, time = 500,
	     onComplete = function ()
	       display.remove(laser)
	  end} )
elseif navePlayer.rotation == 180 then
    local laser = display.newImageRect( menuJogo, sheetObjects, 3, 14, 40 )
	physics.addBody( laser, "dinamic", {isSensor = true})
	laser.isBullet = true
	laser.myName = "laser"
	laser.x = navePlayer.x
	laser.y = navePlayer.y
	
	laser:toBack( )
     --atira para baixo!
     laser.rotation = 180
	transition.to( laser, {y = 1400, time = 500,
		onComplete = function ()
		display.remove(laser)
	end} )
elseif navePlayer.rotation == 0 then   
    local laser = display.newImageRect( menuJogo, sheetObjects, 3, 14, 40 )
	physics.addBody( laser, "dinamic", {isSensor = true})
	laser.isBullet = true
	laser.myName = "laser"
	laser.x = navePlayer.x
	laser.y = navePlayer.y
	
	laser:toBack( )
    --atira para cima!
    laser.rotation = 0  
     transition.to( laser, {y= -110, time = 500, 
	    onComplete = function()
	        display.remove( laser )
	 end} ) 

--else 
--	print( "Não fui programdo para fazer nada aqui!" )

end--fim do elseif!

end--fim do ouvinte! 

tiroLazer = widget.newButton({label="Laser",width= 40,height =80,
                               x = display.contentWidth/2 - 280,
                             y = display.contentHeight/2 + 360,  
                             shape="circle", fillColor = { default={ 0, 0.2, 0.5, 1 }, over={ 0, 0, 0, 0.1} }}  )--, onPress = criarLaser


--tiroLazer:addEventListener( "tap", criarLaser )

local rotacionarObjeto = function(e)
	local eventName = e.phase
	local direction = e.target.move
	
	if eventName == "began" or eventName == "moved" then
		if direction == "up"  then 
			navePlayer.rotation = 0 
           
		elseif direction == "down" then 
			navePlayer.rotation = 180
			
		elseif direction == "right" then---ALTERADO NESSE BLOCO!
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

local function movimentarObjeto(evento)
	if evento.phase == "ended" then
       transition.to( navePlayer, {x = evento.x, y = evento.y})
    end
end
 
local function atualizarCordenadasObjeto(evento)
	if evento.phase == "began" then
		local j=1
        if vidas ~= 0 then 
           for j=1, #buttons do 
	          buttons[j]:addEventListener("touch", rotacionarObjeto)
	         --Runtime:addEventListener("touch", movimentarObjeto)
		    end 
	    end
	else if evento.phase == "ended" or evento.phase == "canceled" then

	end	
end
end

local atualizarPosicaoPlayer = function()
	if vidas ~= 0 then
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
end

function scene:create(evento)
local grupoCena = self.view 

   physics.pause()


--Grupos dos elementos na tela
 grupoPlanodeFundo = display.newGroup()
 menuJogo = display.newGroup()
 uiGrupo = display.newGroup()
 

grupoCena:insert(grupoPlanodeFundo)
grupoCena:insert(menuJogo)
grupoCena:insert(uiGrupo)
   

buttons[1] = display.newImageRect("button.png", 60,50)
    buttons[1].x = 600
    buttons[1].y = 880
    buttons[1].move = "up"
    buttons[1].rotation = -90

    buttons[2] = display.newImageRect("button.png", 60,50)
    buttons[2].x = 600
    buttons[2].y = 1020
    buttons[2].move = "down"
    buttons[2].rotation = 90

    buttons[3] = display.newImageRect("button.png", 60,50)
    buttons[3].x = 500 
    buttons[3].y = 950
    buttons[3].move = "left"
    buttons[3].rotation = 180

    buttons[4] = display.newImageRect("button.png", 60,50)
    buttons[4].x = 700
    buttons[4].y = 950
    buttons[4].move = "right"

   
   vidaTexto = display.newText( uiGrupo, "vidas: ".. vidas, 200, 80, native.systemFont, 36 )
   pontosTexto = display.newText( uiGrupo, "pontos: "..pontos, 600, 80, native.systemFont, 36 )
   

   fundoTela = display.newImageRect("espaço-cideral2.png", 800, 1400)
   fundoTela.x = display.contentCenterX
   fundoTela.y = display.contentCenterY

   navePlayer = display.newImageRect( sheetObjects, 4, 98, 79)
   navePlayer.x = display.contentCenterX
   navePlayer.y = h - 450
   navePlayer.myName = "ship"
   --navePlayer:setFillColor( 0,0,1 )
   physics.addBody( navePlayer, {radius = 30} )
   

--tiroLazer = widget.newButton({label="Laser",width= 40,height =80,
     --                          x = display.contentWidth/2 - 280,
     --                        y = display.contentHeight/2 + 360,  
     --                        shape="circle", fillColor = { default={ 0, 0.2, 0.5, 1 }, over={ 0, 0, 0, 0.1} }, onPress = criarLaser}  )

    
   grupoPlanodeFundo:insert(fundoTela)
   menuJogo:insert(navePlayer)
   --menuJogo:insert(tiroLazer)

   uiGrupo:insert(buttons[1])
   uiGrupo:insert(buttons[2])
   uiGrupo:insert(buttons[3])
   uiGrupo:insert(buttons[4])
   
   --if vidas ~= 0 then
     --loopTimerAsteroid = timer.performWithDelay( 1000, chamarAsteroid, 0 )
     --loopTimerInimigo = timer.performWithDelay( 10000, chamarInimigo, 0) 
   --end     

end	

-- show()
function scene:show(evento)
 
    local CenaGrupo = self.view
    local phase = evento.phase
 
    if ( phase ==  "did") then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
	    physics.start( )
	    for j=1, #buttons do 
	        buttons[j]:addEventListener("touch", moverNavePlayer)
        end
        Runtime:addEventListener("enterFrame", atualizarPosicaoPlayer) 
        --Runtime:addEventListener("touch", movimentarObjeto)
        Runtime:addEventListener("touch", atualizarCordenadasObjeto)
        Runtime:addEventListener("collision",checarColisoes)
        tiroLazer:addEventListener( "tap", criarLaser )
        --Runtime:addEventListener("enterFrame", criarLaserInimigo)
        
        loopTimerAsteroid = timer.performWithDelay( 1000, chamarAsteroid, 0 )
        loopTimerInimigo = timer.performWithDelay( 10000, chamarInimigo, 0) 
        
    end
end

-- hide()
function scene:hide(evento)
 
    local CenaGrupo = self.view
    local phase = evento.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
         physics.pause( )
         Runtime:removeEventListener("collision",checarColisoes)
         
         
    end
end
 
-- destroy()
function scene:destroy(evento)
 
    local CenaGrupo = self.view
    -- Code here runs prior to the removal of scene's view 
      --removeSelf(menuJogo )
      --removeSelf(loopTimerInimigo )
end

 

--criarAsteroid()




--loopTimerAsteroid = timer.performWithDelay( 1000, chamarAsteroid, 0 )


--loopTimerInimigo = timer.performWithDelay( 10000, chamarInimigo, 0)






--navePlayer:addEventListener( "tap", criarLaser )

--if(vidas == 0) then
   --display.remove(tiroLazer)
--end



--for j=1, #buttons do 
--	buttons[j]:addEventListener("touch", moverNavePlayer)
--end



--Runtime:addEventListener("enterFrame", atualizarPosicaoPlayer) 
--Runtime:addEventListener("touch", movimentarObjeto)
 --Runtime:addEventListener("touch", atualizarCordenadasObjeto)
-- Runtime:addEventListener("collision",onCollision)

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene