import "CoreLibs/sprites"


local gfx <const> = playdate.graphics
local pd <const> = playdate


class("Sprite").extends(gfx.sprite)

function Sprite:init(imagePath, x, y)
    if pcall(function() imagePath = "sprites/" .. imagePath end) then
        image = gfx.image.new(imagePath)
    else
        image = imagePath
    end
    self:moveTo(x or 0, y or 0)

    Sprite.super.init(self)
    self:setImage(image)
end

class("AnimatedSprite").extends(Sprite)

function AnimatedSprite:init(imagePath, x, y)
    if pcall(function() imagePath = "sprites/" .. imagePath end) then
        imagetable = gfx.imagetable.new(imagePath)
    else
        imagetable = imagePath
    end

    self.imagetable = imagetable

    image = self.imagetable:getImage(1, 1)
    AnimatedSprite.super.init(self, image, x, y)
end
