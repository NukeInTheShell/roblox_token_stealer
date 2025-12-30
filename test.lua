-- Script pour envoyer un message de test à Discord
-- Fonctionne avec les exécuteurs comme Delta, Synapse X, etc.

-- Services Roblox nécessaires
local HttpService = game:GetService("HttpService")

-- URL de votre webhook Discord
local WEBHOOK_URL = "https://discord.com/api/webhooks/1455615155969851403/EgT6gsKtBbGhgJ1gMDBWpD00lc5pU1m4Slkda6IU6ZaMOa5elH7KdVj3IGdBvF6jyAt0"  -- Remplacez par votre webhook URL

-- Fonction pour envoyer un message de test à Discord
local function sendTestMessage()
    local data = {
        content = "🚨 Message de test! 🚨\nCe message a été envoyé depuis un script Lua."
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
        print("Message de test envoyé avec succès à Discord!")
    else
        warn("Échec de l'envoi du message de test: " .. tostring(response.StatusMessage or "Erreur inconnue"))
    end
end

-- Exécution principale
sendTestMessage()
