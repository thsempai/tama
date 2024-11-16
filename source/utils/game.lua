local gfx <const> = playdate.graphics
local pd <const> = playdate


class("Game").extends()

function Game:init()
    self.scenes = {}
    self.activeSceneName = nil

    -- to clear
    self.inputs = {
        AButtonUp = function() self:setActiveScene("main") end,
        AButtonDown = function() self:setActiveScene("start") end,
    }
end

function Game:start()
    pd.inputHandlers.push(self.inputs)
end

function Game:update()
    gfx.sprite.update()
end

function Game:addScene(scene, makeItActive)
    self.scenes[scene.name] = scene
    scene.game = self

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
