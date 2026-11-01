
-- ULTIMATE TOWER DEFENSE
-- Mobile All-in-One GUI
-- Roblox Studio LocalScript

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "TowerDefenseMobile"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(280, 380)
frame.Position = UDim2.new(0.5, -140, 0.5, -190)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius =
    UDim.new(0, 14)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 45)
title.Position = UDim2.fromOffset(5, 0)
title.BackgroundTransparency = 1
title.Text = "TOWER DEFENSE HUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 17
title.Font = Enum.Font.GothamBold
title.Parent = frame

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(40, 40)
minimize.Position = UDim2.new(1, -45, 0, 3)
minimize.Text = "-"
minimize.TextSize = 24
minimize.Parent = frame

local features = {
    "Auto Farm",
    "Auto Place",
    "Auto Upgrade",
    "Auto Skip",
    "Auto Sell"
}

local enabled = {}
local buttons = {}

for i, name in ipairs(features) do
    enabled[name] = false

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.88, 0, 0, 43)
    button.Position = UDim2.new(
        0.06, 0, 0, 55 + (i - 1) * 52
    )

    button.BackgroundColor3 =
        Color3.fromRGB(60, 60, 80)

    button.Text = name .. ": OFF"
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 15
    button.Font = Enum.Font.GothamBold
    button.Parent = frame

    Instance.new("UICorner", button).CornerRadius =
        UDim.new(0, 9)

    buttons[name] = button

    button.Activated:Connect(function()
        enabled[name] = not enabled[name]

        button.Text = name ..
            (enabled[name] and ": ON" or ": OFF")

        button.BackgroundColor3 = enabled[name]
            and Color3.fromRGB(30, 145, 90)
            or Color3.fromRGB(60, 60, 80)
    end)
end

local stop = Instance.new("TextButton")
stop.Size = UDim2.new(0.88, 0, 0, 43)
stop.Position = UDim2.new(0.06, 0, 1, -50)
stop.BackgroundColor3 = Color3.fromRGB(190, 45, 45)
stop.Text = "STOP ALL"
stop.TextColor3 = Color3.new(1, 1, 1)
stop.TextSize = 16
stop.Font = Enum.Font.GothamBold
stop.Parent = frame

Instance.new("UICorner", stop).CornerRadius =
    UDim.new(0, 9)

stop.Activated:Connect(function()
    for _, name in ipairs(features) do
        enabled[name] = false

        buttons[name].Text = name .. ": OFF"
        buttons[name].BackgroundColor3 =
            Color3.fromRGB(60, 60, 80)
    end
end)

local minimized = false

minimize.Activated:Connect(function()
    minimized = not minimized

    for _, name in ipairs(features) do
        buttons[name].Visible = not minimized
    end

    stop.Visible = not minimized

    frame.Size = minimized
        and UDim2.fromOffset(280, 45)
        or UDim2.fromOffset(280, 380)

    minimize.Text = minimized and "+" or "-"
end)

-- Feature states for your game's systems:
_G.TowerDefenseFeatures = enabled

print("Tower Defense Mobile GUI loaded!")
