import "Utils/sprite"

class("Hero").extends(AnimatedSprite)

function Hero:init(x, y)
    animations = {
        {
            name = "idle",
            startFrame = 1,
            endFrame = 1,
            fps = 0,
            isLooping = true
        },
        {
            name = "walk",
            startFrame = 2,
            endFrame = 3,
            fps = 6,
            isLooping = true
        },
    }

    Hero.super.init(self, "hero", x, y, animations)
end
