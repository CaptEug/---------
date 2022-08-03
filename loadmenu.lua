Loadmenu = {}

function Loadmenu:init()
    Rtitlefont = love.graphics.newFont('Russian.ttf', 100)
    Rbuttonfont = love.graphics.newFont('Russian.ttf', 50)
    
    Red_Europe = love.graphics.newImage('Europe/Red_Europe.png')
    --[[USSR = love.graphics.newImage('Europe/USSR.png')
    Poland = love.graphics.newImage('Europe/Poland.png')
    Czechoslovakia = love.graphics.newImage('Europe/Czechoslovakia.png')
    Hungary = love.graphics.newImage('Europe/Hungary.png')
    Romania = love.graphics.newImage('Europe/Romania.png')
    Bulgaria = love.graphics.newImage('Europe/Bulgaria.png')
    East_Germany = love.graphics.newImage('Europe/East_Germany.png')]]--

    EUw, EUh = Red_Europe:getDimensions()
    BandWshader = love.graphics.newShader(BandWshader_code)

    Letsgo = love.audio.newSource('music/俄罗斯军队模范亚历山德罗夫红旗歌舞团 - В путь.mp3', 'stream')
    love.audio.play(Letsgo)

    cam:lookAt(EUw * 2 / 5, EUh * 3/5)
    cam:zoomTo(0.7)
    MMbuttons = buttons.new()
    local ww, wh = love.graphics.getDimensions()
    Start = buttons.newButton(
        "В путь!",
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