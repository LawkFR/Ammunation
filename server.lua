ESX = nil

TriggerEvent(Config.Trigger, function(obj) ESX = obj end)

RegisterServerEvent('lawk:buyarmesblanches')
AddEventHandler('lawk:buyarmesblanches', function(armes, prix, nom)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local nomserveur = Config.NomServeur

    if xPlayer.getMoney() >= prix then
        xPlayer.removeMoney(prix)
        xPlayer.addWeapon(armes, 100)
        TriggerClientEvent('esx:showAdvancedNotification', _source, '~r~Ammunation', '~b~' ..nomserveur, 'Vous venez d\'acheter ~r~x1~s~ ' ..nom, 'CHAR_AMMUNATION', 1)
        lawkLogsDiscord("Le Joueur : **" ..xPlayer.getName().."** à acheter l'arme "..nom, Config.Logs.ArmesBlanches.Webhook)
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, '~r~Ammunation', '~b~' ..nomserveur, 'Vous n\'avez pas assez d\'argent', 'CHAR_AMMUNATION', 1)
    end
end)

RegisterServerEvent('lawk:buyarmesblanchesitem')
AddEventHandler('lawk:buyarmesblanchesitem', function(armes, prix, nom)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local nomserveur = Config.NomServeur

    if xPlayer.getMoney() >= prix then
        xPlayer.removeMoney(prix)
        xPlayer.addInventoryItem(armes, 1)
        TriggerClientEvent('esx:showAdvancedNotification', _source, '~r~Ammunation', '~b~' ..nomserveur, 'Vous venez d\'acheter ~r~x1~s~ ' ..nom, 'CHAR_AMMUNATION', 1)
        lawkLogsDiscord("Le Joueur : **" ..xPlayer.getName().."** à acheter l'arme "..nom, Config.Logs.ArmesBlanches.Webhook)
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, '~r~Ammunation', '~b~' ..nomserveur, 'Vous n\'avez pas assez d\'argent', 'CHAR_AMMUNATION', 1)
    end
end)

RegisterServerEvent('lawk:buyarmeslourdes')
AddEventHandler('lawk:buyarmeslourdes', function(armes, prix, nom)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local nomserveur = Config.NomServeur

    if xPlayer.getMoney() >= prix then
        xPlayer.removeMoney(prix)
        xPlayer.addWeapon(armes, 100)
        TriggerClientEvent('esx:showAdvancedNotification', _source, '~r~Ammunation', '~b~' ..nomserveur, 'Vous venez d\'acheter ~r~x1~s~ ' ..nom, 'CHAR_AMMUNATION', 1)
        lawkLogsDiscord("Le Joueur : **" ..xPlayer.getName().."** à acheter l'arme "..nom, Config.Logs.ArmesLourdes.Webhook)
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, '~r~Ammunation', '~b~' ..nomserveur, 'Vous n\'avez pas assez d\'argent', 'CHAR_AMMUNATION', 1)
    end
end)

RegisterServerEvent('lawk:buyarmeslourdesitem')
AddEventHandler('lawk:buyarmeslourdesitem', function(armes, prix, nom)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local nomserveur = Config.NomServeur

    if xPlayer.getMoney() >= prix then
        xPlayer.removeMoney(prix)
        xPlayer.addInventoryItem(armes, 1)
        TriggerClientEvent('esx:showAdvancedNotification', _source, '~r~Ammunation', '~b~' ..nomserveur, 'Vous venez d\'acheter ~r~x1~s~ ' ..nom, 'CHAR_AMMUNATION', 1)
        lawkLogsDiscord("Le Joueur : **" ..xPlayer.getName().."** à acheter l'arme "..nom, Config.Logs.ArmesLourdes.Webhook)
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, '~r~Ammunation', '~b~' ..nomserveur, 'Vous n\'avez pas assez d\'argent', 'CHAR_AMMUNATION', 1)
    end
end)

RegisterServerEvent('lawk:buyitems')
AddEventHandler('lawk:buyitems', function(nom, item, prix, nbre)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local nomserveur = Config.NomServeur
    local prixadditione = prix*nbre

    if xPlayer.getMoney() >= prix then
        xPlayer.removeMoney(prix*nbre)
        xPlayer.addInventoryItem(item, nbre)
        TriggerClientEvent('esx:showAdvancedNotification', _source, '~r~Ammunation', '~b~' ..nomserveur, 'Vous venez d\'acheter ~r~x'..nbre..'~s~ ' ..nom.. ' pour ~g~' ..prixadditione.. '$', 'CHAR_AMMUNATION', 1)
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, '~r~Ammunation', '~b~' ..nomserveur, 'Vous n\'avez pas assez d\'argent', 'CHAR_AMMUNATION', 1)
    end
end)

function VerifierLicense(source, type, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier

	MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner', {
		['@type']  = type,
		['@owner'] = identifier
	}, function(result)
		if tonumber(result[1].count) > 0 then
			cb(true)
		else
			cb(false)
		end

	end)
end

ESX.RegisterServerCallback('lawk:VerifierLicense', function(source, cb, type)
    VerifierLicense(source, 'weapon', cb)
end)

RegisterServerEvent('lawk:buyppa')
AddEventHandler('lawk:buyppa', function(PrixPPA)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = xPlayer.identifier

    MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner', {
        ['@type']  = 'weapon',
        ['@owner'] = identifier
    }, function(result)
        if tonumber(result[1].count) > 0 then
            TriggerClientEvent('esx:showNotification', _source, 'Vous avez déjà le PPA')
        else
            if xPlayer.getMoney() >= PrixPPA then
                xPlayer.removeMoney(PrixPPA)
                MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
                    ['@type']  = 'weapon',
                    ['@owner'] = identifier
                }, function(rowsChanged)
                    TriggerClientEvent('esx:showAdvancedNotification', _source, '~r~Ammunation', '~b~PPA', 'Vous avez acheté le PPA pour ~g~' ..PrixPPA, 'CHAR_AMMUNATION', 1)
                end)
            else
                TriggerClientEvent('esx:showAdvancedNotification', _source, '~r~Ammunation', '~b~PPA', 'Vous n\'avez pas assez d\'argent pour acheté le PPA', 'CHAR_AMMUNATION', 1)
            end
        end
    end)
end)

function lawkLogsDiscord(message,url)
    local DiscordWebHook = url
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs Ammunation Lawk#0008", content = message}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('lawk:logsDiscord')
AddEventHandler('lawk:logsDiscord', function(message, url)
	lawkLogsDiscord(message,url)
end)