RegisterServerEvent('ZoneActivated')
AddEventHandler('ZoneActivated', function(message, speed, radius, x, y, z)
    if message and Config.TrafficAlert then
        TriggerClientEvent('chat:addMessage', -1, { color = { 255, 255, 255 }, multiline = false, args = {"Scene Menu", message} })
    end
    TriggerClientEvent('Zone', -1, speed, radius, x, y, z)
end)

RegisterServerEvent('Disable')
AddEventHandler('Disable', function(blip)
    TriggerClientEvent('RemoveBlip', -1)
end)



RegisterCommand(Config.ActivationCommand, function(source, args, rawCommand)
    xPlayer = ESX.GetPlayerFromId(source)
    local canUse = false
    if xPlayer.group == 'god' or xPlayer.group == 'admin' or xPlayer.group == 'smod' then 
        canUse = true
    end
    if lib.table.contains(Config.autorizedJobs, xPlayer.job.name) or lib.table.contains(Config.autorizedJobs, xPlayer.job2.name)  then
        canUse = true
    end
    if canUse then xPlayer.triggerEvent('scenemenu:openMenu') end
end, false)
