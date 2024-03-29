--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu
    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]
ScoreState = Class { __includes = BaseState }

GOLDEN_MEDAL_SCORE = 30
SILVER_MEDAL_SCORE = 20
BRONZE_MEDAL_SCORE = 10




--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    if self.score < BRONZE_MEDAL_SCORE then
        love.graphics.printf('No medal won!', 0, 124, VIRTUAL_WIDTH, 'center')
    elseif self.score < SILVER_MEDAL_SCORE then
        love.graphics.printf('Broze Medal won!', 0, 124, VIRTUAL_WIDTH, 'center')
        self.medalImage = love.graphics.newImage('bronze-medal.png')
        love.graphics.draw(self.medalImage, (VIRTUAL_WIDTH - self.medalImage:getWidth()) / 2, 140)
    elseif self.score < GOLDEN_MEDAL_SCORE then
        love.graphics.printf('Silver Medal won!', 0, 124, VIRTUAL_WIDTH, 'center')
        self.medalImage = love.graphics.newImage('silver-medal.png')
        love.graphics.draw(self.medalImage, (VIRTUAL_WIDTH - self.medalImage:getWidth()) / 2, 140)
    else
        love.graphics.printf('Golden Medal won!', 0, 124, VIRTUAL_WIDTH, 'center')
        self.medalImage = love.graphics.newImage('gold-medal.png')
        love.graphics.draw(self.medalImage, (VIRTUAL_WIDTH - self.medalImage:getWidth()) / 2, 140)

    end

    love.graphics.printf('Press Enter to Play Again!', 0, 216, VIRTUAL_WIDTH, 'center')
end


