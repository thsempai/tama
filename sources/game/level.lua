import "Utils/scene"

local playerSpeed <const> = 10

local gfx <const> = playdate.graphics
local pd <const> = playdate


class("TopDownLevel").extends(Scene)

function TopDownLevel:init(name, player, bgColor)
    TopDownLevel.super.init(self, name, bgColor)

    self.player = player
    self:addSprite(player)

    self.rightButtonIsPressed = false
    self.leftButtonIsPressed = false
    self.upButtonIsPressed = false
    self.downButtonIsPressed = false

    self.inputs = {
        rightButtonDown = function()
            self.rightButtonIsPressed = true
        end,
        rightButtonUp = function()
            self.rightButtonIsPressed = false
        end,
        leftButtonDown = function()
            self.leftButtonIsPressed = true
        end,
        leftButtonUp = function()
            self.leftButtonIsPressed = false
        end,
        upButtonDown = function()
            self.upButtonIsPressed = true
        end,
        upButtonUp = function()
            self.upButtonIsPressed = false
        end,
        downButtonDown = function()
            self.downButtonIsPressed = true
        end,
        downButtonUp = function()
            self.downButtonIsPressed = false
        end,
    }
end

function TopDownLevel:update()
    TopDownLevel.super.init(self)

    if self.rightButtonIsPressed then
        self.player:moveBy(playerSpeed, 0)
    elseif self.leftButtonIsPressed then
        self.player:moveBy(-playerSpeed, 0)
    end

    if self.upButtonIsPressed then
        self.player:moveBy(0, -playerSpeed)
    elseif self.downButtonIsPressed then
        self.player:moveBy(0, playerSpeed)
    end
end
