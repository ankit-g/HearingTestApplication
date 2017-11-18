require "gooi"
local class   = require 'middleclass.middleclass'
local LoveApp = require 'LoveApp'
local LoadApp = require 'AppLoader' 

local current_source_right
local current_source_left

local freq_table = {
	'1000Hz',  '2000Hz',  '3000Hz',  '4000Hz',  '5000Hz',  '6000Hz',
	'7000Hz',  '8000Hz',  '9000Hz',  '10000Hz', '11000Hz', '12000Hz',
	'13000Hz', '14000Hz', '15000Hz', '16000Hz', '17000Hz', '18000Hz',
	'19000Hz', '20000Hz', '21000Hz', '22000Hz'
	}

function load_gui_components(self)
	local play_btn_right = gooi.newButton({ text = "Test Right Ear", x = 690, y = 10, w = 100, h = 35 })
	play_btn_left = gooi.newButton({ text = "Test Left Ear", x = 10, y = 10, w = 100, h = 35 })

	play_btn_left:onRelease(function()
				if current_source_left and current_source_left:isPlaying() == true then return end
					current_source_left = love.audio.newSource(
						self.left_channel[freq_table[self.current_frequency_left]])
				--print(string.format("duration %d seconds", current_source_right:getDuration('seconds')))
				love.audio.play(current_source_left)
				self.now_playing_left = self.current_frequency_left
				if self.current_frequency_left == #freq_table then
					self.current_frequency_left = 1 
				else
					self.current_frequency_left = self.current_frequency_left + 1
				end
			   end)


	play_btn_right:onRelease(function()
				if current_source_right and current_source_right:isPlaying() == true then return end
					current_source_right = love.audio.newSource(
						self.right_channel[freq_table[self.current_frequency_right]])
				--print(string.format("duration %d seconds", current_source_right:getDuration('seconds')))
				love.audio.play(current_source_right)
				self.now_playing_right = self.current_frequency_right
				if self.current_frequency_right == #freq_table then
					self.current_frequency_right = 1 
				else
					self.current_frequency_right = self.current_frequency_right + 1
				end
			   end)
end

local AudioGram = LoveApp:subclass('AudioGram')

function AudioGram:initialize()
	LoveApp:initialize()
	self.freq_loader = LoadApp:new(freq_table, 0.2)
	self.channels_loaded = false
	self.left_channel = {}
	self.right_channel = {}
	self.current_frequency_right = 1
	self.current_frequency_left= 1
	self.now_playing_left = false 
	self.now_playing_right = false 
end

function AudioGram:load()
	load_gui_components(self)
	self.freq_loader:load_sound()
end

function AudioGram:update(dt)
	-- You must do this on each iteration until all resources are loaded
	gooi.update(dt)
	self.freq_loader:update(dt)
	if self.freq_loader:has_finished_loading() == true and
			self.channels_loaded == false then
		self.left_channel = self.freq_loader:get_left_ch()
		self.right_channel = self.freq_loader:get_right_ch()
		self.channels_loaded = true
	end	
end

function AudioGram:draw()
	self.freq_loader:draw()	
	gooi.draw()
	if self.now_playing_left then
	love.graphics.print('now playing '..freq_table[self.now_playing_left]..' left', 20, 180)
	end
	love.graphics.print('next sound '..freq_table[self.current_frequency_left]..' left', 20, 200)

	if self.now_playing_right then
	love.graphics.print('now playing '..freq_table[self.now_playing_right]..' right', 640, 180)
	end
	love.graphics.print('next sound '..freq_table[self.current_frequency_right]..' right', 640, 200)
end


function love.mousereleased(x, y, button) gooi.released() end
function love.mousepressed(x, y, button)  gooi.pressed() end
function love.textinput(text) gooi.textinput(text) end
function love.keyreleased(key, scancode) gooi.keyreleased(key, scancode) end

function love.keypressed(key, scancode, isrepeat)
    gooi.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end
end

return AudioGram
