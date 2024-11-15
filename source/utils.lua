import "CoreLibs/sprites"
import "CoreLibs/string"

import "AnimatedSprite"


local gfx <const> = playdate.graphics
local pd <const> = playdate



--local tileset = gfx.imagetable.new("sprites/tileset")
class("Game").extends()

function Game:init()
    self.scenes = {}
    self.activeSceneName = nil
end

function Game:update()
    gfx.sprite.update()
end

function Game:addScene(scene, makeItActive)
    self.scenes[scene.name] = scene

    if makeItActive == true or self.activeSceneName == nil then
        self:setActiveScene(scene.name)
    end
end

function Game:getActiveScene()
    if self.activeSceneName == nil then
        return nil
    end
    return self.scenes[self.activeSceneName]
end

function Game:setActiveScene(sceneName)
    if self.activeSceneName ~= nill then
        self:getActiveScene():unactive()
    end
    self.activeSceneName = sceneName
    self:getActiveScene():active()
end

function Game:addSprite(sprite, scene)
    if scene == nil then
        scene = self:getActiveScene()
    end
    scene:addSprite(sprite)
end

class("Scene").extends()

function Scene:init(name, bgColor)
    self.name = name
    self.bgColor = bgColor or gfx.kColorWhite
    self.sprites = {}
    self.isActive = false
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
