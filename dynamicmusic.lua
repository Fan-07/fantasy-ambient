local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")

local player    = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid  = character:WaitForChild("Humanoid")

-- you can add your own tracks 
local TRACKS = {
  explore = 1837849328,  -- calm music
  combat  = 1231412331,  -- nothing
  night   = 1837849330,  -- eerie night ambience
}

local VOLUME    = 0.5
local FADE_TIME = 1.5

local currentState = ""
local sound = Instance.new("Sound")
sound.Parent = game.SoundService
sound.Looped = true
sound.Volume = 0

local function fade(target, duration)
  local steps    = 20
  local interval = duration / steps
  local delta    = (target - sound.Volume) / steps
  for _ = 1, steps do
    sound.Volume = sound.Volume + delta
    task.wait(interval)
  end
  sound.Volume = target
end

local function switchTo(state)
  if state == currentState then return end
  currentState = state
  task.spawn(function()
    fade(0, FADE_TIME)
    sound.SoundId = "rbxassetid://" .. TRACKS[state]
    sound:Play()
    fade(VOLUME, FADE_TIME)
  end)
end

-- Detect state every 2 seconds
local CHECK_INTERVAL = 2
local timer = 0

RunService.Heartbeat:Connect(function(dt)
  timer += dt
  if timer < CHECK_INTERVAL then return end
  timer = 0

  character = player.Character
  if not character then return end
  humanoid = character:FindFirstChild("Humanoid")
  if not humanoid then return end

  -- Check for nearby enemies tagged "Enemy"
  local inCombat = false
  local root = character:FindFirstChild("HumanoidRootPart")
  if root then
    for _, obj in ipairs(game.Workspace:GetDescendants()) do
      if obj:IsA("Model") and obj:FindFirstChild("EnemyTag") then
        local enemyRoot = obj:FindFirstChild("HumanoidRootPart")
        if enemyRoot then
          local dist = (root.Position - enemyRoot.Position).Magnitude
          if dist < 40 then
            inCombat = true
            break
          end
        end
      end
    end
  end

  local hour = game.Lighting.ClockTime
  local isNight = hour < 6 or hour > 20

  if inCombat then
    switchTo("combat")
  elseif isNight then
    switchTo("night")
  else
    switchTo("explore")
  end
end)
