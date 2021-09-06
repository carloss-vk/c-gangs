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
    local elements = {
        { label = 'Tu ropa', value = 'default' },
        { label = 'Conjuntos Guardados', value = 'saved' },
        { label = 'Comprar ropa', value = 'buy' }
    }
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Clothes'..'job-', {
        title = 'Ropa',
        align = Config.Align,
        elements = elements
    }, function(data, menu)
        if data.current.value == 'default' then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent(Config.Triggers.LoadSkin, skin)
            end)
        end
        if data.current.value == 'saved' then
            ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerDressing', function(dressing)
                local elements = {}      
                for i=1, #dressing, 1 do
                  table.insert(elements, {label = dressing[i], value = i})
                end
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing', {
                    title    = ('Conjuntos'),
                    align    = 'bottom-right',
                    elements = elements,
                }, function(data, menu)
                    TriggerEvent(Config.Triggers.GetPSkin, function(skin)
                        ESX.TriggerServerCallback(Config.Triggers.PlayerOutfit, function(clothes)
                            TriggerEvent('skinchanger:loadClothes', skin, clothes)
                            TriggerEvent('esx_skin:setLastSkin', skin)
                            TriggerEvent('skinchanger:getSkin', function(skin)
                            TriggerServerEvent('esx_skin:save', skin) end)
                            ESX.ShowNotification(('Te pusiste el outfit'))
                        end, data.current.value)
                    end)
                end,function(data, menu)
                    menu.close()
                end)
            end)
        end
        if data.current.value == "buy" then
            HasPayed = false
            TriggerEvent("esx_skin:openRestrictedMenu",function(data, menu)
                menu.close()
                ESX.UI.Menu.Open("default",GetCurrentResourceName(),"shop_confirm",
                    {
                        title = "¿Quieres comprar la ropa?",
                        align = "bottom-right",
                        elements = {
                            {label = "Si", value = "yes"},
                            {label = "No", value = "no"}
                        }
                    },
                    function(data, menu)
                        menu.close()
                        if data.current.value == "yes" then
                            ESX.TriggerServerCallback(
                                "esx_eden_clotheshop:checkMoney",
                                function(hasEnoughMoney)
                                    if hasEnoughMoney then
                                        TriggerEvent("skinchanger:getSkin",function(skin)TriggerServerEvent("esx_skin:save", skin)end)
                                        TriggerServerEvent("esx_eden_clotheshop:pay")
                                        ESX.TriggerServerCallback("esx_eden_clotheshop:checkPropertyDataStore",function(foundStore)
                                            if foundStore then
                                                ESX.UI.Menu.Open("default",GetCurrentResourceName(),"save_dressing",
                                                {
                                                    title = "¿Quieres guardar el conjunto?",
                                                    align = "bottom-right",
                                                    elements = {
                                                        {label = "Si", value = "yes"},
                                                        {label = "No", value = "no"}
                                                    }
                                                },
                                                function(data2, menu2)
                                                    menu2.close()

                                                    if data2.current.value == "yes" then
                                                        ESX.UI.Menu.Open("dialog",GetCurrentResourceName(),"outfit_name",
                                                        {
                                                            title = "Nombre del outfit"
                                                        },
                                                        function(data3, menu3)
                                                            menu3.close()
                                                            TriggerEvent("skinchanger:getSkin",function(skin)
                                                                TriggerServerEvent("esx_eden_clotheshop:saveOutfit",data3.value,skin)
                                                            end)
                                                            ESX.ShowNotification("Guardaste el outfit correctamente")
                                                        end,
                                                        function(data3, menu3)
                                                            menu3.close()
                                                        end)
                                                    end
                                                end)
                                            end
                                        end)
                                    else
                                        ESX.TriggerServerCallback("esx_skin:getPlayerSkin",function(skin)
                                            TriggerEvent("skinchanger:loadSkin", skin)
                                        end)
                                        ESX.ShowNotification("No tienes suficiente dinero")
                                    end
                                end
                            )
                        end
                        if data.current.value == "no" then
                            ESX.TriggerServerCallback("esx_skin:getPlayerSkin",function(skin)
                                TriggerEvent("skinchanger:loadSkin", skin)
                            end)
                        end
                    end,
                    function(data, menu)
                        menu.close()
                    end
                )
            end,
            function(data, menu)
                menu.close()
            end,{"tshirt_1","tshirt_2","torso_1","torso_2","decals_1","decals_2","arms","arms_2","pants_1","pants_2","shoes_1","shoes_2","chain_1","chain_2","bproof_1","bproof_2","watches_1","watches_2","bracelets_1","bracelets_2",'helmet_1','helmet_2','glasses_1','glasses_2',"bags_1","bags_2"})
        end
    end,function(data, menu)
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