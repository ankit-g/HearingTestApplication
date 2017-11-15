--load all the sounds here and
local loader = require 'lib.love-loader'
local utl    = require 'lib.utility'

local finishedLoading = false
local channels_ready = false
local left_channel = {}
local right_channel = {}

local freq_table = {
	'1000Hz', '2000Hz', '3000Hz', '4000Hz', '5000Hz', '6000Hz',
	'7000Hz', '8000Hz', '9000Hz', '10000Hz', '11000Hz', '12000Hz',
	'13000Hz', '14000hz', '15000hz', '16000Hz', '17000Hz', '18000Hz',
	'19000Hz', '20000Hz', '21000Hz', '22000Hz'
	}

function load_from_loader()

	for i=1, #freq_table do
		loader.newSoundData( left_channel, freq_table[i], 'soundFiles/'..freq_table[i]..'.wav' )
		loader.newSoundData( right_channel, freq_table[i], 'soundFiles/'..freq_table[i]..'.wav' )
	end

  	loader.start(function() finishedLoading = true end)
end

function love.load()
	load_from_loader()
end

--[[
function table_walker()
	return coroutine.create( function(tbl)
			assert(type(tbl) == 'table')
			for key, val in pairs(tbl) do coroutine.yield({key, val}) end
		end )
end

twalker = table_walker()
while coroutine.status(twalker) ~= 'dead' do
	ok, sound_tbl = coroutine.resume(twalker, sounds)
	if sound_tbl then
		table.insert(left_channel, sound_tbl)
	end
end

for i=1, #left_channel do print(type(left_channel[i][1])) end
print(#left_channel)


]]

function set_channel(channel, Cno)
	assert(type(channel) == 'table')
	local amplitude = 0.2
	for _, sound_data in pairs(channel) do
		sample_count = sound_data:getSampleCount()
		for i=1, (sample_count-1) do
		       sound_data:setSample(2*i+Cno, amplitude)
	        end
	end
end

function play_sound()
	set_channel(left_channel, 1)
	set_channel(right_channel, 0)
	channels_ready = true
--[[
	local source = love.audio.newSource(left_channel['1000Hz'])
        love.audio.play(source)
]]
end

play_me = utl.exe_times(play_sound, 1)

function love.update(dt)
	-- You must do this on each iteration until all resources are loaded
	if not finishedLoading then
		loader.update()
	else
		play_me()
	end
end

function love.draw()
	if finishedLoading and channels_ready then
		love.graphics.circle('fill', 100, 100, 20, 100)
	else
    		local percent = 0
		if loader.resourceCount ~= 0 then
	    		percent = loader.loadedCount / loader.resourceCount
    		end
    		love.graphics.print(("Loading .. %d%%"):format(percent*100), 100, 100)
	end
end
