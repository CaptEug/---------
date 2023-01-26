TankSpawner={}
TurretCollider={}

function TankSpawner:loadTank()
    
end

function TankSpawner:spawn(place)
    --table.insert(Exsistank,TankFunctions:newtank())
    TankColliders()
end

function TankColliders(place)
    table.insert(TurretCollider,world:newRectangleCollider(100 + 100*Dx, 100,100,100))
    local turretcollider={}
    Dx=Dx+1
end

function TankSpawner:draw(place)
    --[[for i,t in ipairs(Exsistank) do
        love.graphics.draw(t.hull_image)
        love.graphics.draw(t.turret_image)
    end]]
    for i, tank in ipairs(place.tankstock) do
        love.graphics.draw(tank.hull_image, 100 + 100*i, 100)
        love.graphics.draw(tank.armor.hull_image, 100 + 100*i, 100)
        love.graphics.draw(tank.turret_image, 100 + 100*i, 100)
        love.graphics.draw(tank.armor.turret_image, 100 + 100*i, 100)
    end
end

function TankSpawner:load()
    world:addCollisionClass('tankhull')
    world:addCollisionClass('tankturret',{ignores={'tankhull'}})
end

function TankSpawner:testspawn(place)
    for i,tank in ipairs(place.tankstock) do
        local x,y,w,h=100,200,tank.width,tank.length

        testcollider=world:newRectangleCollider(x+100*Dx , y,w,h)
        testcollider:setCollisionClass('tankhull')
        testcollider_turret=world:newCircleCollider(x+100*Dx+w/2,y+h/2,25)
        testcollider_turret:setCollisionClass('tankturret')
        
    end
end

function TankSpawner:testdraw(place)
    if testcollider~=nil then
        for i,tank in ipairs(place.tankstock) do
            local x,y=testcollider:getPosition()
            local a=testcollider:getAngle()
            local ox=tank.hull_image:getWidth()/2
            local oy=tank.hull_image:getHeight()/2
            love.graphics.draw(tank.hull_image,x,y,a,1,1,ox,oy)
            love.graphics.draw(tank.armor.hull_image, x,y,1,1,ox, oy)
            love.graphics.draw(tank.turret_image,x,y,a,1,1,ox,oy)
            love.graphics.draw(tank.armor.turret_image, x, y,a,1,1,ox,oy)
        end
    end
end