-- store.rcore.cz
SharedObject = nil

if Config.Framework == Framework.ESX then
    SharedObject = GetEsxObject()
end

if Config.Framework == Framework.QBCORE then
    SharedObject = GetQBCoreObject()

    for k, v in pairs(SharedObject.Config.Server.Permissions) do
        ExecuteCommand(("add_ace qbcore.%s tag.%s allow"):format(v, v))
    end
end

RegisterCommand(Config.Command, function(source, args)
    local isAllowed = false

    if Config.Framework == Framework.ESX then
        local xPlayer = SharedObject.GetPlayerFromId(source)
        if xPlayer then
            if xPlayer.getPermissions then
                isAllowed = Config.PermissionGroup.ESX[1][xPlayer.getPermissions()] ~= nil
            end
            if xPlayer.getGroup then
                isAllowed = Config.PermissionGroup.ESX[2][xPlayer.getGroup()] ~= nil
            end
        end
    end

    if Config.Framework == Framework.QBCORE then
        for k, v in pairs(SharedObject.Config.Server.Permissions) do
            if Config.PermissionGroup.QBCore[1][v] and IsPlayerAceAllowed(source, "tag." .. v) then
                isAllowed = true
                break
            end
        end
    end

    if isAllowed then
        TriggerClientEvent('relisoft_players:drawText', source)
    else
        TriggerClientEvent('chat:addMessage', source, { args = { _U("users"), _U("no_permission") }, color = { 255, 50, 50 } })
    end

end)

--- @param object object
--- stolen: https://forums.coronalabs.com/topic/27482-copy-not-direct-reference-of-table/
function deepCopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

local permissionGroup = deepCopy(Config.PermissionGroup)
for framework, v in pairs(permissionGroup) do
    for index, _v in pairs(v) do
        for key, permissions in pairs(_v) do
            Config.PermissionGroup[framework][index][key] = nil
            Config.PermissionGroup[framework][index][permissions] = true
        end
    end
end
