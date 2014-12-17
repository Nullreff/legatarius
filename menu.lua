-- menu.lua - Main game menu
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

menu = {}
menu.assets = {
    background = 'menu_background.png',
    selected = 'menu_selected.png'
}

function start_game()
    set_mode(game)
end

menu.items = {
    {name = 'Start', func = start_game,    },
    {name = 'Exit',  func = love.event.quit}
}

function menu.mousepressed(x, y, button)
   if button == 'l' then
       for index, item in pairs(menu.items) do
           if item.selected then
               item.func()
               break
           end
       end
   end
end

function menu.update()
    local width, height = love.window.getDimensions()
    local x, y = love.mouse.getPosition()
    for index, item in pairs(menu.items) do
        item.box = {
            x = (width / 2) - (menu.assets.selected:getWidth() / 2),
            y = height / 2 + (50 * index),
            width = menu.assets.selected:getWidth(),
            height = menu.assets.selected:getHeight()
        }
        item.selected = box_contains(item.box, x, y)
    end
end

function menu.draw()
    local width, height = love.window.getDimensions()

    love.graphics.setColor(255,255,255)
    love.graphics.draw(menu.assets.background, 0, 0)
    love.graphics.setColor(0,0,0)
    love.graphics.setBackgroundColor(255,255,255)
    love.graphics.setNewFont(90)
    love.graphics.printf("Legatarius", 0, height / 2 - 100, width, 'center') 

    local menu_size = 50
    love.graphics.setNewFont(menu_size)
    for index, item in pairs(menu.items) do
        if item.selected then
            love.graphics.setColor(255,255,255)
            love.graphics.draw(menu.assets.selected, item.box.x, item.box.y)
            love.graphics.setColor(0,0,0)
        end
        love.graphics.printf(item.name, 0, item.box.y, width, 'center') 
    end
end
