-- Replace IDs with your own audio assets
local SOUNDS = {
  { id = 180375959,  volume = 0.3, name = "Wind"    },
  { id = 165970693,  volume = 0.2, name = "Birds"   },
  { id = 1369158709, volume = 0.15, name = "Crickets" },
}

--you can add multiple ambient sounds too

for _, data in ipairs(SOUNDS) do
  local s        = Instance.new("Sound")
  s.SoundId      = "rbxassetid://" .. data.id
  s.Volume       = data.volume
  s.Looped       = true
  s.RollOffMaxDistance = 0
  s.Parent       = game.SoundService
  s:Play()
end
