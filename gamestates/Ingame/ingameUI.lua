ingameUI={}
require 'gamestates.Ingame.TankDesigner'
require 'gamestates.Ingame.TankInfoPanel'
require 'gamestates.Ingame.ArmyEditor'
require 'gamestates.Ingame.ConstructMenu'

function ingameUI:load()
    TankInfoPanel:load()
    ArmyEditor:load()

    --buttons in captured
    Ingamebuttons.DefButtons = buttons.new()
    Settings = buttons.newToolButton(
        Gear,
        function()
            Gamestate.push(Pause)
        end,
        Ingamebuttons.DefButtons,
        16,
        wh - 16
    )
    RadioStation = buttons.newToolButton(
        RadioStation_icon,
        function ()
            Cities:playRadio(CurrentPlace.songlist)
        end,
        Ingamebuttons.DefButtons,
        ww - 16,
        wh - 16
    )
    ArmyEditor_button = buttons.newToolButton(
        ArmyEditor_icon,
        function ()
            if CurrentPlace.openArmyEditor then
                CurrentPlace.openArmyEditor = false
            else
                CurrentPlace.openArmyEditor = true
            end
        end,
        Ingamebuttons.DefButtons
    )

    if CurrentPlace.state == 'Peace' then
        ConstructMenu:load()
        Ingamebuttons.ConstructButtons = buttons.new()
        ConstructMenu_button = buttons.newToolButton(
            Constructmenu_icon,
            function ()
                if CurrentPlace.openConstructMenu then
                    CurrentPlace.openConstructMenu = false
                else
                    CurrentPlace.openConstructMenu = true
                end
            end,
            Ingamebuttons.ConstructButtons,
            80
        )
        if CurrentPlace.factory then
            TankDesigner:load()
            Ingamebuttons.TankFacButtons = buttons.new()
            FacDesigner = buttons.newToolButton(
                Tankdesigner_icon,
                function ()
                    if CurrentPlace.openTankDesigner then
                        CurrentPlace.openTankDesigner = false
                    else
                        CurrentPlace.openTankDesigner = true
                    end
                end,
                Ingamebuttons.TankFacButtons,
                48
            )
        end
    end
    if CurrentPlace.state == 'Battlefield' then

    end
end

function ingameUI:update(dt)
    TankInfoPanel:update(dt)
    ArmyEditor:update(dt)
    if CurrentPlace.state == 'Peace' then
        ConstructMenu:update(dt)
        if CurrentPlace.factory then
            TankDesigner:update(dt)
        end
    end
    if CurrentPlace.state == 'Battlefield' then
        
    end
end

function ingameUI:draw()
    Ingamebuttons.DefButtons:use()
    TankInfoPanel:draw()
    ArmyEditor:draw()
    if CurrentPlace.state == 'Peace' then
        Ingamebuttons.ConstructButtons:use()
        ConstructMenu:draw()
        if CurrentPlace.factory then
            Ingamebuttons.TankFacButtons:use()
            TankDesigner:draw()
        end
    end
    if CurrentPlace.state == 'Battlefield' then
        
    end
    PenetrateLog()
end