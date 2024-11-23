import "CoreLibs/sprites"

local ANIMATION_FPS_DEFAULT <const> = 12

local gfx <const> = playdate.graphics
local pd <const> = playdate

-- to setup empty functio as default callback (cfr. AnimatedSprite)
local function emptyFunc() end

class("Sprite").extends(gfx.sprite)

function Sprite:init(imagePath, x, y)
    if pcall(function() imagePath = "sprites/" .. imagePath end) then
        image = gfx.image.new(imagePath)
    else
        image = imagePath
    end

    Sprite.super.init(self)
    self:setImage(image)

    -- link between scene and game
    self.scene = nil
    self.game = nil

    -- initiale position
    self:moveTo(x or 0, y or 0)
end

-- redefinition to avoid to add sprite without scene
function Sprite:add()
    if self.scene == nil then
        error("A sprite need to be added to a scene before using \"Add\" method.", 2)
    end

    Sprite.super.add(self)
end

class("AnimatedSprite").extends(Sprite)

-- helper to addAnimation
local function addAnimation(self, animation)
    if animation.name == nil then
        error("Unnamed animation.", 2)
    end
    animation.startFrame = animation.startFrame or 0
    animation.endFrame = animation.endFrame or #self.imagetable
    animation.frameCount = animation.endFrame - animation.startFrame + 1
    animation.fps = animation.fps or ANIMATION_FPS_DEFAULT
    animation.isLooping = animation.isLooping or false
    animation.whenIsStart = emptyFunc
    animation.whenIsFinish = emptyFunc
    animation.whenLoopIsFinish = emptyFunc

    self.animations[animation.name] = animation
    if self.defaultAnimation == nil then
        self:setDefaultAnimation(animation.name)
    end

    return animation
    -- allow to set an animation to defaul by adding it.
end

function AnimatedSprite:init(imagePath, x, y, animations, start)
    if pcall(function() imagePath = "sprites/" .. imagePath end) then
        imagetable = gfx.imagetable.new(imagePath)
    else
        imagetable = imagePath
    end

    self.imagetable = imagetable

    self.animations = animations or { { name = defaut } }

    -- add each animations by the dedicated fonctions
    for _, animation in ipairs(self.animations) do
        addAnimation(self, animation)
    end

    self.currentAnimation = self.defaultAnimation

    image = self:getImage(self.currentAnimation, 1)
    AnimatedSprite.super.init(self, image, x, y)

    self.isPlaying = start
    self.currentFrame = 1
    self.currentTime = 0.0

    if self.isPlaying then
        self:play()
    end
end

function AnimatedSprite:addAnimation(name, startFrame, endFrame, fps, isLooping)
    animation = {}
    animation["name"] = name
    animation["startFrame"] = startFrame
    animation["endFrame"] = endFrame
    animation["fps"] = fps
    animation["isLooping"] = isLooping

    return addAnimation(self, animation)
end

function AnimatedSprite:getAnimation(name)
    return self.animations[name]
end

function AnimatedSprite:getCurrentAnimation()
    return self.animations[self.currentAnimation]
end

function AnimatedSprite:setCurrentAnimation(name)
    if self.animations[name] == nil then
        error("No animation \"" .. name .. "\" found.", 2)
    end
    self.currentAnimation = name
    if self.isPlaying then
        self:play()
    end
end

function AnimatedSprite:getDefaultAnimation()
    return self.animations[self.defaultAnimation]
end

function AnimatedSprite:setDefaultAnimation(name)
    if self.animations[name] == nil then
        error("No animation \"" .. name .. "\" found.", 2)
    end
    self.defaultAnimation = name
end

function AnimatedSprite:getImage(name, nFrame)
    width, height = self.imagetable:getSize()

    -- I put -2 to make sure that nFrame 0 is the first frame (-1 for startFrame and -1 for nFrame)
    nFrame = self:getAnimation(name).startFrame + nFrame - 2
    x = nFrame % width + 1
    y = nFrame // width + 1

    return self.imagetable:getImage(x, y)
end

function AnimatedSprite:play()
    self.currentTime = 0.0
    self:setImage(self:getImage(self.currentAnimation, 1))
    self.isPlaying = true
    self.currentFrame = 1
    self:getCurrentAnimation().whenIsStart()
end

function AnimatedSprite:pause()
    self.isPlaying = false
end

function AnimatedSprite:unPause()
    self.isPlaying = true
end

function AnimatedSprite:updateAnimation()
    self.currentTime += self.game.deltaTime

    memoCurrentAnimation = self.currentAnimation

    if self.currentTime >= (1 / self:getCurrentAnimation().fps) then
        self.currentTime = 0.0
        self.currentFrame += 1

        if self.currentFrame > self:getCurrentAnimation().frameCount then
            if self:getCurrentAnimation().isLooping then
                self:getCurrentAnimation().whenLoopIsFinish()
            else
                self:getCurrentAnimation().whenIsFinish()
                self.currentAnimation = self.defaultAnimation
            end
            self.currentFrame = 1
        end
        if memoCurrentAnimation ~= memoCurrentAnimation then
            self:getCurrentAnimation().whenIsStart()
        end
        image = self:getImage(self.currentAnimation, self.currentFrame)
        self:setImage(image)
    end
end

function AnimatedSprite:update()
    self:updateAnimation()
    AnimatedSprite.super.update(self)
end
