ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

print('^0[^4C-GANGS^0] Script ^2Started^0')

RegisterNetEvent('c-gangs:getWeapon')
AddEventHandler('c-gangs:getWeapon', function(source, weapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addWeapon(weapon, 250)
end)

RegisterNetEvent('c-gangs:getItem')
AddEventHandler('c-gangs:getItem', function(source, item)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem(item, 1)
end)