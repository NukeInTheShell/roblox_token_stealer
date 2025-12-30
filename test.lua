-- Activer HttpService
local HttpService = game:GetService("HttpService")

-- URL de ton webhook Discord
local webhook = "https://discord.com/api/webhooks/1455615155969851403/EgT6gsKtBbGhgJ1gMDBWpD00lc5pU1m4Slkda6IU6ZaMOa5elH7KdVj3IGdBvF6jyAt0"

-- Message à envoyer
local data = {
    ["content"] = "Bonjour depuis Roblox + Delta !"
}

-- Convertir en JSON
local jsonData = HttpService:JSONEncode(data)

-- Envoyer le message
HttpService:PostAsync(webhook, jsonData, Enum.HttpContentType.ApplicationJson)
