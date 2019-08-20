ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_notifpolisi:carJackInProgress')
AddEventHandler('esx_notifpolisi:carJackInProgress', function(targetCoords, streetName, vehicleLabel, playerGender)
	if playerGender == 0 then
		playerGender = _U('male')
	else
		playerGender = _U('female')
	end

	TriggerClientEvent('esx_notifpolisi:outlawNotify', -1, _U('carjack', playerGender, vehicleLabel, streetName))
	TriggerClientEvent('esx_notifpolisi:carJackInProgress', -1, targetCoords)
end)

RegisterServerEvent('esx_notifpolisi:combatInProgress')
AddEventHandler('esx_notifpolisi:combatInProgress', function(targetCoords, streetName, playerGender)
	if playerGender == 0 then
		playerGender = _U('male')
	else
		playerGender = _U('female')
	end

	TriggerClientEvent('esx_notifpolisi:outlawNotify', -1, _U('combat', playerGender, streetName))
	TriggerClientEvent('esx_notifpolisi:combatInProgress', -1, targetCoords)
end)

RegisterServerEvent('esx_notifpolisi:gunshotInProgress')
AddEventHandler('esx_notifpolisi:gunshotInProgress', function(targetCoords, streetName, playerGender)
	if playerGender == 0 then
		playerGender = _U('male')
	else
		playerGender = _U('female')
	end

	TriggerClientEvent('esx_notifpolisi:outlawNotify', -1, _U('gunshot', playerGender, streetName))
	TriggerClientEvent('esx_notifpolisi:gunshotInProgress', -1, targetCoords)
end)

ESX.RegisterServerCallback('esx_notifpolisi:isVehicleOwner', function(source, cb, plate)
	local identifier = GetPlayerIdentifier(source, 0)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == identifier)
		else
			cb(false)
		end
	end)
end)
