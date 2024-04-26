local speedzones = {}

local speedZone = {
  createZone = function(radius, speed, coords)
    if type(coords) ~= "table" then coords = nil end
    coords = coords or GetEntityCoords(GetPlayerPed(-1))

    radius = radius + 0.0
    speed = speed + 0.0

    local message = nil
    if Config.TrafficAlert then
      local streetName, crossing = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
      streetName = GetStreetNameFromHashKey(streetName)
      message = "^* ^1Traffic Announcement: ^r^*^7Police have ordered that traffic on ^2" ..
      streetName .. " ^7is to travel at a speed of ^2" .. speed .. "mph ^7due to an incident."
    end

    ESX.ShowNotification('Zone de vitesse créée')
    TriggerServerEvent('scenemenu:server:createZone', message, speed, radius, coords)
  end,
  removeZone = function()
    TriggerServerEvent('scenemenu:server:removeZone')
  end
}

local radiusIndex = 1
local speedIndex = 1
lib.registerMenu({
  id = 'scenemenu_menu',
  title = 'scenemenu',
  position = 'top-left',
  onSideScroll = function(selected, scrollIndex, args)
    if selected == 1 then
      radiusIndex = scrollIndex
      lib.setMenuOptions('scenemenu_menu', {
        label = 'Radius',
        values = Config.SpeedZone.Radius,
        description = 'Taille de la zone',
        icon = { 'far', 'circle' },
        defaultIndex = radiusIndex
      }, selected)
    elseif selected == 2 then
      speedIndex = scrollIndex
      lib.setMenuOptions('scenemenu_menu', {
        label = 'Speed',
        values = Config.SpeedZone.Speed,
        description = 'Vitesse dans la zone',
        icon = { 'fas', 'tachometer-alt' },
        defaultIndex = speedIndex
      }, selected)
    end
  end,
  options = {
    { label = 'Radius',           values = Config.SpeedZone.Radius, description = 'Taille de la zone',    icon = { 'far', 'circle' },         defaultIndex = radiusIndex },
    { label = 'Speed',            values = Config.SpeedZone.Speed,  description = 'Vitesse dans la zone', icon = { 'fas', 'tachometer-alt' }, defaultIndex = speedIndex },
    { label = 'Create SpeedZone', icon = { 'far', 'square-check' } },
    { label = 'Delete SpeedZone', icon = { 'far', 'circle-xmark' } },
  }
}, function(selected, scrollIndex, args)
  if selected == 1 or selected == 2 or selected == 3 then
    speedZone.createZone(Config.SpeedZone.Radius[radiusIndex], Config.SpeedZone.Speed[speedIndex])
  elseif selected == 4 then
    speedZone.removeZone()
  end
end)


RegisterNetEvent('scenemenu:client:createZone')
AddEventHandler('scenemenu:client:createZone', function(speed, radius, coords)
  local blip = AddBlipForRadius(coords.x, coords.y, coords.z, radius)
  SetBlipColour(blip, idcolor)
  SetBlipAlpha(blip, 80)
  SetBlipSprite(blip, 9)
  local speedZone = AddRoadNodeSpeedZone(coords.x, coords.y, coords.z, radius, speed, false)

  table.insert(speedzones, { coords = coords, speedZone = speedZone, blip = blip, radius = radius })
end)

RegisterNetEvent('scenemenu:client:removeZone')
AddEventHandler('scenemenu:client:removeZone', function(coords)
  if speedzones == nil or coords == nil then
    return
  end
  for k, v in pairs(speedzones) do
    if (coords - v.coords) <= v.radius then
      RemoveRoadNodeSpeedZone(v.speedZone)
      RemoveBlip(v.blip)
      speedzones[k] = nil
      break
    end
  end
end)

RegisterNetEvent('scenemenu:openMenu')
AddEventHandler('scenemenu:openMenu', function()
  lib.showMenu('scenemenu_menu')
end)

AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  for k, v in pairs(speedzones) do
    RemoveRoadNodeSpeedZone(v.speedZone)
    RemoveBlip(v.blip)
  end
  speedzones = {}
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer, isNew, skin)
  lib.callback('scenemenu:server:getZones', 1000, function(currentZones)
    for k, v in pairs(currentZones) do 
      local blip = AddBlipForRadius(v.coords.x, v.coords.y, v.coords.z, v.radius)
      SetBlipColour(blip, idcolor)
      SetBlipAlpha(blip, 80)
      SetBlipSprite(blip, 9)
      local speedZone = AddRoadNodeSpeedZone(v.coords.x, v.coords.y, v.coords.z, v.radius, v.speed, false)
      table.insert(speedzones, { coords = v.coords, speedZone = speedZone, blip = blip, radius = v.radius })
    end
  end)
end)