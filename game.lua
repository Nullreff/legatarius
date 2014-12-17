-- game.lua - Gameplay and dialog engine
--
-- Copyright (c) 2014, Ryan Mendivil
-- All rights reserved.
-- 
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:
--     * Redistributions of source code must retain the above copyright
--       notice, this list of conditions and the following disclaimer.
--     * Redistributions in binary form must reproduce the above copyright
--       notice, this list of conditions and the following disclaimer in the
--       documentation and/or other materials provided with the distribution.
--     * Neither the name of the Legatarius nor the
--       names of its contributors may be used to endorse or promote products
--       derived from this software without specific prior written permission.
-- 
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
-- ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
-- WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
-- DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
-- DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
-- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
-- LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
-- ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--

game = {}

game.assets = {
    background = 'chapter1/woods.png'
}

game.intro = {
    animation = 0
}

game.dialog = {
}

function fade_in(start, stop, current, func)
    local percent
    if current <= start then
        percent = 0
    elseif current >= stop then
        percent = 1
    else
        percent = (current - start) / (stop - start)
    end
    func(percent)
end

function game.intro.update(dt)
    game.intro.animation = game.intro.animation + dt
    if game.intro.animation >= 13 then
        set_mode(game.dialog)
    end
end

function game.intro.draw()
    local width, height = love.window.getDimensions()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setNewFont(50)
    fade_in(2, 4, game.intro.animation, function(percent)
        love.graphics.setColor(255, 255, 255, 255 * percent)
    end)
    love.graphics.printf('Chapter 1:', 0, height / 2 - 100, width, 'center') 
    love.graphics.setNewFont(90)
    fade_in(5, 7, game.intro.animation, function(percent)
        love.graphics.setColor(255, 255, 255, 255 * percent)
    end)
    love.graphics.printf('Jamie', 0, height / 2 - 40, width, 'center') 
    fade_in(9, 10.5, game.intro.animation, function(percent)
        love.graphics.setColor(0, 0, 0, 255 * percent)
    end)
    love.graphics.rectangle('fill', 0, 0, width, height)
    fade_in(11, 13, game.intro.animation, function(percent)
        love.graphics.setColor(255, 255, 255, 255 * percent)
    end)
    love.graphics.draw(game.assets.background, 0, 0)
end

function game.dialog.update(dt)
end

function game.dialog.draw()
    local width, height = love.window.getDimensions()
    local text_height = 200
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(game.assets.background, 0, 0)
    love.graphics.setColor(0, 0, 0, 100)
    --love.graphics.rectangle('fill', 0, height - text_height, width, text_height)
end

game.draw = game.intro.draw
game.update = game.intro.update

