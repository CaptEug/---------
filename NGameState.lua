
NGameState = {

    ThreadGnenerator = function (name)
        local t = love.thread.newThread(name)
        return t
    end
}

TestThread = [[

Ingamebuttons = {}
ingame = {}

require 'gamestates.Ingame.ingameUI'
require 'gamestates/Ingame/Mapdrawer'
require 'Data.Tank.TankSpawner'
require 'Data.Constructure.ConstructureSpawner'
require 'gamestates.Ingame.TimeToShoot'
function ingame:init()
    DestroyAll()

    local map=Maps[MapNumber]
    loadMap(map)
    ingameUI:load()

    --square selection
    selection = {}
    selection.active = false

    BuildEnemytank(CurrentPlace, Tanks.M1, 1500, 500)
end

function ingame:update(dt)
    ingameUI:update(dt)
    world:update(dt)
    particleworld:update(dt)
    TankSpawner:update(dt)
    ConstructureSpawner:update(dt)
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
        if CurrentPlace.openTankDesigner then
            TDmousepressed(x, y, button)
        end
        if CurrentPlace.openCityInfoPenal then
            AEmousepressed(x, y, button)
        end
        if CurrentPlace.openConstructMenu then
            CMmousepressed(x, y, button)
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
        if CurrentPlace.openTankDesigner then
            TDmousereleased(x, y, button)
        end
        if CurrentPlace.openCityInfoPenal then
            AEmousereleased(x, y, button)
        end
        if CurrentPlace.openConstructMenu then
            CMmousereleased(x, y, button)
        end
        if TankPanelopen then
            TPmousereleased(x, y, button)
        end
        BuildDetact(button)
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
        if CurrentPlace.openTankDesigner then
            TDmousemoved(x, y, dx, dy)
        end
        if CurrentPlace.openCityInfoPenal then
            AEmousemoved(x, y, dx, dy)
        end
        if CurrentPlace.openConstructMenu then
            CMmousemoved(x, y, dx, dy)
        end
        if TankPanelopen then
            TPmousemoved(x, y, dx, dy)
        end
    end
end

function ingame:draw()
    cam:attach()
        DrawMapDown()
        ConstructureSpawner:drawbuilding()
        TankSpawner:drawtank()
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
end

function ingame:drawWithoutUI()
    cam:attach()
        DrawMapDown()
        TankSpawner:drawtank()
        DrawMapUp()
        world:draw()
        particleworld:draw()
        TankProjectiles:draw()
    cam:detach()
end

]]

WorldCode = [[
Worldmap = {}

require 'gamestates/Worldmap/WorldmapUI'
require 'Data/Cities'
require 'Data.Tank.Tanks'
require 'Data.Tank.Tankfunctions'
require 'Data/Constructure/Constructures'
require 'Data/Constructure/Constructurefunctions'

function Worldmap:init()
    Year = 1946
    Cities:load()

    NewSaving:LoadFile(Filenumber)
    NewSaving:LoadResource()

    WorldmapUI:load()
end

function Worldmap:update(dt)
    WorldmapUI:update(dt)
    --secret map
    if love.keyboard.isDown('g') then
        MapNumber=2
        Saving:fileload()
    end
    --cam contral
    if cam.scale > 4 then
        cam:zoomTo(4)
    end
    if cam.scale < wh / Worldh then
        cam:zoomTo(wh / Worldh)
    end
    cam:lockcamera(0, 0, Worldw, Worldh, 0, ww, 0, wh)

    --resources update
    Steel = Steel + SteelProduction*dt
    Oil = Oil + OilProduction*dt
end

function Worldmap:draw()
    cam:attach()
        DrawMaps()
        DrawCountries()
    cam:detach()

    WorldmapUI:draw()
end

function Worldmap:drawWithoutUI()
    cam:attach()
        DrawMaps()
        DrawCountries()
    cam:detach()
end]]

TestIngame = love.thread.newThread(TestThread)
TestWorld = love.thread.newThread(WorldCode)
