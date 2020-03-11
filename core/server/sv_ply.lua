---------------------------
-- Locals --
---------------------------
ESX = nil
local police = 0

---------------------------
-- Functions --
---------------------------
local function calc(max)
    if max == 1 then
        random = 1
        return random
    end
    if max <= 5 then
        random = math.random(1, max)
        return random
    end
    if max > 5 then
        random = math.random(1, 5)
        return random
    end
end

---------------------------
-- ESX --
---------------------------
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- //Replacing the Thread with this. I blame lack of documentation on fivem's part.// --
-- Thanks Trundle for the useful info!
function countPolice()
    local xPlayers = ESX.GetPlayers()
    police = 0
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            police = police + 1
        end
    end
    SetTimeout(30000, countPolice) -- 30 Seconds
end

countPolice()

---------------------------
-- Event Handlers --
---------------------------
-- Checking for Drugs
RegisterServerEvent('scrubz_drugs_sv:drugsCheck')
AddEventHandler('scrubz_drugs_sv:drugsCheck', function(ped)
    local xPlayer = ESX.GetPlayerFromId(source)
    if police >= Config.PoliceRequired then
        if Config.EnableWeed then
            local weed = xPlayer.getInventoryItem(Config.WeedItemName).count
            if weed >= 1 then
                local drugType = Config.WeedItemName
                TriggerClientEvent('scrubz_drugs_cl:drugsReturn', source, ped, true, true, drugType)
                return
            end
        end
        if Config.EnableCocaine then
            local coke = xPlayer.getInventoryItem(Config.CokeItemName).count
            if coke >= 1 then
                local drugType = Config.CokeItemName
                TriggerClientEvent('scrubz_drugs_cl:drugsReturn', source, ped, true, true, drugType)
                return
            end
        end
        if Config.EnableMeth then
            local meth = xPlayer.getInventoryItem(Config.MethItemName).count
            if meth >= 1 then
                local drugType = Config.MethItemName
                TriggerClientEvent('scrubz_drugs_cl:drugsReturn', source, ped, true, true, drugType)
                return
            end
        end
        if Config.EnableCrack then
            local crack = xPlayer.getInventoryItem(Config.CrackItemName).count
            if crack >= 1 then
                local drugType = Config.CrackItemName
                TriggerClientEvent('scrubz_drugs_cl:drugsReturn', source, ped, true, true, drugType)
                return
            end
        end
        TriggerClientEvent('scrubz_drugs_cl:drugsReturn', source, ped, true, false)
    else
        TriggerClientEvent('scrubz_drugs_cl:drugsReturn', source, ped, false)
    end
end)

-- Ending Drug Sale
RegisterServerEvent('scrubz_drugs_sv:endSale')
AddEventHandler('scrubz_drugs_sv:endSale', function(drugType)
    local xPlayer = ESX.GetPlayerFromId(source)
    local plyMax = xPlayer.getInventoryItem(drugType).count
    if drugType == Config.WeedItemName then
        local price = Config.WeedItemPrice
        local amount = calc(plyMax)
        xPlayer.removeInventoryItem(drugType, amount)
        local cash = amount * price
        xPlayer.addMoney(cash)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You sold ' .. amount .. ' bags of weed for $' .. cash, length = 3500 })
    elseif drugType == Config.CokeItemName then
        local price = Config.CokeItemPrice
        local amount = calc(plyMax)
        xPlayer.removeInventoryItem(drugType, amount)
        local cash = amount * price
        xPlayer.addMoney(cash)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You sold ' .. amount .. ' grams of coke for $' .. cash, length = 3500 })
    elseif drugType == Config.MethItemName then
        local price = Config.MethItemPrice
        local amount = calc(plyMax)
        xPlayer.removeInventoryItem(drugType, amount)
        local cash = amount * price
        xPlayer.addMoney(cash)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You sold ' .. amount .. ' grams of meth for $' .. cash, length = 3500 })
    elseif drugType == Config.CrackItemName then
        local price = Config.CrackItemPrice
        local amount = calc(plyMax)
        xPlayer.removeInventoryItem(drugType, amount)
        local cash = amount * price
        xPlayer.addMoney(cash)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You sold ' .. amount .. ' bags of crack for $' .. cash, length = 3500 })
    end
end)

-- Chat Alert
RegisterServerEvent('scrubz_drugs_sv:drugSale')
AddEventHandler('scrubz_drugs_sv:drugSale', function(streetName, plyGender)
	if plyGender == 0 then
		playerGender = 'Female'
	else
		plyGender = 'Male'
	end
	TriggerClientEvent('scrubz_drugs_cl:chatAlert', -1, '[911] I just saw a ' .. plyGender .. ' selling drugs at ' .. streetName ..'.')
end)
