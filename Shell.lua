Shell = {}

function createshell()
    local speed = 256
    local mx, my = cam:mousePosition(ox,oy,w,h)
    local angle = math.atan2(my - MAUS1.y, mx - MAUS1.x)
    local vx, vy = math.cos(angle) * speed,
                   math.sin(angle) * speed
    local shell = world:newRectangleCollider(MAUS1.x + 100, MAUS1.y + 100, 10, 10)
    shell:setLinearVelocity(vx, vy)
end