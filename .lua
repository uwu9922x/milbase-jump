local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- CONFIG (قوة القفزة على المنحدر)
local SLOPE_BOOST = 130

local function setupCharacter(character)
    local humanoid = character:WaitForChild("Humanoid")
    local root = character:WaitForChild("HumanoidRootPart")

    -- دالة للتحقق مما إذا كان اللاعب على منحدر
    local function isInclined()
        return root.CFrame.UpVector.Y < 0.7
    end

    humanoid.Jumping:Connect(function()
        -- يتحقق إذا كان اللاعب على منحدر ويقوم بالتحرك (عبر الجويستيك أو الأزرار)
        if isInclined() then
            local moveDir = humanoid.MoveDirection
            
            -- إذا كان اللاعب يحرك عصا التحكم (أي يتحرك)
            if moveDir.Magnitude > 0 then
                -- تصفير السرعة ودفع اللاعب للأعلى
                root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                root.AssemblyLinearVelocity = Vector3.new(0, SLOPE_BOOST, 0)
            end
        end
    end)
end

-- عند بداية التشغيل وعند إعادة التوليد (Respawn)
if player.Character then
    setupCharacter(player.Character)
end

player.CharacterAdded:Connect(setupCharacter)
