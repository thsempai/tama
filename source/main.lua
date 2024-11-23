import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "Utils/game"
import "Utils/scene"
import "Utils/sprite"


local gfx <const> = playdate.graphics
local pd <const> = playdate


math.randomseed(playdate.getSecondsSinceEpoch())

local function initialize()
	game = Game()
	scene = Scene("main")
	game:addScene(scene)



	sprite = AnimatedSprite("tamagochi", 200, 120, { { name = "main", startFrame = 1, endFrame = 2, fps = 2 } })
	sprite:addAnimation("eat", 3, 4, 2)
	sprite:setCurrentAnimation("eat")
	scene:addSprite(sprite)
	sprite:play()

	-- game start
	game:start()
end

initialize()

function playdate.update()
	game:update()
	pd.timer.updateTimers()
end
