require 'mainmenu'
require 'chapters/Berlin'
require 'CGplayer'


function love.load()
    camera = require 'libraries/camera'
    cam = camera()
    
    mainmenu:load()
    

    cg1 = CG.new('CGs/OP.ogv')
    
    Center = {
        x = love.graphics.getWidth() / 2, 
        y = love.graphics.getWidth() / 2
    }
end
 


function love.update(dt)
    mainmenu:update(dt)
    
    
    if love.keyboard.isDown("w") then
        cam:move(0,-5)
    end
    if love.keyboard.isDown("s") then
        cam:move(0,5)
    end
    if love.keyboard.isDown("a") then
        cam:move(-5,0)
    end
    if love.keyboard.isDown("d") then
        cam:move(5,0)
    end
        

    
    function love.wheelmoved(x, y)
        if y > 0 then
            cam:zoom(1.1)
        elseif y < 0 then
            cam:zoom(0.9)
        end
    end
end



function love.draw()
    mainmenu:draw()
    
    --cg1:playCG()
end
