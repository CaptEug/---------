Cities = {}
City = {}
City.__index = City

--Cities
--USSR
--[[Moskva = {}
Moskva = Gamestate.new()
Moskva.x = 1160
Moskva.y = 580
Moskva.country = {}
Moskva.name = 'Moskva'
Moskva.type = 'Capital'
Moskva.state = 'Peace'
Moskva.oil_stored = 0
Moskva.steel_stored = 0
Moskva.oil_production = 0
Moskva.steel_production = 0
Moskva.researchinstitude = {}
Moskva.map = sti("Assets/maps/Testmap.lua")
Moskva.world = wf.newWorld(0, 0)
Moskva.Structure = {}
Moskva.Obstacles = {}
Moskva.constructurelist = {}
Moskva.exsist_tank = {}
Moskva.exsist_ship = {}
Moskva.exsist_building = {}
Moskva.Army = {}
Moskva.broken_tank={}

Nizhny_Tagil = {}
Nizhny_Tagil = Gamestate.new()
Nizhny_Tagil.x = 1280
Nizhny_Tagil.y = 555
Nizhny_Tagil.country = {}
Nizhny_Tagil.name = 'Nizhny Tagil'
Nizhny_Tagil.type = 'Normal'
Nizhny_Tagil.state = 'Peace'
Nizhny_Tagil.oil_stored = 0
Nizhny_Tagil.steel_stored = 0
Nizhny_Tagil.oil_production = 0
Nizhny_Tagil.steel_production = 0
Nizhny_Tagil.tankfactory = {
    name = 'UVZ',
    tanklist = {}
}
Nizhny_Tagil.map = sti("Assets/maps/UVZfac.lua")
Nizhny_Tagil.world = wf.newWorld(0, 0)
--map collider
Nizhny_Tagil.Structure = {}
Nizhny_Tagil.Obstacles = {}
Nizhny_Tagil.Coast = {}
Nizhny_Tagil.Ocean = {}
Nizhny_Tagil.Oil = {}
Nizhny_Tagil.constructurelist = {}
Nizhny_Tagil.Army = {}
Nizhny_Tagil.exsist_tank = {}
Nizhny_Tagil.exsist_ship = {}
Nizhny_Tagil.broken_tank = {}
Nizhny_Tagil.exsist_building = {}
Nizhny_Tagil.songlist = {}]]

TestField = {}
TestField = Gamestate.new()
TestField.x = 1467
TestField.y = 884
TestField.country = {}
TestField.name = 'Test Field'
TestField.type = 'Normal'
TestField.state = 'Peace'
TestField.oil_stored = 0
TestField.steel_stored = 0
TestField.oil_production = 0
TestField.steel_production = 0
TestField.tankfactory = {
    name = 'Test Factory',
    tanklist = {}
}
TestField.map = sti("Assets/maps/TestField.lua")
TestField.world = wf.newWorld(0, 0)
--map collider
TestField.Structure = {}
TestField.Obstacles = {}
TestField.Coast = {}
TestField.Ocean = {}
TestField.Oil = {}
TestField.constructurelist = {}
TestField.Army = {}
TestField.exsist_tank = {}
TestField.exsist_ship = {}
TestField.broken_tank = {}
TestField.exsist_building = {}
TestField.songlist = {}


--RadioList
TestSonglist = {
    {love.audio.newSource('Assets/audio/music/KINO/Кино - Кукушка.mp3', 'stream')},
    {love.audio.newSource('Assets/audio/music/KINO/Кино - Кончится лето.mp3', 'stream')},
    {love.audio.newSource('Assets/audio/music/KINO/Кино - Красно-желтые дни.mp3', 'stream')}
}

function Cities:load()
    TestField.country = {}
    setmetatable(TestField, City)
    table.insert(Cities, TestField)

    --[[Nizhny_Tagil.country = {USSR_flag}
    Nizhny_Tagil.songlist = TestSonglist
    setmetatable(Nizhny_Tagil, City)
    table.insert(Cities, Nizhny_Tagil)]]
end

