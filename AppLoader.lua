-- load frequency
-- load left and right channels 
-- play sound by frequency name <FreQuency Player Class>
-- check status of the playing sound <isPlaying, isStopped, getVolume, setVolume>
-- control the playing sound <make a class blue print>

local class 		= require 'middleclass.middleclass'
local loader  		= require 'lib.love-loader'
local FrequencyLoader 	= class('FrequencyLoader')

function set_channel(channel, Cno, amplitude)
	assert(type(channel) == 'table')

	for _, sound_data in pairs(channel) do
		sample_count = sound_data:getSampleCount()
		for i=1, (sample_count-1) do
		       sound_data:setSample(2*i+Cno, amplitude)
	        end
	end
end

function load_channels(self)
	set_channel(self.left_channel, 1, self.amplitude)
	set_channel(self.right_channel, 0, self.amplitude)
	self.finishedLoading = true
	--love.audio.play(love.audio.newSource(self.right_channel['1000Hz']))
end

function FrequencyLoader:initialize(freq_table, amplitude)
	self.left_channel 	= {}
	self.right_channel 	= {}
	self.amplitude		= amplitude
	self.freq_table		= freq_table
	self.finishedLoading 	= false
	self.sound_loaded 	= false
end

-- this method should load the frequencys from sounds directory
function FrequencyLoader:load_sound()

	for i=1, #self.freq_table do
		loader.newSoundData( self.left_channel, self.freq_table[i],
					'soundFiles/'..self.freq_table[i]..'.wav' )
		loader.newSoundData( self.right_channel, self.freq_table[i],
					'soundFiles/'..self.freq_table[i]..'.wav' )
	end

  	loader.start(function() load_channels(self)  end)
end

--get left channel
function FrequencyLoader:get_left_ch()
	return self.left_channel
end

--get right channel
function FrequencyLoader:get_right_ch()
	return self.right_channel
end

function FrequencyLoader:has_finished_loading()
	return self.finishedLoading
end

--update loader
function FrequencyLoader:update(dt)
	if self.finishedLoading == true then return end
	loader.update()
end

function FrequencyLoader:draw()

	if self.finishedLoading == true then --[[love.graphics.print("FINISHED LOADING ", 200, 200)]] return end
	local percent = 0
	if loader.resourceCount ~= 0 then
		percent = loader.loadedCount / loader.resourceCount
	end
	love.graphics.print(("Loading .. %d%%"):format(percent*100), 100, 100)	
end

return FrequencyLoader
