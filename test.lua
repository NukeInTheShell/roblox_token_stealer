local HttpService = game:GetService("HttpService")

local TELEGRAM_BOT_TOKEN =   -- Remplace par ton bot token, e.g., "8509468086:AAHTLvNig-3aLqDhFC7vEHRkMw8Aq-YBFcs"
local CHAT_ID = "TON_CHAT_ID_ICI"  -- Remplace par ton chat ID, e.g., "6499098881"
local MESSAGE = "Ceci est un test message!"

local TELEGRAM_API_URL = "https://api.telegram.org/bot" .. TELEGRAM_BOT_TOKEN .. "/sendMessage"

local data = {
    chat_id = CHAT_ID,
    text = MESSAGE,
    parse_mode = "Markdown"  -- Optionnel, pour du formatting
}

local headers = { ["Content-Type"] = "application/json" }
local jsonData = HttpService:JSONEncode(data)

local success, response = pcall(function()
    return HttpService:RequestAsync({
        Url = TELEGRAM_API_URL,
        Method = "POST",
        Headers = headers,
        Body = jsonData
    })
end)

if success then
    print("Message de test envoyé avec succès!")
else
    warn("Échec de l'envoi: " .. tostring(response))
end
