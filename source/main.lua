import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "utils"


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
end

initialize()

function playdate.update()
	game:update()

	pd.timer.updateTimers()
end
