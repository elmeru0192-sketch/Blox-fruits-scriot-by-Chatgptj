-- CART3R.JAILBREAK | CRIMSON HACKER
-- Roblox Studio LocalScript for an experience you own or are authorized to modify.
-- This is a GUI/demo utility, not a Delta exploit.
-- Scanners depend on matching object names in your own game's Workspace.
-- Teleport entries are examples. Auto Farm is intentionally disabled.

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local Config = {
    Accent = Color3.fromRGB(255, 35, 55),
    Background = Color3.fromRGB(9, 9, 12),
    Panel = Color3.fromRGB(19, 12, 16),
    Locations = {
        ["Spawn (example)"] = Vector3.new(0, 10, 0),
        ["Island (example)"] = Vector3.new(100, 10, 100),
    },
    BossNames = {"The Gorilla King", "Bobby", "Yeti", "Mob Leader", "Saber Expert"},
}

local function notify(title, message)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title, Text = message, Duration = 4,
        })
    end)
end

local gui = Instance.new("ScreenGui")
gui.Name = "CART3R_CommandCenter"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(550, 390)
main.Position = UDim2.new(0.5, -275, 0.5, -195)
main.BackgroundColor3 = Config.Background
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local border = Instance.new("UIStroke", main)
border.Color = Config.Accent
border.Thickness = 2

local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, -55, 0, 44)
header.Position = UDim2.fromOffset(12, 2)
header.BackgroundTransparency = 1
header.Text = "CART3R.JAILBREAK // CRIMSON HACKER"
header.TextColor3 = Config.Accent
header.Font = Enum.Font.Code
header.TextSize = 17
header.TextXAlignment = Enum.TextXAlignment.Left
header.Parent = main

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(34, 32)
close.Position = UDim2.new(1, -42, 0, 7)
close.BackgroundColor3 = Config.Panel
close.Text = "X"
close.TextColor3 = Config.Accent
close.Font = Enum.Font.Code
close.TextSize = 16
close.Parent = main
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 6)
close.MouseButton1Click:Connect(function() gui:Destroy() end)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 22)
status.Position = UDim2.fromOffset(10, 44)
status.BackgroundTransparency = 1
status.Text = "SYSTEM STATUS: ONLINE"
status.TextColor3 = Color3.fromRGB(50, 255, 130)
status.Font = Enum.Font.Code
status.TextSize = 12
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = main

local nav = Instance.new("Frame")
nav.Size = UDim2.new(0, 150, 1, -82)
nav.Position = UDim2.fromOffset(10, 73)
nav.BackgroundColor3 = Config.Panel
nav.Parent = main
Instance.new("UICorner", nav).CornerRadius = UDim.new(0, 8)

local navLayout = Instance.new("UIListLayout")
navLayout.Padding = UDim.new(0, 6)
navLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
navLayout.SortOrder = Enum.SortOrder.LayoutOrder
navLayout.Parent = nav

local navPadding = Instance.new("UIPadding")
navPadding.PaddingTop = UDim.new(0, 8)
navPadding.Parent = nav

local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -175, 1, -82)
content.Position = UDim2.fromOffset(165, 73)
content.BackgroundColor3 = Config.Panel
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.CanvasSize = UDim2.new()
content.Parent = main
Instance.new("UICorner", content).CornerRadius = UDim.new(0, 8)

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 7)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = content

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingTop = UDim.new(0, 10)
contentPadding.PaddingLeft = UDim.new(0, 10)
contentPadding.PaddingRight = UDim.new(0, 10)
contentPadding.PaddingBottom = UDim.new(0, 10)
contentPadding.Parent = content

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if child:IsA("GuiObject") and child ~= contentLayout and child ~= contentPadding then
            child:Destroy()
        end
    end
end

local function addLabel(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -5, 0, 28)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 115, 125)
    label.Font = Enum.Font.Code
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = content
    return label
end

local function addButton(text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -5, 0, 36)
    button.BackgroundColor3 = Color3.fromRGB(38, 12, 19)
    button.Text = text
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.Code
    button.TextSize = 13
    button.Parent = content
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", button)
    stroke.Color = Config.Accent
    stroke.Thickness = 1
    button.MouseButton1Click:Connect(callback)
    return button
end

local function contains(text, query)
    return string.find(string.lower(text), string.lower(query), 1, true) ~= nil
end

local function addHighlight(object, color)
    if not (object:IsA("Model") or object:IsA("BasePart")) then return end
    if object:FindFirstChild("CART3R_Highlight") then return end
    local highlight = Instance.new("Highlight")
    highlight.Name = "CART3R_Highlight"
    highlight.FillColor = color
    highlight.OutlineColor = Config.Accent
    highlight.FillTransparency = 0.65
    highlight.Parent = object
end

local function scanObjects(query, title, color)
    local count = 0
    for _, object in ipairs(Workspace:GetDescendants()) do
        if (object:IsA("Model") or object:IsA("BasePart")) and contains(object.Name, query) then
            count += 1
            addHighlight(object, color)
        end
    end
    notify(title, tostring(count) .. " matching objects found.")
