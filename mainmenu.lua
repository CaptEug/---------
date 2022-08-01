mainmenu = {}

require 'chapters/Berlin'

local buttons = {}

function newButton(text, fn)
    local instance = {
            text = text,
            fn = fn,
            w = Rbuttonfont:getWidth(text),
            h = Rbuttonfont:getHeight(text),
            now = false,
            last = false
    }
    table.insert(buttons, instance)
    return instance
end



function mainmenu:load()
    StartState = false
    
    Rtitlefont = love.graphics.newFont('Russian.ttf', 100)
    Rbuttonfont = love.graphics.newFont('Russian.ttf', 50)
    

    Start = newButton(
        "Путь!",
        function()
            StartState = true
        end
    )
    
    Quit = newButton(
        "Покидать",
        function()
            love.event.quit(0)   
        end
    )
    
    if StartState then
        Berlin:load()
    end
end



function mainmenu:update(dt)
    if StartState then
        Berlin:update(dt)
    end
end



function mainmenu:draw()
    love.graphics.setFont(Rtitlefont)
    love.graphics.print("НА ЗАПАД!", ww / 2 - Rtitlefont:getWidth("НА ЗАПАД!") / 2, wh / 5)
    
    for k, button in ipairs(buttons) do
        button.last = button.now
        
        local ButtonColor = {1, 1, 1, 0.5}
        local bx = ww / 2 - button.w / 2
        local by = wh / 2 + 80 * k
        local mx, my = love.mouse.getPosition()
        local Hot = mx>=bx and mx<=bx+button.w and my>=by and my<=by+button.h
        
        love.graphics.setFont(Rbuttonfont)
        
        if Hot then
            ButtonColor ={1, 0.2, 0.2, 1}
        end
        
        if love.mouse.isDown(1) and Hot then
            button.fn()
        end
        
        love.graphics.setColor(unpack(ButtonColor))
        love.graphics.print(button.text, bx, by)

        if StartState then
            Berlin:draw()
        end
    end
    
    --love.graphics.setColor(1, 1, 1)
end