function Cities:playRadio(songlist)
    local songindex = math.random(0, #songlist-1)
    if love.audio.getActiveSourceCount( ) then
        love.audio.stop()
    end
    if love.audio.getActiveSourceCount( ) == 0 then
        if songindex < #songlist then
            songindex = songindex + 1
            love.audio.play(songlist[songindex])
        end
    end
end

function City:init()
    self.world:addCollisionClass('Coast')
    self.world:addCollisionClass('Ocean',{ignores = {'Coast'}})
    self.world:addCollisionClass('APCBC', {ignores = {'Coast','Ocean'}})
    self.world:addCollisionClass('HE', {ignores = {'Coast','Ocean'}})
    self.world:addCollisionClass('HEAT', {ignores = {'Coast','Ocean'}})
    self.world:addCollisionClass('APDS', {ignores = {'Coast','Ocean'}})
    self.world:addCollisionClass('APFSDS', {ignores = {'Coast','Ocean'}})
    self.world:addCollisionClass('ATGM', {ignores = {'Coast','Ocean'}})
    self.world:addCollisionClass('Wall')
    self.world:addCollisionClass('Fregment', {ignores = {'Fregment','Coast','Ocean'}})
    self.world:addCollisionClass('TankHull', {ignores = {'Coast'}})
    self.world:addCollisionClass('ShipHull', {ignores = {'Ocean'}})
    self.world:addCollisionClass('Constructure')
    self.world:addCollisionClass('Oil',{ignores = {'ShipHull','TankHull'}})
    self:loadmap()
    ChapterUI:load()
    Buildtank(CurrentPlace, Tanks.M1, 'friendly', 1000, 1000)
    Buildtank(CurrentPlace, Tanks.M1, 'enemy', 2000, 1000)
    Buildtank(CurrentPlace, TDs.XM8LOSAT, 'enemy', 2200, 1000)
    --Buildship(CurrentPlace, Ships.Montana,'friendly', 3000, 0)
    NewSaving:LoadTanks()
end

function City:LocationDiscretize()
    local mouseX,mouseY = cam:mousePosition()
    IntX, IntY = 32*math.floor(mouseX/32),32*math.floor(mouseY/32)
end

function City:update(dt)
    self.world:update(dt)
    self:LocationDiscretize()
    particleworld:update(dt)
    TankSpawner:update(dt)
    ShipSpawner:update(dt)
    ConstructureSpawner:update(dt)
    TankProjectiles:update(dt)
    Missiles:update(dt)
    Explosives:update(dt)
    Fragments:update(dt)
    Particles:update(dt)
    ChapterUI:update(dt)
    ResourceUpdate(self)
    --cam contral
    if cam.scale > 2 then
        cam:zoomTo(2)
    end
    if cam.scale < 0.2 then
        cam:zoomTo(0.2)
    end
    --mouse input
    function love.mousepressed(x, y, button)
        SelectionMousePressed(x, y, button)
        Windows:mousepressed(x, y, button)
    end

    function love.mousereleased(x, y, button)
        SelectionMouseReleased(x, y, button)
        Windows:mousereleased(x, y, button)
        BuildDetact(button)
    end
    
    function love.mousemoved(x, y, dx, dy)
        Windows:mousemoved(x, y)
    end
end

function ResourceUpdate(city)
    local steel, oil, steel_p, oil_p = 0, 0, 0, 0
    for i, building in ipairs(city.exsist_building) do
        if building.class == 'resource' then
            if building.steel_stored then
                steel = steel + building.steel_stored
            end
            if building.oil_stored then
                oil = oil + building.oil_stored
            end
            if building.steel_production then
                steel_p = steel_p + building.steel_production
            end
            if building.oil_production then
                oil_p = oil_p + building.oil_production
            end
        end
    end
    city.steel_stored = steel
    city.oil_stored = oil
    city.steel_production = steel_p
    city.oil_production = oil_p
end

function City:draw()
    self:drawWithoutUI()
    ChapterUI:draw()
end

function City:drawWithoutUI()
    cam:attach()
        self:DrawMapDown()
        ConstructureSpawner:drawbuilding()
        TankSpawner:drawtank()
        ShipSpawner:drawship()
        Explosives:draw()
        self:DrawMapUp()
        self.world:draw()
        --particleworld:draw()
        TankProjectiles:draw()
        Particles:draw()
        Missiles:draw()
    cam:detach()
end

function City:keypressed(key)
    if key == 'escape' then
        return Gamestate.push(Pause)
    end
end

function City:loadmap()
    if self.map.layers['Structure'] then
        for i, j in pairs(self.map.layers['Structure'].objects) do
            local Collider = self.world:newRectangleCollider(j.x, j.y, j.width, j.height)
            Collider.width = j.width
            Collider.height = j.height
            Collider:setType('static')
            Collider:setCollisionClass('Wall')
            table.insert(self.Structure, Collider)
        end
    end

    if self.map.layers['Obstacles'] then
        for i, j in pairs(self.map.layers['Obstacles'].objects) do
            local Collider = self.world:newRectangleCollider(j.x, j.y, j.width, j.height)
            Collider.width = j.width
            Collider.height = j.height
            table.insert(self.Obstacles, Collider)
        end
    end

    if self.map.layers['Coast'] then
        for i, j in pairs(self.map.layers['Coast'].objects) do
            local Collider = self.world:newRectangleCollider(j.x, j.y, j.width, j.height)
            Collider.width = j.width
            Collider.height = j.heights
            Collider:setType('static')
            Collider:setCollisionClass('Coast')
            table.insert(self.Coast, Collider)
        end
    end

    if self.map.layers['Ocean'] then
        for i, j in pairs(self.map.layers['Ocean'].objects) do
            local Collider = self.world:newRectangleCollider(j.x, j.y, j.width, j.height)
            Collider.width = j.width
            Collider.height = j.heights
            Collider:setType('static')
            Collider:setCollisionClass('Ocean')
            table.insert(self.Ocean, Collider)
        end
    end

    if self.map.layers['Oil'] then
        for i, j in pairs(self.map.layers['Oil'].objects) do
            local Collider = self.world:newRectangleCollider(j.x, j.y, j.width, j.height)
            Collider.width = j.width
            Collider.height = j.heights
            Collider:setType('static')
            Collider:setCollisionClass('Oil')
            table.insert(self.Oil, Collider)
        end
    end
end

function City:DrawMapDown()

    if self.map.layers["Resource"] then
        self.map:drawLayer(self.map.layers["Resource"])
    end
    if self.map.layers["Ground"] then
        self.map:drawLayer(self.map.layers["Ground"])
    end
    if self.map.layers["Objects"] then
        self.map:drawLayer(self.map.layers["Objects"])
    end
    if self.map.layers["Buildings"] then
        self.map:drawLayer(self.map.layers["Buildings"])
    end
    if self.map.layers["Coast water"] then
        self.map:drawLayer(self.map.layers["Coast water"])
    end
    if self.map.layers["Ocean water"] then
        self.map:drawLayer(self.map.layers["Ocean water"])
    end
    for i, j in pairs(self.Obstacles) do
        local collider_x,collider_y = j:getPosition()
        local collider_angle = j:getAngle()
        love.graphics.draw(love.graphics.newImage("Assets/objects/Spike1.png"), collider_x,collider_y, collider_angle, 1, 1, j.width/2, j.height/2)
    end
end

function City:DrawMapUp()
    if self.map.layers["Ceiling"] then
        self.map:drawLayer(self.map.layers["Ceiling"])
    end

    if self.map.layers["Roof"] and cam.scale < 1 then
        love.graphics.setColor(1,1,1,0.5/cam.scale)
        self.map:drawLayer(self.map.layers["Roof"])
        love.graphics.setColor(1,1,1)
    end

    if self.map.layers["Sky"] then
        self.map:drawLayer(self.map.layers["Sky"])
    end
end

function CostResource(steel, oil)
    local steelcost = steel
    for i, building in ipairs(CurrentPlace.exsist_building) do
        if building.class == 'resource' then
            if building.steel_stored then
                if building.steel_stored > steelcost then
                    building.steel_stored = building.steel_stored - steelcost
                    break
                else
                    steelcost = steelcost - building.steel_stored
                    building.steel_stored = 0
                end
            end
        end
    end
    local oilcost = oil
    for i, building in ipairs(CurrentPlace.exsist_building) do
        if building.class == 'resource' then
            if building.oil_stored then
                if building.oil_stored > oilcost then
                    building.oil_stored = building.oil_stored - oilcost
                    break
                else
                    oilcost = oilcost - building.oil_stored
                    building.oil_stored = 0
                end
            end
        end
    end
end