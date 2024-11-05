import "CoreLibs/sprites"
import "CoreLibs/string"

import "AnimatedSprite"


local gfx <const> = playdate.graphics
local pd <const> = playdate



--local tileset = gfx.imagetable.new("sprites/tileset")


class("Game").extends()

function Game:init()
    self.fg = SpriteWithAnimation("tamagochi")
    pd.display.setScale(2)
    self.fg:add()
    self.fg:addState("pose", 1, 2, { tickStep = 6 }).asDefault()
    self.fg:changeState("pose", true)
    self.fg:moveTo(pd.display.getWidth() / 2, pd.display.getHeight() / 2)

    self.fg:playAnimation()
end

function Game:update()
    -- nothing
end

class("Sprite").extends(gfx.sprite)

function Sprite:init(imagePath)
    if pcall(function() imagePath = "sprites/" .. imagePath end) then
        image = gfx.image.new(imagePath)
    else
        image = imagePath
    end

    Sprite.super.init(self)
    self:setImage(image)
end

class("SpriteWithAnimation").extends(AnimatedSprite)

function SpriteWithAnimation:init(imageName)
    imagePath = "sprites/" .. imageName
    imagetable = gfx.imagetable.new(imagePath)
    SpriteWithAnimation.super.init(self, imagetable)
end
