local gfx <const> = playdate.graphics
local pd <const> = playdate


class("Scene").extends()

function Scene:init(name, bgColor)
    self.name = name
    self.bgColor = bgColor or gfx.kColorWhite
    self.sprites = {}
    self.isActive = false
    self.game = nil

    -- to put at nil
    self.inputs = nil
end

function Scene:active()
    -- setup bg color
    pd.graphics.setBackgroundColor(self.bgColor)
    gfx.clear()

    for _, sprite in ipairs(self.sprites) do
        sprite:add()
    end

    if self.inputs then
        pd.inputHandlers.push(self.inputs, false)
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

    sprite.scene = self
    sprite.game = game
    if self.isActive then
        sprite:add()
    end
end

function Scene:setGame(game)
    self.game = game
    for _, sprite in ipairs(self.sprites) do
        sprite.game = game
    end
end
