import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "Utils/game"
import "Utils/scene"
import "Game/hero"


local gfx <const> = playdate.graphics
local pd <const> = playdate


math.randomseed(playdate.getSecondsSinceEpoch())

local function initialize()
	game = Game()
	scene = Scene("main")
	game:addScene(scene)

	hero = Hero(200, 120)
	scene:addSprite(hero)
	hero:play()

	-- game start
	game:start()
end

initialize()

function playdate.update()
	game:update()
	pd.timer.updateTimers()
end
