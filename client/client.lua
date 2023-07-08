player = nil
coords = {}

local variables = {
    closedoor = true,
    heistProggresFirst = false,
    canCraftPenDrive = false,
    canHackSystem = false,
    canGetCase = false,
    canGetMiniSafe = false,
    canOpenSafe = false,
}

local rewards = {
    box_1 = false,
    box_2 = false,
    box_3 = false,
    box_4 = false,
    box_5 = false,
}

Citizen.CreateThread(function()
    while true do
		player = PlayerPedId()
		coords = GetEntityCoords(player)
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    local repeater
    repeat
        Wait(1500)
        GatePostOPDoors = GetClosestObjectOfType(-324.9341, -1287.968, 30.41529, 1.5, 'k4mb1_post_garagedoor', false, false, false)
        OfficePostOPDoors = GetClosestObjectOfType(-302.6851, -1284.495, 31.40782, 1.5, 'k4mb1_post_door2', false, false, false)
        BoxPostOPDoors = GetClosestObjectOfType(-313.0909, -1296.89, 31.39586, 1.5, 'k4mb1_post_secretdoor', false, false, false)
        Safe1PostOPDoors = GetClosestObjectOfType(-309.9496, -1305.165, 31.41969, 1.5, 'k4mb1_post_door2', false, false, false)
        Safe2PostOPDoors = GetClosestObjectOfType(-309.9419, -1312.698, 31.41969, 1.5, 'k4mb1_post_door2', false, false, false)
        Safe3PostOPDoors = GetClosestObjectOfType(-313.0623, -1314.436, 31.41969, 1.5, 'k4mb1_post_door2', false, false, false)
        Safe4PostOPDoors = GetClosestObjectOfType(-314.8389, -1311.396, 31.41969, 1.5, 'k4mb1_post_door2', false, false, false)
        Safe5PostOPDoors = GetClosestObjectOfType(-314.8388, -1303.813, 31.41969, 1.5, 'k4mb1_post_door2', false, false, false)
        StalePostOPDoors = GetClosestObjectOfType(-296.7379, -1295.869, 31.41605, 1.5, 'v_ilev_mldoor02', false, false, false)
        if variables.closedoor == true then
            FreezeEntityPosition(GatePostOPDoors, true)
            FreezeEntityPosition(OfficePostOPDoors, true)
            FreezeEntityPosition(BoxPostOPDoors, true)
            FreezeEntityPosition(Safe1PostOPDoors, true)
            FreezeEntityPosition(Safe2PostOPDoors, true)
            FreezeEntityPosition(Safe3PostOPDoors, true)
            FreezeEntityPosition(Safe4PostOPDoors, true)
            FreezeEntityPosition(Safe5PostOPDoors, true)
            FreezeEntityPosition(StalePostOPDoors, true)
        elseif variables.closedoor == 1 then 
            FreezeEntityPosition(GatePostOPDoors, false)
        elseif variables.closedoor == 2 then
            FreezeEntityPosition(OfficePostOPDoors, false)
        elseif variables.closedoor == 3 then
            FreezeEntityPosition(BoxPostOPDoors, false)
        elseif variables.closedoor == 4 then
            FreezeEntityPosition(Safe1PostOPDoors, false)
        elseif variables.closedoor == 5 then
            FreezeEntityPosition(Safe2PostOPDoors, false)
        elseif variables.closedoor == 6 then
            FreezeEntityPosition(Safe3PostOPDoors, false)
        elseif variables.closedoor == 7 then
            FreezeEntityPosition(Safe4PostOPDoors, false)
        elseif variables.closedoor == 8 then
            FreezeEntityPosition(Safe5PostOPDoors, false)
        end
    until(repeater)
end)

