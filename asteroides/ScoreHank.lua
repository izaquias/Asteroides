--ScoreHank

local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 local json = require("json")
 local scoresTable = {}

 local filePath = system.pathForFile( "scores.json" , system.DocumentsDirectory )
 
 local function carregarPontuacao()
 	local file = io.open( filePath ,"r" )

 	if (file) then
 		local contents = file:read( "*a" )
 		io.close( file )
 		scoresTable = json.decode( contents )
 	end

 	if (scoresTable == nil or #scoresTable == 0) then
 		scoresTable = {0,0,0,0,0,0,0,0}--possivelmente será 10 indices 
 	end
 end

 local function salvarPontucao()
 	   for i= #scoresTable, 11, -1 do
 	   	  table.remove( scoresTable, i )
 	   end

 	   local file = io.open( filePath ,"w" )
 	   local temp = json.encode( scoresTable )

 	   file:write( temp )
 	   io.close( file )
 end
 
 local function redirecionarMenu()
 	composer.gotoScene( "Menu" )
 end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    carregarPontuacao()
    table.insert( scoresTable, composer.getVariable( "finalScore" ) )

    local function compararPuntuacao(a , b)
    	return a > b
    end

    table.sort( scoresTable, compararPuntuacao )

    salvarPontucao()

    local telaFundo = display.newImageRect(sceneGroup, "espaço-cideral2.png", 800, 1400 )
    telaFundo.x = display.contentCenterX
    telaFundo.y = display.contentCenterY

    titulo = display.newText({text = "High Scores", x =display.contentWidth/2, y =display.contentHeight/2 - 400, 100, 100})
        titulo.isEditable = true
        titulo.size = 100
        sceneGroup:insert(titulo)

    for i = 1, 10 do
        if (scoresTable[i]) then
            local yPos = 280 + (i * 56)

            local rankNum = display.newText( i..") ", display.contentCenterX - 50, yPos , nil, 35 ) 
            rankNum:setFillColor( 0.8 )
            rankNum.anchorX = 1
            sceneGroup:insert( rankNum )

            local thisScore = display.newText( sceneGroup, scoresTable[i], display.contentCenterX + 50 , yPos, nil, 35 )	
            thisScore.anchorX = 1 
        end 
    end
    local voltar = display.newText( sceneGroup, "Voltar", display.contentCenterX, 900 , nil, 44)
    voltar:setFillColor( 0.75,0.78, 1 )
    voltar:addEventListener( "tap", redirecionarMenu )    

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene