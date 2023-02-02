Worldmap = {}
Worldmap = Gamestate.new()

require 'UI/WorldmapUI'
require 'Data/CitiesAndFactories'
require 'Data/TankData'

function Worldmap:init()
    CitiesAndFactories:load()
    TankData:load()
    WorldmapUI:load()

end

function Worldmap:update(dt)

    WorldmapUI:update(dt)
    --secret map
    if love.keyboard.isDown('g') then
        MapNumber=2
        Saving:fileload()
    end
    
    if cam.scale > 2 then
        cam:zoomTo(2)
    end
    if cam.scale < wh / Worldh then
        cam:zoomTo(wh / Worldh)
    end
    cam:lockcamera(0, 0, Worldw, Worldh, 0, ww, 0, wh)
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
end