local function startPostOPHeist()
    ESX.TriggerServerCallback('niko-postopHeist-startCheck', function(cb)
        if cb.data then
            local success = exports['vangelico_pc2']:StartPc2()
            if success then
                variables.heistProggresFirst = true
                ESX.TriggerServerCallback('niko-postopHeist-hackFirstProgress', function(cb)
                end)
                local Robbery = {
                    code = "10-90",
                    priority = 1,
                    street = exports['esx_dispatch']:GetStreetAndZone(),
                    id = exports['esx_dispatch']:randomId(),
                    title = "Rabunek PostOP",
                    duration = 11000,
                    blipname = "# 10-90 Napad na PostOP",
                    color = 76,
                    sprite = 477,
                    fadeOut = 100,
                    position = {
                        x = coords.x,
                        y = coords.y,
                        z = coords.z
                    },
                    job = "police"
                }
                TriggerServerEvent("dispatch:svNotify", Robbery)

                local Robbery2 = {
                    code = "10-90",
                    priority = 1,
                    street = exports['esx_dispatch']:GetStreetAndZone(),
                    id = exports['esx_dispatch']:randomId(),
                    title = "Rabunek PostOP",
                    duration = 11000,
                    blipname = "# 10-90 Napad na PostOP",
                    color = 76,
                    sprite = 477,
                    fadeOut = 100,
                    position = {
                        x = coords.x,
                        y = coords.y,
                        z = coords.z
                    },
                    job = "sheriff"
                }
                TriggerServerEvent("dispatch:svNotify", Robbery2)

            elseif not success then
                ESX.ShowNotification('Nie udało ci się obejść zabezpieczeń magazynu, spróbuj ponownie!')
            end
        else
            ESX.ShowNotification('Nie posiadasz wymaganych przedmiotów!')
        end
    end)
end

local function shortCircuit()
    ESX.TriggerServerCallback('niko-postopHeist-shortCircuit', function(cb)
        if cb.data then
            variables.heistProggresFirst = false
            variables.canCraftPenDrive = true
            variables.canHackSystem = true
            variables.canGetCase = true
            variables.canGetMiniSafe = true
            ESX.ShowNotification('Wykryto spięcie, przechodzenie do trybu awaryjnego!')
            ESX.TriggerServerCallback('niko-postopHeist-hackSecondProgress', function(cb)
            end)
        else
            ESX.ShowNotification('Nie posiadasz wymaganych przedmiotów!')
        end
    end)
end

local function craftPenDrive()
    ESX.TriggerServerCallback('niko-postopHeist-craftPenDrive', function(cb)
        if cb.data then
            variables.canCraftPenDrive = false
        else
            ESX.ShowNotification('Nie posiadasz wymaganych przedmiotów!')
        end
    end)
end

local function hackingSystemPostOP()
    ESX.TriggerServerCallback('niko-postopHeist-hackingSystem', function(cb)
        if cb.data then
            local success = exports['sgoc_power']:Matching()
            if success then
                variables.canHackSystem = false
                variables.canOpenSafe = true
                ESX.TriggerServerCallback('niko-postopHeist-hackSystemProgress', function(cb)
                end)
            elseif not success then
                ESX.ShowNotification('Nie udało ci się włamać do systemu magazynu, spróbuj ponownie!')
            end
        else
            ESX.ShowNotification('Nie posiadasz wymaganych przedmiotów!')
        end
    end)
end

local function getMiniSafe()
    if variables.canGetMiniSafe == true then
        variables.canGetMiniSafe = false
        ESX.TriggerServerCallback('niko-postopHeist-getMiniSafe', function(cb)
       end)
    else
        ESX.ShowNotification('Nie możesz tego zrobić!')
    end
end

local function getCase()
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    if weapon == GetHashKey('WEAPON_CROWBAR') and variables.canGetCase == true then
        variables.canGetCase = false
        ESX.TriggerServerCallback('niko-postopHeist-getCase', function(cb)
       end)
    else
        ESX.ShowNotification('Nie możesz tego zrobić!')
    end
end

