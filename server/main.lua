ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand(Config.Command, function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local isAllowed = false
        for _,group in pairs(Config.AllowedGroups) do
            if group == xPlayer.getGroup() then
                isAllowed = true
                break
            end
        end

        if isAllowed then
            TriggerClientEvent('relisoft_players:drawText',source)
        else
            TriggerEvent('chat:addMessage', source, { args = { 'Uživatelé', 'Na tento příkaz nemáte oprávnění' }, color = { 255, 50, 50 } })
        end
    end
end)
