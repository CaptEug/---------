--This is a pixel game
love.graphics.setDefaultFilter('nearest', 'nearest')
--files required
Camera = require 'libraries.utilities.camera'
cam = Camera()
Gamestate = require "libraries.utilities.gamestate"
sti = require 'libraries/sti'
wf = require 'libraries/windfield'
anim8 = require 'libraries/utilities/anim8'
require 'libraries/utilities/CGplayer'
require 'libraries/utilities/buttons'
require 'libraries/utilities/destroyAll'
require 'libraries/utilities/show'
require 'libraries/utilities/copytable'

require 'libraries/Tankfunctions'
require 'libraries.TankSpawner'
require 'libraries.Mapdrawer'
require 'libraries/shaders'

require "NewSaving"
--Gamestates required
require 'gamestates/MainMenu'
require 'gamestates/ingame'
require 'gamestates/Pause'
require 'gamestates/Worldmap'
require 'gamestates/SettingMenu'

--Assets registered
--country
Earth = love.graphics.newImage('Assets/countries/WorldMap.png')
WdMap = sti('Assets/countries/Worldmap.lua')
Worldw, Worldh = Earth:getDimensions()
USSR_flag = love.graphics.newImage('Assets/countries/USSR_Flag.png')
US_flag = love.graphics.newImage('Assets/countries/US_Flag.png')
UK_flag = love.graphics.newImage('Assets/countries/UK_Flag.png')
EastGer_flag = love.graphics.newImage('Assets/countries/EastGer_Flag.png')
WestGer_flag = love.graphics.newImage('Assets/countries/WestGer_Flag.png')
FR_flag = love.graphics.newImage('Assets/countries/FR_Flag.png')
PL_flag = love.graphics.newImage('Assets/countries/PL_Flag.png')
--botton
Stalin = love.graphics.newImage('Assets/pictures/Stalin.png')
StalinRed = love.graphics.newImage('Assets/pictures/Stalin_red.png')
Khrushchev = love.graphics.newImage('Assets/pictures/Khrushchev.png')
KhrushchevRed = love.graphics.newImage('Assets/pictures/Khrushchev_red.png')
Brezhnev = love.graphics.newImage('Assets/pictures/Brezhnev.png')
BrezhnevRed = love.graphics.newImage('Assets/pictures/Brezhnev_red.png')
City_capital = love.graphics.newImage('Assets/pictures/Icons/City_capital.png')
City_capital_Hot = love.graphics.newImage('Assets/pictures/Icons/City_capital_Hot.png')
City_normal = love.graphics.newImage('Assets/pictures/Icons/City_normal.png')
City_normal_Hot = love.graphics.newImage('Assets/pictures/Icons/City_normal_Hot.png')
Berlin_icon = love.graphics.newImage('Assets/pictures/icons/Berlin_icon.png')
UVZ_Icon = love.graphics.newImage('Assets/pictures/icons/UVZ_Icon.png')
leftArrow = love.graphics.newImage('Assets/pictures/buttons/leftArrow.png')
rightArrow = love.graphics.newImage('Assets/pictures/buttons/rightArrow.png')
plus_icon = love.graphics.newImage('Assets/pictures/buttons/Plus.png')
greyplus_icon = love.graphics.newImage('Assets/pictures/buttons/Greyplus.png')
minus_icon = love.graphics.newImage('Assets/pictures/buttons/Minus.png')
greyminus_icon = love.graphics.newImage('Assets/pictures/buttons/Greyminus.png')
Close_icon = love.graphics.newImage('Assets/pictures/buttons/X.png')
ClosePanel_icon = love.graphics.newImage('Assets/pictures/buttons/TankInfoPanel_Close.png')
ManulControl_icon = love.graphics.newImage('Assets/pictures/buttons/manul_control.png')
ManulControlOn_icon = love.graphics.newImage('Assets/pictures/buttons/manul_control_On.png')
SetCommander_icon = love.graphics.newImage('Assets/pictures/buttons/set_commander.png')
SetCommanderOn_icon = love.graphics.newImage('Assets/pictures/buttons/set_commander_On.png')
Fortify_icon = love.graphics.newImage('Assets/pictures/buttons/fortify.png')
FortifyOn_icon = love.graphics.newImage('Assets/pictures/buttons/fortify_On.png')
Armor_icon = love.graphics.newImage('Assets/pictures/buttons/Armor.png')
Armor_Hot = love.graphics.newImage('Assets/pictures/buttons/Armor_Hot.png')
Aiming_icon = love.graphics.newImage('Assets/pictures/buttons/Aiming.png')
Aiming_Hot = love.graphics.newImage('Assets/pictures/buttons/Aiming_Hot.png')
Ammo_icon = love.graphics.newImage('Assets/pictures/buttons/Ammo.png')
Ammo_Hot = love.graphics.newImage('Assets/pictures/buttons/Ammo_Hot.png')
Mobility_icon = love.graphics.newImage('Assets/pictures/buttons/Mobility.png')
Mobility_Hot = love.graphics.newImage('Assets/pictures/buttons/Mobility_Hot.png')
Go = love.graphics.newImage('Assets/pictures/buttons/Go.png')
Go_Hot = love.graphics.newImage('Assets/pictures/buttons/GoHot.png')
Oil_icon = love.graphics.newImage('Assets/pictures/Icons/Oil.png')
Steel_icon = love.graphics.newImage('Assets/pictures/Icons/Steel.png')
Build_icon = love.graphics.newImage('Assets/pictures/buttons/Build.png')
Build_Hot = love.graphics.newImage('Assets/pictures/buttons/Build_Hot.png')
Delete_icon = love.graphics.newImage('Assets/pictures/buttons/Delete.png')
EquipmentSelect = love.graphics.newImage('Assets/pictures/buttons/EquipmentSelect.png')
EquipmentSelectHot = love.graphics.newImage('Assets/pictures/buttons/EquipmentSelectHot.png')
invisible_button = love.graphics.newImage('Assets/pictures/buttons/Invisible_button.png')
Edit_button = love.graphics.newImage('Assets/pictures/buttons/Edit.png')
Done_button = love.graphics.newImage('Assets/pictures/buttons/Done.png')
--UI
Gear = love.graphics.newImage('Assets/pictures/icons/Gear.png')
Tank_icon = love.graphics.newImage('Assets/pictures/Icons/Tank_icon.png')
Tankdesigner_icon = love.graphics.newImage('Assets/pictures/icons/Tankdesigner.png')
RadioStation_icon = love.graphics.newImage('Assets/pictures/icons/RadioStation.png')
ArmyEditor_icon = love.graphics.newImage('Assets/pictures/Icons/ArmyEditor.png')
factory_screen = love.graphics.newImage('Assets/pictures/factory_screen.png')
ArmyEditor_screen = love.graphics.newImage('Assets/pictures/ArmyEditorScreen.png')
ArmyEditor_list = love.graphics.newImage('Assets/pictures/ArmyEditorList.png')
city_page = love.graphics.newImage('Assets/pictures/Citypage.png')
production_box = love.graphics.newImage('Assets/pictures/Pbox.png')
tank_info_panel = love.graphics.newImage('Assets/pictures/TankInfoPanel.png')
crew_icon = love.graphics.newImage('Assets/pictures/Icons/crew_member.png')
injured_crew_icon = love.graphics.newImage('Assets/pictures/Icons/crew_member_injured.png')
ERA_icon = love.graphics.newImage('Assets/pictures/Icons/ERA.png')
Immobilized_icon = love.graphics.newImage('Assets/pictures/Icons/Immobilized.png')
Onfire_icon = love.graphics.newImage('Assets/pictures/Icons/Onfire!.png')
AP_icon = love.graphics.newImage('Assets/pictures/Icons/AP.png')
HE_icon = love.graphics.newImage('Assets/pictures/Icons/HE.png')
HEAT_icon = love.graphics.newImage('Assets/pictures/Icons/HEAT.png')
APFSDS_icon = love.graphics.newImage('Assets/pictures/Icons/APFSDS.png')
Picked_icon = love.graphics.newImage('Assets/pictures/Icons/Picked.png')
Choosen_icon = love.graphics.newImage('Assets/pictures/Icons/Choosen.png')
Coms_icon = love.graphics.newImage('Assets/pictures/Icons/Coms.png')
--audio
cg1 = CG.new('Assets/audio/OP.ogv')
Letsgo = love.audio.newSource('Assets/audio/music/俄罗斯军队模范亚历山德罗夫红旗歌舞团 - В путь.mp3', 'stream')
--cursor
pointcursor = love.mouse.newCursor('Assets/pictures/cursors/PointCursor.png', 0, 0)
handcursor = love.mouse.newCursor('Assets/pictures/cursors/HandCursor.png', 7, 0)
sightcursor = love.mouse.newCursor('Assets/pictures/cursors/SightCursor.png', 16, 16)
--font
Rtitlefont = love.graphics.newFont('Assets/fonts/pixelfont.otf', 100)
Rbuttonfont = love.graphics.newFont('Assets/fonts/pixelfont.otf', 50)
Rheadfont = love.graphics.newFont('Assets/fonts/pixelfont.otf', 20)
Rtextfont = love.graphics.newFont('Assets/fonts/pixelfont.otf')


Maps={'checkpointC','Testmap','UVZfac'}
MapNumber=1
Filenumber=1

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(MainMenu)
    world = wf.newWorld(0, 0)
    particleworld = wf.newWorld(0, 0)
    
    addCollisionClass()

    love.mouse.setCursor(Cursor)
    NewSaving:LoadSettings()
end



function love.update(dt)
    ww, wh = love.graphics.getDimensions()
    cammovement()
end



function love.draw()
    --cg1:playCG()
    --keep cursor 
    Cursor = pointcursor
    Cursormode = 'normal'
end



function cammovement()
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

function DrawMaps()
    --love.graphics.draw(Earth, 0, 0)
    WdMap:drawLayer(WdMap.layers['Earth'])
end

function DrawCountries()
    Countries = {}
    for i, country in pairs(Countries) do
        love.graphics.draw(country, 0, 0)
    end
end

function addCollisionClass()
    world:addCollisionClass('APCBC')
    world:addCollisionClass('HE')
    world:addCollisionClass('HEAT')
    world:addCollisionClass('APDS')
    world:addCollisionClass('APFSDS')
    world:addCollisionClass('Amour')
    world:addCollisionClass('Wall')
    world:addCollisionClass('Explosion')
    world:addCollisionClass('tankhull')
end