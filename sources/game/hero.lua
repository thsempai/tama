import "Utils/sprite"

local direction <const> = { right = 1, left = 2, up = 3, down = 4 }

class("Hero").extends(AnimatedSprite)

function Hero:init(x, y)
    animations = {
        {
            name = "idle-front",
            startFrame = 1,
            endFrame = 1,
            fps = 0,
            isLooping = true
        },
        {
            name = "walk-front",
            startFrame = 2,
            endFrame = 3,
            fps = 6,
            isLooping = true
        },
        {
            name = "idle-back",
            startFrame = 4,
            endFrame = 4,
            fps = 0,
            isLooping = true
        },
        {
            name = "walk-back",
            startFrame = 5,
            endFrame = 6,
            fps = 6,
            isLooping = true
        },
        {
            name = "idle-right",
            startFrame = 7,
            endFrame = 7,
            fps = 6,
            isLooping = true
        },
        {
            name = "walk-right",
            startFrame = 8,
            endFrame = 9,
            fps = 6,
            isLooping = true
        },
    }

    Hero.super.init(self, "hero", x, y, animations)

    self.direction = direction.down
    self.isWalking = false
end

function Hero:update()
    Hero.super.update(self)

    if self.direction == direction.right then
        if self.isWalking then
            self:setCurrentAnimation('walk-right')
        else
            self:setCurrentAnimation('idle-right')
        end
    end
    self.isWalking = false
end

function Hero:moveBy(x, y, animated)
    Hero.super.moveBy(self, x, y)

    animated = animated or true
    if animated then
        self.isWalking = x or y

        if x > 0 then
            self.direction = direction.right
        elseif x < 0 then
            self.direction = direction.left
        elseif y > 0 then
            self.direction = direction.down
        elseif y < 0 then
            self.direction = direction.up
        end
    end
end
