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