local function openSafeDoors(id)
    ESX.TriggerServerCallback('niko-postopHeist-openSafeChekingItem', function(cb)
            if cb.data then
                if variables.canOpenSafe == true then
                    if id == 1 then
                    rewards.box_1 = true
                    variables.canOpenSafe = false
                    ESX.TriggerServerCallback('niko-postopHeist-openSafeDoors-1', function(cb)
                    end)
                elseif id == 2 then
                    rewards.box_2 = true
                    variables.canOpenSafe = false
                    ESX.TriggerServerCallback('niko-postopHeist-openSafeDoors-2', function(cb)
                    end)
                elseif id == 3 then
                    rewards.box_3 = true
                    variables.canOpenSafe = false
                    ESX.TriggerServerCallback('niko-postopHeist-openSafeDoors-3', function(cb)
                    end)
                elseif id == 4 then
                    rewards.box_4 = true
                    variables.canOpenSafe = false
                    ESX.TriggerServerCallback('niko-postopHeist-openSafeDoors-4', function(cb)
                    end)
                elseif id == 5 then
                    rewards.box_5 = true
                    variables.canOpenSafe = false
                    ESX.TriggerServerCallback('niko-postopHeist-openSafeDoors-5', function(cb)
                    end)
                end
            else
                ESX.ShowNotification('Nie możesz tego zrobić!')
            end
        else
            ESX.ShowNotification('Nie posiadasz wymaganych przedmiotów!')
        end
    end)
end

local function endHeistRestartPostOP()
    ESX.ShowNotification('Ukończyłeś napad na PostOP! Za 3 minuty zlecenie się zakończy, opuść budynek!')
    ESX.TriggerServerCallback('niko-postopHeist-firstEndReward', function(cb)
    end)
    Wait(3*60000)
    ESX.TriggerServerCallback('niko-postopHeist-restartHeist', function(cb)
    end)
end

local function heistFinishRewards(id)
    if id == 1 then
        rewards.box_1 = false
        ESX.TriggerServerCallback('niko-postopHeist-rewardHeist_1', function(cb)
        end)
        endHeistRestartPostOP()
    elseif id == 2 then
        rewards.box_2 = false
        ESX.TriggerServerCallback('niko-postopHeist-rewardHeist_2', function(cb)
        end)
        endHeistRestartPostOP()
    elseif id == 3 then
        rewards.box_3 = false
        ESX.TriggerServerCallback('niko-postopHeist-rewardHeist_3', function(cb)
        end)
        endHeistRestartPostOP()
    elseif id == 4 then
        rewards.box_4 = false
        ESX.TriggerServerCallback('niko-postopHeist-rewardHeist_4', function(cb)
        end)
        endHeistRestartPostOP()
    elseif id == 5 then
        rewards.box_5 = false
        ESX.TriggerServerCallback('niko-postopHeist-rewardHeist_5', function(cb)
        end)
        endHeistRestartPostOP()
    end
end

RegisterNetEvent('niko-postopheist-doorsOpen-1', function()
    variables.closedoor = 1
end)

RegisterNetEvent('niko-postopheist-doorsOpen-2', function()
    variables.closedoor = 2
end)

RegisterNetEvent('niko-postopheist-doorsOpen-3', function()
    variables.closedoor = 3
end)

-- SAFE DOORS
RegisterNetEvent('niko-postopheist-openSafeDoors-1', function()
    variables.closedoor = 4
end)

RegisterNetEvent('niko-postopheist-openSafeDoors-2', function()
    variables.closedoor = 5
end)

RegisterNetEvent('niko-postopheist-openSafeDoors-3', function()
    variables.closedoor = 6
end)

RegisterNetEvent('niko-postopheist-openSafeDoors-4', function()
    variables.closedoor = 7
end)

RegisterNetEvent('niko-postopheist-openSafeDoors-5', function()
    variables.closedoor = 8
end)
-- SAFE DOORS

RegisterNetEvent('niko-postopheist-restartHeist', function()
    variables.closedoor = true
    variables.heistProggresFirst = false
    variables.canCraftPenDrive = false
    variables.canHackSystem = false
    variables.canGetMiniSafe = false
    variables.canOpenSafe = false
    rewards.box_1 = false
    rewards.box_2 = false
    rewards.box_3 = false
    rewards.box_4 = false
    rewards.box_5 = false
end)

