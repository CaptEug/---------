MainMenu = {}
MainMenu = Gamestate.new()



function MainMenu:init()
    Rtitlefont = love.graphics.newFont('Russian.ttf', 100)
    Rbuttonfont = love.graphics.newFont('Russian.ttf', 50)
    
    Europe_194X = love.graphics.newImage('Europe/Europe_194X.png')
    USSR = love.graphics.newImage('Europe/USSR.png')
    Poland = love.graphics.newImage('Europe/Poland.png')
    Czechoslovakia = love.graphics.newImage('Europe/Czechoslovakia.png')
    Hungary = love.graphics.newImage('Europe/Hungary.png')
    Romania = love.graphics.newImage('Europe/Romania.png')
    Bulgaria = love.graphics.newImage('Europe/Bulgaria.png')
    East_Germany = love.graphics.newImage('Europe/East_Germany.png')

    EUw, EUh = Europe_194X:getDimensions()
    BandWshader = love.graphics.newShader(BandWshader_code)

    cam:lookAt(EUw * 2 / 5, EUh * 3/5)
    cam:zoomTo(0.7)
    MMbuttons = buttons.new()
    local ww, wh = love.graphics.getDimensions()
    Start = buttons.newButton(
        "Путь!",
        function()
            Gamestate.switch(testmap)
        end,
        MMbuttons
    )
    Quit = buttons.newButton(
        "Покидать",
        function()
            love.event.quit(0)   
        end,
        MMbuttons
    )
end



function MainMenu:update(dt)
    ww, wh = love.graphics.getDimensions()
    Start.bx = ww / 2
    Start.by = wh / 2
    Quit.bx = ww / 2
    Quit.by = wh * 3 / 5

    local map
    
    if cam.scale > 1.5 then
        cam:zoomTo(1.5)
    end
    if cam.scale < wh / EUh then
        cam:zoomTo(wh / EUh)
    end
    cam:lockcamera(0, 0, EUw, EUh, 0, ww, 0, wh)
end



function MainMenu:draw()
    cam:attach()
        love.graphics.setShader(BandWshader)
        love.graphics.draw(Europe_194X, 0, 0)
        love.graphics.setShader(nil)
        love.graphics.draw(USSR, 0, 0)
        love.graphics.draw(Poland, 0, 0)
        love.graphics.draw(Czechoslovakia, 0, 0)
        love.graphics.draw(Hungary, 0, 0)
        love.graphics.draw(Romania, 0, 0)
        love.graphics.draw(Bulgaria, 0, 0)
        love.graphics.draw(East_Germany, 0, 0)
    cam:detach()
    
    love.graphics.setFont(Rtitlefont)
    love.graphics.print("НА ЗАПАД!", ww / 2 - Rtitlefont:getWidth("НА ЗАПАД!") / 2, wh / 5)
    
    MMbuttons:use()
end