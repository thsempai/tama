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

	sprite = Sprite("cross")
	sprite:moveTo(200, 120)

	game:addSprite(sprite)

	scene = Scene("start")
	game:addScene(scene)

	sprite = Sprite("fg")
	sprite:moveTo(0, 0)
	scene:addSprite(sprite)


	-- game start
	game:start()
end

initialize()

function playdate.update()
	game:update()

	pd.timer.updateTimers()
end
