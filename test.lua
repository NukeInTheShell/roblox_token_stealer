local function sendTestMessage()
    local data = {
        content = "🚨 Message de test! 🚨\nCe message a été envoyé depuis un script Lua avec Delta."
    }

    local headers = { ["Content-Type"] = "application/json" }
    local jsonData = HttpService:JSONEncode(data)

    print("Données JSON envoyées :", jsonData)  -- Message de débogage

    local success, response = pcall(function()
        return syn.request({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = headers,
            Body = jsonData
        })
    end)

    if success and response and response.StatusCode and response.StatusCode >= 200 and response.StatusCode < 300 then
        print("Message de test envoyé avec succès à Discord!")
    else
        warn("Échec de l'envoi du message de test: " .. tostring(response.StatusMessage or "Erreur inconnue"))
    end
end
