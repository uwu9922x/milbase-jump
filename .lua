local Players = game:GetService("Players")

local player = Players.LocalPlayer

-- CONFIG
local SLOPE_BOOST = 130

local holdingS = false
local holdingAorD = false

-- INPUT TRACK
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.S then
        holdingS = true
    end
    
    if input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.D then
        holdingAorD = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.S then
        holdingS = false
    end
    
    if input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.D then
        holdingAorD = false
    end
end)

-- SISTEMA DE INCLINAÇÃO
local function setupCharacter(character)

    local humanoid = character:WaitForChild("Humanoid")
    local root = character:WaitForChild("HumanoidRootPart")

    local function isInclined()
        return root.CFrame.UpVector.Y < 0.7
    end

    humanoid.Jumping:Connect(function()
        if isInclined() and holdingS and holdingAorD then
            root.AssemblyLinearVelocity = Vector3.new(0,0,0)
            root.AssemblyLinearVelocity += Vector3.new(0, SLOPE_BOOST, 0)
        end
    end)
end

-- RESPAWN SAFE
if player.Character then
    setupCharacter(player.Character)
end

player.CharacterAdded:Connect(setupCharacter)
