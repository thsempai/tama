import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "Utils/game"
import "Game/hero"
import "Game/level"


local pd <const> = playdate


math.randomseed(playdate.getSecondsSinceEpoch())

local function initialize()
	game = Game()
	hero = Hero(200, 120)
	level = TopDownLevel("main", hero)
	game:addScene(level)

	-- game start
	game:start()
end

initialize()

function playdate.update()
	game:update()
	pd.timer.updateTimers()
end