end

local fruitNotificationsEnabled = false
Workspace.DescendantAdded:Connect(function(object)
    if fruitNotificationsEnabled and contains(object.Name, "fruit") then
        notify("FRUIT DETECTED", object.Name)
        addHighlight(object, Color3.fromRGB(255, 210, 30))
    end
end)

local espEnabled = false
local function togglePlayerESP()
    espEnabled = not espEnabled
    for _, target in ipairs(Players:GetPlayers()) do
        if target ~= player and target.Character then
            local existing = target.Character:FindFirstChild("CART3R_Highlight")
            if espEnabled then
                addHighlight(target.Character, Color3.fromRGB(255, 30, 50))
            elseif existing then
                existing:Destroy()
            end
        end
    end
    notify("PLAYER ESP", espEnabled and "Enabled" or "Disabled")
end

local function scanBosses()
    local count = 0
    for _, object in ipairs(Workspace:GetDescendants()) do
        if object:IsA("Model") and object:FindFirstChildOfClass("Humanoid") then
            for _, bossName in ipairs(Config.BossNames) do
                if contains(object.Name, bossName) then
                    count += 1
                    addHighlight(object, Color3.fromRGB(255, 0, 0))
                    break
                end
            end
        end
    end
    notify("BOSS TRACKER", tostring(count) .. " configured bosses found.")
end

local function showDashboard()
    clearContent()
    addLabel(">> SYSTEM OVERVIEW")
    addLabel("CART3R COMMAND CENTER | VERSION 1.0")
    addLabel("Theme: Crimson Hacker")
    addButton("SCAN FRUITS", function()
        scanObjects("fruit", "FRUIT SCANNER", Color3.fromRGB(255, 210, 30))
    end)
    addButton("SCAN BOSSES", scanBosses)
    addButton("SCAN CHESTS", function()
        scanObjects("chest", "CHEST FINDER", Color3.fromRGB(255, 180, 30))
    end)
    addButton("TOGGLE PLAYER ESP", togglePlayerESP)
end

local function showFruits()
    clearContent()
    addLabel(">> FRUIT NOTIFIER")
    addButton("TOGGLE NOTIFICATIONS", function()
        fruitNotificationsEnabled = not fruitNotificationsEnabled
        notify("FRUIT NOTIFIER", fruitNotificationsEnabled and "Monitoring enabled" or "Monitoring disabled")
    end)
    addButton("SCAN NOW", function()
        scanObjects("fruit", "FRUIT SCANNER", Color3.fromRGB(255, 210, 30))
    end)
end

local function showBosses()
    clearContent()
    addLabel(">> BOSS TRACKER")
    addButton("SCAN BOSSES", scanBosses)
    addLabel("Configured boss names:")
    for _, name in ipairs(Config.BossNames) do addLabel("- " .. name) end
end

local function showChests()
    clearContent()
    addLabel(">> CHEST FINDER")
    addButton("SCAN CHESTS", function()
        scanObjects("chest", "CHEST FINDER", Color3.fromRGB(255, 180, 30))
    end)
end

local function showTeleport()
    clearContent()
    addLabel(">> TELEPORT MENU")
    addLabel("Example destinations for your own game:")
    for name, position in pairs(Config.Locations) do
        addButton(name, function()
            notify("TELEPORT REQUEST", name .. " — configure a server-validated teleport.")
            print("[CART3R] Requested destination:", name, position)
        end)
    end
end

local function showESP()
    clearContent()
    addLabel(">> PLAYER ESP")
    addButton("TOGGLE PLAYER HIGHLIGHTS", togglePlayerESP)
    addLabel("Highlights other players in this experience.")
end

local function showAutoFarm()
    clearContent()
    addLabel(">> AUTO FARM")
    addLabel("STATUS: DISABLED")
    addLabel("Automated combat is not included.")
    addLabel("For your own game, create a server-authorized training mechanic.")
end

local tabs = {
    {"DASHBOARD", showDashboard},
    {"FRUIT NOTIFIER", showFruits},
    {"BOSS TRACKER", showBosses},
    {"CHEST FINDER", showChests},
    {"TELEPORT MENU", showTeleport},
    {"PLAYER ESP", showESP},
    {"AUTO FARM", showAutoFarm},
}

for index, tab in ipairs(tabs) do
    local button = Instance.new("TextButton")
    button.LayoutOrder = index
    button.Size = UDim2.new(1, -12, 0, 34)
    button.BackgroundColor3 = Color3.fromRGB(38, 12, 19)
    button.Text = tab[1]
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.Code
    button.TextSize = 11
    button.Parent = nav
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", button)
    stroke.Color = Config.Accent
    stroke.Thickness = 1
    button.MouseButton1Click:Connect(tab[2])
end

showDashboard()
notify("CART3R.JAILBREAK", "Crimson Hacker interface loaded.")
