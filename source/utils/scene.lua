local gfx <const> = playdate.graphics
local pd <const> = playdate


class("Scene").extends()

function Scene:init(name, bgColor)
    self.name = name
    self.bgColor = bgColor or gfx.kColorWhite
    self.sprites = {}
    self.isActive = false
    self.game = nil
    self.inputs = nil
end

function Scene:active()
    -- setup bg color
    pd.graphics.setBackgroundColor(self.bgColor)
    gfx.clear()

    for i, sprite in ipairs(self.sprites) do
        sprite:add()
    end
    self.isActive = true
end

function Scene:unactive()
    for i, sprite in ipairs(self.sprites) do
        sprite:remove()
    end
    self.isActive = false
end

function Scene:update()
    -- nothing yet
end

function Scene:addSprite(sprite)
    table.insert(self.sprites, sprite)
    if self.isActive then
        sprite:add()
    end
end