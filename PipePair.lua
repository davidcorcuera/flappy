PipePair = Class {}

local MIN_GAP_HEIGHT = 80
local MAX_GAP_HEIGHT = 110

function PipePair:init(y)
    self.x = VIRTUAL_WIDTH + 32
    self.y = y

    gapHeight = math.random(MIN_GAP_HEIGHT, MAX_GAP_HEIGHT)

    self.pipes = {
        ['upper'] = Pipe('top', self.y),
        ['lower'] = Pipe('bottom', self.y + PIPE_HEIGHT + gapHeight)
    }

    self.remove = false

    -- whether or not this pair of pipes has been scored
    self.scored = false
end

function PipePair:update(dt)
    if self.x > -PIPE_WIDTH then
        self.x = self.x - PIPE_SPEED * dt
        self.pipes['lower'].x = self.x
        self.pipes['upper'].x = self.x
    else
        self.remove = true
    end
end

function PipePair:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end
end
