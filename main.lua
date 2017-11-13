--load all the sounds here and
local loader = require 'lib.love-loader'
local utl    = require 'lib.utility'

local finishedLoading = false
local sounds = {}

function load_from_loader()
	loader.newSoundData( sounds, '1000hz', 'soundFiles/1000Hz.wav' )
	loader.newSoundData( sounds, '2000hz', 'soundFiles/2000Hz.wav' )
	loader.newSoundData( sounds, '3000hz', 'soundFiles/3000Hz.wav' )
	loader.newSoundData( sounds, '4000hz', 'soundFiles/4000Hz.wav' )
	loader.newSoundData( sounds, '5000hz', 'soundFiles/5000Hz.wav' )
	loader.newSoundData( sounds, '6000hz', 'soundFiles/6000Hz.wav' )
	loader.newSoundData( sounds, '7000hz', 'soundFiles/7000Hz.wav' )
	loader.newSoundData( sounds, '8000hz', 'soundFiles/8000Hz.wav' )
	loader.newSoundData( sounds, '9000hz', 'soundFiles/9000Hz.wav' )
	loader.newSoundData( sounds, '10000hz', 'soundFiles/10000Hz.wav' )
	loader.newSoundData( sounds, '11000hz', 'soundFiles/11000Hz.wav' )
	loader.newSoundData( sounds, '12000hz', 'soundFiles/12000Hz.wav' )
	loader.newSoundData( sounds, '13000hz', 'soundFiles/13000Hz.wav' )
	loader.newSoundData( sounds, '14000hz', 'soundFiles/14000Hz.wav' )
	loader.newSoundData( sounds, '15000hz', 'soundFiles/15000Hz.wav' )
	loader.newSoundData( sounds, '16000hz', 'soundFiles/16000Hz.wav' )
	loader.newSoundData( sounds, '17000hz', 'soundFiles/17000Hz.wav' )
	loader.newSoundData( sounds, '18000hz', 'soundFiles/18000Hz.wav' )
	loader.newSoundData( sounds, '19000hz', 'soundFiles/19000Hz.wav' )
	loader.newSoundData( sounds, '20000hz', 'soundFiles/20000Hz.wav' )
	loader.newSoundData( sounds, '21000hz', 'soundFiles/21000Hz.wav' )
	loader.newSoundData( sounds, '22000hz', 'soundFiles/22000Hz.wav' )

  	loader.start(function() finishedLoading = true end)
end

function love.load()
	load_from_loader()
end

function play_sound()
	local Music = sounds['1000hz'] 
	local sampleCount = Music:getSampleCount()
 	local amplitude = 0.2

    	for i=1, (sampleCount-1) do
        	Music:setSample(2*i+1, amplitude)
    	end

 	local source = love.audio.newSource(Music)
    	love.audio.play(source)
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
	if finishedLoading then
		love.graphics.circle('fill', 100, 100, 20, 100)
	else
    		local percent = 0
		if loader.resourceCount ~= 0 then
	    		percent = loader.loadedCount / loader.resourceCount
    		end
    		love.graphics.print(("Loading .. %d%%"):format(percent*100), 100, 100)
	end
end
