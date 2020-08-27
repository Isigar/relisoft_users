local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local draw = false
local visiblePlayers = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)


RegisterNetEvent('relisoft_players:drawText')
AddEventHandler('relisoft_players:drawText',function()
    if draw then
        draw = false
        TriggerEvent('chat:addMessage', { args = { 'Uživatelé', 'Vypínám sledování - nyní nebudete videt uživatelské nicky, zapněte pomocí /users' }, color = { 255, 50, 50 } })
    else
        draw = true
        TriggerEvent('chat:addMessage', { args = { 'Uživatelé', 'Zapínám sledování - nyní budete videt uživatelské nicky, vypněte pomocí /users' }, color = { 255, 50, 50 } })
    end
end)

function draw3DText(pos, text, options)
    options = options or { }
    local color = options.color or {r = 255, g = 255, b = 255, a = 255}
    local scaleOption = options.size or 0.8

    local camCoords      = GetGameplayCamCoords()
    local dist           = #(vector3(camCoords.x, camCoords.y, camCoords.z)-vector3(pos.x, pos.y, pos.z))
    local scale = (scaleOption / dist) * 2
    local fov   = (1 / GetGameplayCamFov()) * 100
    local scaleMultiplier = scale * fov
    SetDrawOrigin(pos.x, pos.y, pos.z, 0);
    SetTextProportional(0)
    SetTextScale(0.0 * scaleMultiplier, 0.55 * scaleMultiplier)
    SetTextColour(color.r,color.g,color.b,color.a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.NearPlayerTime or 500)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local allPlayers = GetActivePlayers()
        for _, v in pairs(allPlayers) do
            local targetPed = GetPlayerPed(v)
            local targetCoords = GetEntityCoords(targetPed)
            if #(coords-targetCoords) < Config.DrawDistance then
                visiblePlayers[v] = v
            end
        end
    end
end)

--Draw thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if draw then
            local currentCoords = GetEntityCoords(GetPlayerPed(PlayerId()))
            for _, v in pairs(visiblePlayers) do
                local ped = GetPlayerPed(v)
                local cords = GetEntityCoords(ped)
                if #(cords-currentCoords) < Config.DrawDistance then
                    draw3DText(cords, GetPlayerName(v)..' '..GetPlayerServerId(v), {
                        size = Config.TextSize
                    })
                end
            end
        end
    end
end)
