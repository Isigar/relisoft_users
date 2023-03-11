local draw = false
local visiblePlayers = {}

RegisterNetEvent('relisoft_players:drawText')
AddEventHandler('relisoft_players:drawText', function()
    draw = not draw
    if draw then
        TriggerEvent('chat:addMessage', { args = { _U("users"), _U("users_on") }, color = { 255, 50, 50 } })
    else
        TriggerEvent('chat:addMessage', { args = { _U("users"), _U("users_off") }, color = { 255, 50, 50 } })
    end
end)

function draw3DText(pos, text, options)
    options = options or { }
    local color = options.color or { r = 255, g = 255, b = 255, a = 255 }
    local scaleOption = options.size or 0.8

    local camCoords = GetGameplayCamCoords()
    local dist = #(camCoords - pos)
    local scale = (scaleOption / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scaleMultiplier = scale * fov
    SetDrawOrigin(pos.x, pos.y, pos.z, 0);
    SetTextProportional(0)
    SetTextScale(0.0 * scaleMultiplier, 0.55 * scaleMultiplier)
    SetTextColour(color.r, color.g, color.b, color.a)
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

CreateThread(function()
    while true do
        Wait(Config.NearPlayerTime or 500)
        if draw then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local allPlayers = GetActivePlayers()

            visiblePlayers = {}
            for _, v in pairs(allPlayers) do
                local targetPed = GetPlayerPed(v)
                local targetCoords = GetEntityCoords(targetPed)
                if #(coords - targetCoords) < 40 then
                    visiblePlayers[v] = {
                        ped = targetPed,
                        text = GetPlayerName(v) .. ' ' .. GetPlayerServerId(v),
                    }
                end
            end
        end
    end
end)

--Draw thread
CreateThread(function()
    while true do
        Wait(0)
        if draw then
            for _, v in pairs(visiblePlayers) do
                draw3DText(GetEntityCoords(v.ped), v.text, {
                    size = Config.TextSize
                })
            end
        else
            Wait(500)
        end
    end
end)
