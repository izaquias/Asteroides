--code here
--Menu.lua

local composer =  require("composer")
local widget = require("widget")

local scene = composer.newScene()

math.randomseed(os.time())


local function redirecionarGame()

	composer.removeScene("Game")
    composer.gotoScene("Game")
end

local function VizualizarMaiorPontuacao()
	composer.removeScene("MaiorPontuacao")
	composer.gotoScene("MaiorPontuacao")
end

local titulo
local pontos
local jogar
local tela

  function scene:create(evento)
	
	local grupoCena = self.view
    local phase = evento.phase

        tela = display.newImageRect("espaço-cideral2.png", 800, 1400 )
        tela.x = display.contentCenterX
        tela.y = display.contentCenterY

        grupoCena:insert(tela)   
     
        titulo = display.newText({text = "Start Explorer", x =display.contentWidth/2, y =display.contentHeight/2 - 400, 100, 100})
        titulo.isEditable = true
        titulo.size = 100
        grupoCena:insert(titulo)
        
        jogar = display.newImageRect("jogar.png",  120,  100)
        --display.newImageRect(grupoPlanodeFundo, "espaço-cideral2.png", 800, 1400)
    
        jogar.x = display.contentWidth/2-160 
        jogar.y = display.contentHeight/2+150
        jogar:addEventListener( "tap", redirecionarGame )
        --jogar = display.newText({text = "jogar", x = display.contentWidth/2, y = display.contentHeight/2 +150 , width = 100, height = 100,onPress = redirecionarGame})  
        --jogar = widget.newButton({label = "Jogar",width= 80,height =100,
        --                     x = display.contentWidth/2,
        --                     y = display.contentHeight/2 + 100,  
        --                     shape="roundedRect",onPress = redirecionarGame} )--, onPress = redirecionarGame--, fillColor = { default={ 0, 0, 0, 1 }, over={ 0, 0, 0, 0.1} }
      
        
        grupoCena:insert(jogar)

        pontos = display.newImageRect( "botao.png",  120, 100 )
        pontos.x = display.contentWidth/2+160
        pontos.y = display.contentHeight/2+150

        grupoCena:insert(pontos) 
end


function scene:show(evento)
	local phase = evento.phase
 
    if ( phase ==  "did") then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
		 
    end
end

function scene:hide(evento)
	local CenaGrupo = self.view
    local phase = evento.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        
    end
	
end

function scene:destroy(evento)
	local CenaGrupo = self.view
    -- Code here runs prior to the removal of scene's view 
end

scene:addEventListener( "create", scene ) -- adiciona o evento da funcao de criar 
scene:addEventListener( "show", scene ) -- adiciona o evento da funcao de entre 
scene:addEventListener( "hide", scene ) -- adiciona o evento da funcao de sair
scene:addEventListener( "destroy", scene )-- adiciona o evento da funcao de destruir 

return scene
