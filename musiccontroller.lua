local SoundService = game:GetService("SoundService")

-- Replace with IDs of actual audio that you want
local PLAYLIST = {
  1837849328,  -- track 1
  1837849329,  -- track 2
  1837849330,  -- track 3
}

local VOLUME       = 0.4
local FADE_TIME    = 2   --  fade in/out (in seconds)

local music = Instance.new("Sound")
music.Parent     = game.SoundService
music.Volume     = 0
music.RollOffMaxDistance = 0

local function fade(sound, targetVol, duration)
  local steps    = 20
  local interval = duration / steps
  local delta    = (targetVol - sound.Volume) / steps
  for _ = 1, steps do
    sound.Volume = sound.Volume + delta
    task.wait(interval)
  end
  sound.Volume = targetVol
end

local currentIndex = 0

local function playNext()
  currentIndex = (currentIndex % #PLAYLIST) + 1
  music.SoundId = "rbxassetid://" .. PLAYLIST[currentIndex]
  music:Play()
  fade(music, VOLUME, FADE_TIME)
  music.Ended:Wait()
  fade(music, 0, FADE_TIME)
end

task.spawn(function()
  while true do
    playNext()
  end