-- TARGETS
Citizen.CreateThread(function()
    exports.qtarget:AddBoxZone("postopgeit", vector3(-325.16, -1287.91, 31.33), 1, 4.0, {
        name="postopgeit",
        heading=271,
        --debugPoly=true,
        minZ=30.13,
        maxZ=34.13
        }, {
            options = {
                {
                    action = function()
                        startPostOPHeist()
                    end,
                    icon = "fas fa-hands",
                    label = "Otwórz",
                },
            },
            distance = 2.5
    })
    exports.qtarget:AddBoxZone("postopspiecie", vector3(-300.69, -1281.95, 31.24), 1, 2.0, {
        name="postopspiecie",
        heading=179,
        --debugPoly=true,
        minZ=26.74,
        maxZ=32.14
        }, {
            options = {
                {
                    action = function()
                        shortCircuit()
                    end,
                    icon = "fas fa-hands",
                    label = "Wywołaj Spięcie",
                    canInteract = function()
                        return variables.heistProggresFirst
                    end,
                },
            },
            distance = 2.5
    })
    exports.qtarget:AddBoxZone("postoppendrivecraft", vector3(-299.7, -1282.57, 31.25), 1, 2.8, {
        name="postoppendrivecraft",
        heading=2,
        --debugPoly=true,
        minZ=26.45,
        maxZ=32.05
        }, {
            options = {
                {
                    action = function()
                        craftPenDrive()
                    end,
                    icon = "fas fa-hands",
                    label = "Połącz",
                    canInteract = function()
                        return variables.canCraftPenDrive
                    end,
                },
            },
            distance = 2.5
    })
    exports.qtarget:AddBoxZone("postoppendrivepostop", vector3(-301.92, -1286.34, 31.25), 1, 0.6, {
        name="postoppendrivepostop",
        heading=270,
        --debugPoly=true,
        minZ=27.5,
        maxZ=31.5
        }, {
            options = {
                {
                    action = function()
                        hackingSystemPostOP()
                    end,
                    icon = "fas fa-hands",
                    label = "Włam się",
                    canInteract = function()
                        return variables.canHackSystem
                    end,
                },
            },
            distance = 2.5
    })

    exports.qtarget:AddBoxZone("postopsejf", vector3(-302.1, -1289.13, 31.25), 1, 0.6, {
        name="postopsejf",
        heading=270,
        --debugPoly=true,
        minZ=26.65,
        maxZ=31.05
    }, {
        options = {
            {
                action = function()
                    getMiniSafe()
                end,
                icon = "fas fa-hands",
                label = "Otwórz Sejf",
                canInteract = function()
                    return variables.canGetMiniSafe
                end,
            },
        },
        distance = 2.5
    })

    exports.qtarget:AddBoxZone("postopszafkawziecie", vector3(-299.66, -1290.45, 31.25), 1, 1.8, {
        name="postopszafkawziecie",
        heading=0,
        --debugPoly=true,
        minZ=28.25,
        maxZ=32.25
    }, {
        options = {
            {
                action = function()
                    getCase()
                end,
                icon = "fas fa-hands",
                label = "Otwórz szafkę",
                canInteract = function()
                    return variables.canGetCase
                end,
            },
        },
        distance = 2.5
    })

    exports.qtarget:AddBoxZone("postopsejf1", vector3(-309.93, -1304.48, 31.26), 1, 1.4, {
        name="postopsejf1",
        heading=90,
        --debugPoly=true,
        minZ=28.66,
        maxZ=32.66
    }, {
        options = {
            {
                action = function(id)
                    openSafeDoors(1)
                end,
                icon = "fas fa-hands",
                label = "Otwórz",
                canInteract = function()
                    return variables.canOpenSafe
                end,
            },
        },
        distance = 2.5
    })

    exports.qtarget:AddBoxZone("postopsejf2", vector3(-309.82, -1312.09, 31.26), 1, 1.4, {
        name="postopsejf2",
        heading=270,
        --debugPoly=true,
        minZ=28.66,
        maxZ=32.66
    }, {
        options = {
            {
                action = function(id)
                    openSafeDoors(2)
                end,
                icon = "fas fa-hands",
                label = "Otwórz",
                canInteract = function()
                    return variables.canOpenSafe
                end,
            },
        },
        distance = 2.5
    })

    exports.qtarget:AddBoxZone("postopsejf3", vector3(-312.46, -1314.46, 31.26), 1, 1.4, {
        name="postopsejf3",
        heading=180,
        --debugPoly=true,
        minZ=28.66,
        maxZ=32.66
    }, {
        options = {
            {
                action = function(id)
                    openSafeDoors(3)
                end,
                icon = "fas fa-hands",
                label = "Otwórz",
                canInteract = function()
                    return variables.canOpenSafe
                end,
            },
        },
        distance = 2.5
    })

    exports.qtarget:AddBoxZone("postopsejf4", vector3(-314.87, -1312.05, 31.26), 1, 1.4, {
        name="postopsejf4",
        heading=270,
        --debugPoly=true,
        minZ=28.66,
        maxZ=32.66
    }, {
        options = {
            {
                action = function(id)
                    openSafeDoors(4)
                end,
                icon = "fas fa-hands",
                label = "Otwórz",
                canInteract = function()
                    return variables.canOpenSafe
                end,
            },
        },
        distance = 2.5
    })

    exports.qtarget:AddBoxZone("postopsejf5", vector3(-315.0, -1304.47, 31.26), 1, 1.4, {
        name="postopsejf5",
        heading=270,
        --debugPoly=true,
        minZ=28.66,
        maxZ=32.66
    }, {
        options = {
            {
                action = function(id)
                    openSafeDoors(5)
                end,
                icon = "fas fa-hands",
                label = "Otwórz",
                canInteract = function()
                    return variables.canOpenSafe
                end,
            },
        },
        distance = 2.5
    })

    exports.qtarget:AddBoxZone("postopnagroda1", vector3(-302.66, -1305.6, 31.26), 1, 2.2, {
        name="postopnagroda1",
        heading=270,
        --debugPoly=true,
        minZ=26.86,
        maxZ=32.06
    }, {
        options = {
            {
                action = function(id)
                    heistFinishRewards(1)
                end,
                icon = "fas fa-hands",
                label = "Weź",
                canInteract = function()
                    return rewards.box_1
                end,
            },
        },
        distance = 2.5
    })
    exports.qtarget:AddBoxZone("postopnagroda2", vector3(-302.39, -1318.29, 31.26), 1, 3.8, {
    name="postopnagroda2",
    heading=270,
    --debugPoly=true,
    minZ=29.86,
    maxZ=33.86
    }, {
        options = {
            {
                action = function(id)
                    heistFinishRewards(2)
                end,
                icon = "fas fa-hands",
                label = "Weź",
                canInteract = function()
                    return rewards.box_2
                end,
            },
        },
        distance = 2.5
    })
    exports.qtarget:AddBoxZone("postopnagroda3", vector3(-313.69, -1320.17, 31.26), 1, 2.4, {
    name="postopnagroda3",
    heading=0,
    --debugPoly=true,
    minZ=27.46,
    maxZ=31.46
    }, {
        options = {
            {
                action = function(id)
                    heistFinishRewards(3)
                end,
                icon = "fas fa-hands",
                label = "Weź",
                canInteract = function()
                    return rewards.box_3
                end,
            },
        },
        distance = 2.5
    })
    exports.qtarget:AddBoxZone("postopnagroda4", vector3(-322.12, -1318.38, 31.26), 1, 2.0, {
    name="postopnagroda4",
    heading=0,
    --debugPoly=true,
    minZ=27.66,
    maxZ=31.66
    }, {
        options = {
            {
                action = function(id)
                    heistFinishRewards(4)
                end,
                icon = "fas fa-hands",
                label = "Weź",
                canInteract = function()
                    return rewards.box_4
                end,
            },
        },
        distance = 2.5
    })
    exports.qtarget:AddBoxZone("postopnagroda5", vector3(-318.6, -1302.44, 31.26), 1, 2.4, {
    name="postopnagroda5",
    heading=270,
    --debugPoly=true,
    minZ=28.46,
    maxZ=32.46
    }, {
        options = {
            {
                action = function(id)
                    heistFinishRewards(5)
                end,
                icon = "fas fa-hands",
                label = "Weź",
                canInteract = function()
                    return rewards.box_5
                end,
            },
        },
        distance = 2.5
    })
end)