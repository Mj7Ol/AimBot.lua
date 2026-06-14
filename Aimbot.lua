local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Enabled = false
local ToggleKey = Enum.KeyCode.E

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Btn = Instance.new("TextButton", ScreenGui)
Btn.Size = UDim2.new(0, 100, 0, 50)
Btn.Position = UDim2.new(0, 10, 0, 10)
Btn.Text = "Aimbot: OFF"
Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Btn.TextColor3 = Color3.fromRGB(255, 255, 255)

Btn.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    Btn.Text = Enabled and "Aimbot: ON" or "Aimbot: OFF"
end)

-- Aimbot Logic
local function getClosest()
    local closest, dist = nil, math.huge
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("Head") then
            local pos, onScreen = Camera:WorldToViewportPoint(v.Character.Head.Position)
            if onScreen then
                local mag = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
                if mag < dist then
                    dist, closest = mag, v.Character.Head
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if Enabled then
        local target = getClosest()
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end
end)
