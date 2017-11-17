local LoveApp = require 'AudioGram'

local app = LoveApp:new()

function love.load()
	app:load()
end

function love.update(dt)
	app:update(dt)
end

function love.draw()
	app:draw()
end
