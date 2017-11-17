local class = require 'middleclass.middleclass'

-- Abstract class for all loveFrameWork apps
local LoveApp = class('LoveApp')

function LoveApp:initialize()
end

-- All love2d apps must load their stuff here
-- Can only be over ridden
function LoveApp:load()
	print('load must be overridden')
	assert(false)
end

-- All love apps draw
-- Can only be over ridden
function LoveApp:draw()
	print('draw must be overridden')
	assert(false)
end

-- All love apps must update 
-- Can only be over ridden
function LoveApp:update(dt)
	print('update must be overridden')
	assert(false)
end
--MusicPlayer is a subclass of LoveApp
return LoveApp
