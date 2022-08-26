return{
    turret_to_target = function(self, dt, x, y)
        local turret = self:get "turret"
        local turret1 = self:get "turret_rdata"
        local move = self:get "move"
        local angle_to_target = math.atan2(y - turret.y,x - turret.x)
        local isaim = false
        if angle_to_target <= 0 then
            angle_to_target = angle_to_target + math.pi*2
        end
     

        while turret1.angle > 2*math.pi do
            turret1.angle = turret1.angle - 2*math.pi
        end

        while turret1.angle < 0 do
            turret1.angle = turret1.angle + 2*math.pi
        end

        if turret1.angle > angle_to_target then
            if turret1.angle - angle_to_target <= math.pi then
                turret1.angledrta = turret1.angledrta - turret1.max_Rotation_speed*0.5*dt
            else
                turret1.angledrta = turret1.angledrta + turret1.max_Rotation_speed*0.5*dt
            end
        end

        if turret1.angle < angle_to_target then
            if angle_to_target - turret1.angle <= math.pi then
                turret1.angledrta = turret1.angledrta + turret1.max_Rotation_speed*0.5*dt
            else
                turret1.angledrta = turret1.angledrta - turret1.max_Rotation_speed*0.5*dt
            end
        end

        if turret1.angle < angle_to_target + math.pi/36 and turret1.angle > angle_to_target - math.pi/36 then
            isaim = true
        end


        turret1.angle = move.angle + turret1.angledrta
        return isaim

    end
}