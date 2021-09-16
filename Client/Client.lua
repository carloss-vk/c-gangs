ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end

    Wait(1000)

    ESX.PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function()
    ESX.PlayerData = ESX.GetPlayerData()
end)

-- Main loop --

CreateThread(function()
    Wait(2000)
    while true do
        Wait(0)

        local _sleep = true

        if ESX.PlayerData ~= nil then
            for k,v in pairs(Config.Gangs) do
                if ESX.PlayerData.job.name == v.Job then
                
                    local _coords = GetEntityCoords(PlayerPedId())
                    local _dist = #(_coords - v.Armory) < 3
                    local _pid = PlayerPedId()

                    if _dist then
                        _sleep = false
                        ShowFloatingHelpNotification('Press ~r~[E]~w~ to access the armory', v.Armory)
                        if IsControlJustPressed(0, 38) then
                            OpenArmoryMenu()
                        end
                    end

                    local _dist = #(_coords - v.SpawnCars) < 3

                    if _dist then
                        _sleep = false
                        ShowFloatingHelpNotification('Press ~r~[E]~w~ to access the garage', v.SpawnCars)
                        if IsControlJustPressed(0, 38) then
                            OpenGarageMenu()
                        end
                    end

                    local _dist = #(_coords - v.DeleteCars) < 3

                    if _dist then
                        _sleep = false
                        if IsPedInAnyVehicle(PlayerPedId()) then
                            ShowFloatingHelpNotification('Press ~r~[E]~w~ to delete the vehicle', v.DeleteCars)
                            if IsControlJustPressed(0, 38) then
                                local veh = ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
                                TaskLeaveVehicle(PlayerPedId(), veh, 0)
                                Wait(3000)
                                NetworkFadeOutEntity(veh, false, true)
                                Wait(1000)
                                DeleteVehicle(GetVehiclePedIsIn(_pid))
                                ESX.ShowNotification('You have ~r~saved~w~ a ~g~vehicle~s~ in the ~g~garage')
                            end
                        end
                    end

                    local _dist = #(_coords - v.Boss) < 3

                    if ESX.PlayerData.job.grade_name == 'boss' then
                        if _dist then
                            _sleep = false
                            ShowFloatingHelpNotification('Press ~r~[E]~w~ to access to the boss actions', v.Boss)
                            if IsControlJustPressed(0, 38) then
                                TriggerEvent(Config.Triggers.OpenBossMenu, v.Society_Name, function(data, menu)
                                    menu.close()
                                end, {wash = v.WashMoney})
                            end
                        end
                    end

                    local _dist = #(_coords - v.Cloakrooms) < 3

                    if _dist then
                        if Config.EnableCloakrooms then
                            _sleep = false
                            ShowFloatingHelpNotification('Press ~r~[E]~w~ to access the cloakroom', v.Cloakrooms)
                            if IsControlJustPressed(0, 38) then
                                OpenClothesMenu()
                            end
                        end
                    end

                    local _dist = #(_coords - v.Shop) < 3

                    if _dist then
                        if Config.EnableGangShop then
                            _sleep = false
                            ShowFloatingHelpNotification('Press ~r~[E]~w~ to access the gang shop', v.Shop)
                            if IsControlJustPressed(0, 38) then
                                OpenShopMenu()
                            end
                        end
                    end

                    local _dist = #(_coords - v.GangInfo) < 3

                    if _dist then
                        if Config.EnablePersonalGangInfo then
                            _sleep = false
                            ShowFloatingHelpNotification('Press ~r~[E]~w~ to view the personal gang info', v.GangInfo)
                            if IsControlJustPressed(0, 38) then
                                OpenGangInfo()
                            end
                        end
                    end
                end
            end
        end
        if _sleep then Wait(1000) end
    end
end)
