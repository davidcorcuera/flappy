Bird = Class {}

local GRAVITY = 10
local JUMP_FORCE = -2

function Bird:init()
    self.image = love.graphics.newImage('bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - (self.width - 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height - 2)

    -- Y velocity; gravity
    self.dy = 0
end

--[[
    AABB collision that expects a pipe, which will have an X and Y and reference
    global pipe width and height values.
]]
function Bird:collides(pipe)
    -- the 2's are left and top offsets
    -- the 4's are right and bottom offsets
    -- both offsets are used to shrink the bounding box to give the player
    -- a little bit of leeway with the collision
    if (self.x + 2) + (self.width - 4) >= pipe.x and self.x + 2 <= pipe.x + PIPE_WIDTH then
        if (self.y + 2) + (self.height - 4) >= pipe.y and self.y + 2 <= pipe.y + PIPE_HEIGHT then
            return true
        end
    end

    return false
end

function Bird:update(dt)
    -- apply gravity to velocity
    self.dy = self.dy + GRAVITY * dt

    if love.keyboard.wasPressed('space') or love.mouse.wasPressed(1) then
        self.dy = JUMP_FORCE
        sounds['jump']:play()
    end

    -- apply current velocity to Y position
    self.y = self.y + self.dy
end



function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end
