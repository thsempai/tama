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

    -- link between scene and game
    self.scene = nil
    self.game = nil
end

-- redefinition to avoid to add sprite without scene
function Sprite:add()
    if self.scene == nil then
        error("A sprite need to be added to a scene before using \"Add\" method.", 2)
    end

    Sprite.super.add(self)
end

class("AnimatedSprite").extends(Sprite)

function AnimatedSprite:init(imagePath, x, y, animations)
    if pcall(function() imagePath = "sprites/" .. imagePath end) then
        imagetable = gfx.imagetable.new(imagePath)
    else
        imagetable = imagePath
    end

    self.imagetable = imagetable

    self.animations = {}

    -- add each animations by the dedicated fonctions
    for _, animation in ipairs(self.animations) do
        self:addAnimation(animation)
    end

    image = self.imagetable:getImage(1, 1)
    AnimatedSprite.super.init(self, image, x, y)
end

function AnimatedSprite:addAnimation(animation)
    startFrame = animation.startFrame or 0
    endFrame = animation.endFrame or self.imagetable:getLength()
end
