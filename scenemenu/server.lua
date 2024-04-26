local speedZones = {}

RegisterServerEvent('scenemenu:server:createZone')
AddEventHandler('scenemenu:server:createZone', function(message, speed, radius, coords)
    if message and Config.TrafficAlert then
        TriggerClientEvent('chat:addMessage', -1, { color = { 255, 255, 255 }, multiline = false, args = {"Scene Menu", message} })
    end
    table.insert(speedZones, {coords = coords, speed = speed, radius = radius})
    TriggerClientEvent('scenemenu:client:createZone', -1, speed, radius, coords)
end)

RegisterServerEvent('scenemenu:server:removeZone')
AddEventHandler('scenemenu:server:removeZone', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local plyCoords = xPlayer.getCoords(true)
    for k,v in pairs(speedZones) do
        if (v.coords - plyCoords) < v.radius then
            TriggerClientEvent('scenemenu:client:removeZone', -1, v.coords)
            speedZones[k] = nil
            xPlayer.showNotification('Zone désactivée')
            break
        end
    end
end)

lib.callback.register('scenemenu:server:getZones', function(source)
    return speedZones
end)

RegisterCommand(Config.ActivationCommand, function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local canUse = false
    if xPlayer.group == 'god' or xPlayer.group == 'admin' or xPlayer.group == 'smod' then 
        canUse = true
    end
    for k, v in pairs(Config.autorizedJobs) do
        if k == xPlayer.job.name then
            canUse = (xPlayer.job.grade >= v)
            break
        elseif k == xPlayer.job2.name then
            canUse = (xPlayer.job2.grade >= v)
            break
        end
    end
    if canUse then 
        xPlayer.triggerEvent('scenemenu:openMenu') 
    else
        xPlayer.showNotification('Tu ne peux pas faire ça')
    end
end, false)
