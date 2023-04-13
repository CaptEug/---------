ingame = {}
ingame = Gamestate.new()

require 'UI.ingameUI'
require 'libraries/TankSpawner'
require 'libraries/EnemySpawner'
require 'libraries/TimeToShoot'
function ingame:init()
    Gbuttons = buttons.new()
    Settings = buttons.newToolButton(
        Gear,
        function()
            Gamestate.push(Pause)
        end,
        Gbuttons,
        16,
        wh - 16
    )

    local map=Maps[MapNumber]
    loadMap(map)
    ingameUI:load()

    --square selection
    selection = {}
    selection.active = false

    BuildEnemytank(CurrentPlace, M1, 1500, 500)
end

function ingame:update(dt)
    ingameUI:update(dt)
    world:update(dt)
    particleworld:update(dt)
    TankSpawner:update(dt)
    TankProjectiles:update(dt)
    --cam contral
    if cam.scale > 2 then
        cam:zoomTo(2)
    end
    if cam.scale < 0.2 then
        cam:zoomTo(0.2)
    end
    --mouse input
    function love.mousepressed(x, y, button)
        if CurrentPlace.opendesigner then
            TDmousepressed(x, y, button)
        end
        if CurrentPlace.openarmyeditor then
            AEmousepressed(x, y, button)
        end
        if TankPanelopen then
            TPmousepressed(x, y, button)
        end
        if button == 1 and Cursormode == 'normal' then
            selection.active = true
            selection.startX = x
            selection.startY = y
        end
    end
    function love.mousereleased(x, y, button)
        if CurrentPlace.opendesigner then
            TDmousereleased(x, y, button)
        end
        if CurrentPlace.openarmyeditor then
            AEmousereleased(x, y, button)
        end
        if TankPanelopen then
            TPmousereleased(x, y, button)
        end
        if button == 1 and selection.active then
            selection.active = false
            selection.endX = x
            selection.endY = y
        end
        if selection.startX ~= selection.endX and selection.startY ~= selection.endY then
            for i, tank in ipairs(CurrentPlace.exsist_tank) do
                local x,y = cam:cameraCoords(tank.location.x, tank.location.y)
                if ((x > selection.startX and x < selection.endX) or (x < selection.startX and x > selection.endX)) and 
                ((y > selection.startY and y < selection.endY) or (y < selection.startY and y > selection.endY)) then
                    if tank.type == 'Friendly' then
                        tank.picked = true
                    end
                else
                    tank.picked = false
                end
            end
        end
    end
    function love.mousemoved(x, y, dx, dy)
        if CurrentPlace.opendesigner then
            TDmousemoved(x, y, dx, dy)
        end
        if CurrentPlace.openarmyeditor then
            AEmousemoved(x, y, dx, dy)
        end
        if TankPanelopen then
            TPmousemoved(x, y, dx, dy)
        end
    end
end

function ingame:draw()
    cam:attach()
        DrawMapDown()
        TankSpawner:draw_tank()
        DrawMapUp()
        world:draw()
        particleworld:draw()
        TankProjectiles:draw()
    cam:detach()
    
    --draw selection
    if selection.active and Cursormode == 'normal' then
        love.graphics.setColor(0,179/255,0)
        love.graphics.rectangle("line", selection.startX, selection.startY,
        love.mouse.getX() - selection.startX, love.mouse.getY() - selection.startY)
    end

    ingameUI:draw()
    Gbuttons:use()
end

function ingame:drawWithoutUI()
    cam:attach()
        DrawMapDown()
        TankSpawner:draw_tank()
        DrawMapUp()
        world:draw()
        particleworld:draw()
        TankProjectiles:draw()
    cam:detach()
end
