local cooldown = false

ESX.RegisterServerCallback('niko-postopHeist-startCheck', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local sufficiently = false
    local xPlayers = ESX.GetPlayers()
    local cops = 0
    local item = xPlayer.getInventoryItem(Config.Items.gate_item)

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
			cops = cops + 1
		end
	end

    if cops >= Config.RequiredPolice then
            if cooldown == false then
                if item.count >= 1 then
                    sufficiently = true
                end
            else
                TriggerClientEvent('esx:showNotification', source, 'Nie możesz tego zrobić!')
            end
        else
        TriggerClientEvent('esx:showNotification', source, 'Brak Funkcjonariuszy! Wróć tu później')
    end

    cb({
        data = sufficiently,
    })
end)

ESX.RegisterServerCallback('niko-postopHeist-hackFirstProgress', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem(Config.Items.gate_item, 1)
    TriggerClientEvent('niko-postopheist-doorsOpen-1', -1)
    cooldown = true
    Wait(Config.CoolDownTime*60000)
    cooldown = false
end)

ESX.RegisterServerCallback('niko-postopHeist-shortCircuit', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local sufficiently = false
    local item = xPlayer.getInventoryItem(Config.Items.electricbox_item)

    if item.count >= 1 then
        sufficiently = true
    end

    cb({
        data = sufficiently,
    })
end)

ESX.RegisterServerCallback('niko-postopHeist-hackSecondProgress', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem(Config.Items.electricbox_item, 1)
    TriggerClientEvent('niko-postopheist-doorsOpen-2', -1)
end)

ESX.RegisterServerCallback('niko-postopHeist-craftPenDrive', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local sufficiently = false
    local item1 = xPlayer.getInventoryItem(Config.CraftPenDriveItems.first_item)
    local item2 = xPlayer.getInventoryItem(Config.CraftPenDriveItems.second_item)
    local item3 = xPlayer.getInventoryItem(Config.CraftPenDriveItems.third_item)

    if item1.count >= 1 and item2.count >= 1 and item3.count >= 1 then
        xPlayer.removeInventoryItem(Config.CraftPenDriveItems.first_item, 1)
        xPlayer.removeInventoryItem(Config.CraftPenDriveItems.second_item, 1)
        xPlayer.removeInventoryItem(Config.CraftPenDriveItems.third_item, 1)
        xPlayer.addInventoryItem(Config.Items.craftpendrive, 1)
        sufficiently = true
    end

    cb({
        data = sufficiently,
    })
end)

ESX.RegisterServerCallback('niko-postopHeist-hackingSystem', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local sufficiently = false
    local item = xPlayer.getInventoryItem(Config.Items.craftpendrive)

    if item.count >= 1 then
        sufficiently = true
    end

    cb({
        data = sufficiently,
    })
end)

ESX.RegisterServerCallback('niko-postopHeist-rewardHeist_1', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local heroRandom = math.random(5, 10)
    local randomMoney = math.random(80000, 125000)
    xPlayer.addInventoryItem(Config.RewardsItems.item_first_box_1, heroRandom)
    xPlayer.addInventoryItem(Config.RewardsItems.item_first_box_2, randomMoney)
end)

ESX.RegisterServerCallback('niko-postopHeist-rewardHeist_2', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem(Config.RewardsItems.item_second_box_1, 1)
    xPlayer.addInventoryItem(Config.RewardsItems.item_second_box_2, 1)
end)

ESX.RegisterServerCallback('niko-postopHeist-rewardHeist_3', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local randomMoney = math.random(150000, 250000)
    local randomGold = math.random(15, 30)
    xPlayer.addInventoryItem(Config.RewardsItems.item_third_box_1, randomMoney)
    xPlayer.addInventoryItem(Config.RewardsItems.item_third_box_2, randomGold)
end)

ESX.RegisterServerCallback('niko-postopHeist-rewardHeist_4', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem(Config.RewardsItems.item_fourth_box_1, 1)
    xPlayer.addInventoryItem(Config.RewardsItems.item_fourth_box_2, 200)
end)

ESX.RegisterServerCallback('niko-postopHeist-rewardHeist_5', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem(Config.RewardsItems.item_fifth_box_1, 1)
    xPlayer.addInventoryItem(Config.RewardsItems.item_fifth_box_2, 1)
end)

ESX.RegisterServerCallback('niko-postopHeist-hackSystemProgress', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem(Config.Items.craftpendrive, 1)
    TriggerClientEvent('niko-postopheist-doorsOpen-3', -1)
end)

ESX.RegisterServerCallback('niko-postopHeist-getCase', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(Config.Items.caseitem, 1)
end)

ESX.RegisterServerCallback('niko-postopHeist-getMiniSafe', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(Config.Items.keysdoors, 1)
end)

ESX.RegisterServerCallback('niko-postopHeist-openSafeChekingItem', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local sufficiently = false
    local item = xPlayer.getInventoryItem(Config.Items.keysdoors)

    if item.count >= 1 then
        sufficiently = true
    end

    cb({
        data = sufficiently,
    })
end)

ESX.RegisterServerCallback('niko-postopHeist-openSafeDoors-1', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(Config.Items.keysdoors, 1)
    TriggerClientEvent('niko-postopheist-openSafeDoors-1', -1)
end)

ESX.RegisterServerCallback('niko-postopHeist-openSafeDoors-2', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(Config.Items.keysdoors, 1)
    TriggerClientEvent('niko-postopheist-openSafeDoors-2', -1)
end)

ESX.RegisterServerCallback('niko-postopHeist-openSafeDoors-3', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(Config.Items.keysdoors, 1)
    TriggerClientEvent('niko-postopheist-openSafeDoors-3', -1)
end)

ESX.RegisterServerCallback('niko-postopHeist-openSafeDoors-4', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(Config.Items.keysdoors, 1)
    TriggerClientEvent('niko-postopheist-openSafeDoors-4', -1)
end)

ESX.RegisterServerCallback('niko-postopHeist-openSafeDoors-5', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(Config.Items.keysdoors, 1)
    TriggerClientEvent('niko-postopheist-openSafeDoors-5', -1)
end)

ESX.RegisterServerCallback('niko-postopHeist-firstEndReward', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = GetPlayerName(source)
	wiadomosc = "| Nick: "..name.."\n| ID: "..source.."  \n| Ukończył napad na PostOP jako pierwszy!"
    nikoPostOPendLOG('PostOP - First End Heist', wiadomosc, 56108)
    xPlayer.addInventoryItem(Config.firstEndRewardItem, 1)
end)

ESX.RegisterServerCallback('niko-postopHeist-restartHeist', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('niko-postopheist-restartHeist', -1)
end)

function nikoPostOPendLOG (name,message,color)
    local DiscordWebHook = Config.WebHookLog
    local embeds = {{["title"]=message, ["description"] = "<@653707994340524063>", ["type"]="rich",["color"] =color,["footer"]={["text"]= "TheftRP",},}}
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end