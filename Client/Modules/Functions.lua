OpenArmoryMenu = function()
    ESX.UI.Menu.CloseAll()

    for k,v in pairs(Config.Gangs) do
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_', {
        title = 'Armory',
        align = Config.Align,
        elements = v.Weapons
    }, function(data, menu)

        local val = data.current.value

        TriggerServerEvent('c-gangs:getWeapon', GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), val)
    end, function(data, menu)
        menu.close()
    end)
  end
end

OpenGarageMenu = function(model)
    ESX.UI.Menu.CloseAll()

    for k,v in pairs(Config.Gangs) do
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage_', {
        title = 'Garage',
        align = Config.Align,
        elements = v.Cars
    }, function(data, menu)
        menu.close()

        ESX.Game.SpawnVehicle(data.current.model, v.SpawnVehicle, v.Heading, function(veh)
            SetVehicleCustomPrimaryColour(veh, v.VehicleSpawnColor.r, v.VehicleSpawnColor.g, v.VehicleSpawnColor.b)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            ESX.ShowNotification('You have taken out a ~g~'..data.current.model..'~s~ of the ~g~garage')
        end)
    end, function(data, menu)
        menu.close()
        end)
    end
end


OpenShopMenu = function()
    ESX.UI.Menu.CloseAll()

    for k,v in pairs(Config.Gangs) do
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_', {
        title = 'Gang shop',
        align = Config.Align,
        elements = v.ItemShop
    }, function(data, menu)

        local val = data.current.value

        TriggerServerEvent('c-gangs:getItem', GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))), val)
    end, function(data, menu)
        menu.close()
        end)
    end
end

OpenGangInfo = function(source)
    ESX.UI.Menu.CloseAll()

    -- ESX.TriggerServerCallback('c-gangs:getInfo', function(info)
    for k,v in pairs(Config.Gangs) do
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ganginfo_', {
            title = 'Gang Info',
            align = Config.Align,
            elements = {
                {label = 'Your id: ' ..GetPlayerServerId(PlayerId())},
                {label = "Gang job: " ..ESX.PlayerData.job.label.. " - " ..ESX.PlayerData.job.grade_label},
                {label = "Society Money", value = 'society_money'}
            }
        }, function(data, menu)

            if data.current.value == 'society_money' then
                ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
                    ESX.ShowNotification('Your company now has  ' .. money .. ' $')
                end)
            end
        end, function(data, menu)
            menu.close()
        end)
    end
end

OpenClothesMenu = function()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'clothes', {
        title = 'Skin',
        align = 'right',
        elements = {
            {label = 'Ponerse ropa', value  = 'skin'}
        }
    }, function(data, menu)

        if data.current.value == 'skin' then
            local config = {
                ped = true,
                headBlend = true,
                faceFeatures = true,
                headOverlays = true,
                components = true,
                props = true,
            }
            
            exports['fivem-appearance']:startPlayerCustomization(function (appearance)
                if (appearance) then
                print('Saved')
                else
                print('Canceled')
                end
            end, config)
        end
    end, function(data, menu)
        menu.close()
    end)
end

RegisterCommand('heading', function()
    print(GetEntityHeading(PlayerPedId()))
end)

function ShowFloatingHelpNotification(msg, coords)
    SetFloatingHelpTextWorldPosition(1, coords.x, coords.y, coords.z)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(2, false, true, 0)
  end
