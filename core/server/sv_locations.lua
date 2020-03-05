---------------------------
-- Event Handlers --
---------------------------
RegisterServerEvent('scrubz_drugs_sv:getDoors')
AddEventHandler('scrubz_drugs_sv:getDoors', function()
	local weedEnter = vector3(-99.91, -1783.16, 28.29)
	local weedExit = vector3(1066.41, -3183.51, -39.98)
	local cocaineEnter = vector3(-85.98, -1794.88, 27.66)
	local cocaineExit = vector3(1088.65, -3187.46, -39.92)
	local methEnter = vector3(-93.73, -1788.34, 28.09)
	local methExit = vector3(996.81, -3200.67, -37.22)
	local cokePackaging = vector3(1092.45, -3196.61, -39.98)
	TriggerClientEvent('scrubz_drugs_cl:assignVectors', source, weedEnter, weedExit, cocaineEnter, cocaineExit, methEnter, methExit, cokePackaging)
end)

RegisterServerEvent('scrubz_drugs_sv:packageCocaine')
AddEventHandler('scrubz_drugs_sv:packageCocaine', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local rawcoke = xPlayer.getInventoryItem('rawcoke').count
	local baggies = xPlayer.getInventoryItem('baggie').count
	if rawcoke >= 5 then
		if baggies >= 1 then
			xPlayer.removeInventoryItem('rawcoke', 5)
			xPlayer.removeInventoryItem('baggie', 1)
			TriggerClientEvent('scrubz_drugs_cl:packageCocaine', source)
			Citizen.Wait(6000)
			xPlayer.addInventoryItem('coke1g', 1)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Not enough baggies.', length = 4000 })
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Not enough coke to bag up.', length = 4000 })
	end
end)
