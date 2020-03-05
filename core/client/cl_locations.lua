---------------------------
-- Locals --
---------------------------
local location1 = vector3(0, 0, 0)
local location2 = vector3(0, 0, 0)
local location3 = vector3(0, 0, 0)
local location4 = vector3(0, 0, 0)
local location5 = vector3(0, 0, 0)
local location6 = vector3(0, 0, 0)
local location7 = vector3(0, 0, 0)
local packaging = false

---------------------------
-- Citizen Threads --
---------------------------
-- Teleports
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if Config.UseLocationExtras then
            local plyPed = GetPlayerPed(-1)
            local plyPos = GetEntityCoords(plyPed)
            if isNear(plyPos, location1, 0.4) then
                drawInfo("Press ~r~[E]~w~ to Enter", location1.x, location1.y, location1.z)
                if IsControlJustPressed(0, 38) then  -- Key: E
                    teleportPly(plyPed, location2)
                end
            end
            if isNear(plyPos, location2, 0.4) then
                drawInfo("Press ~r~[E]~w~ to Exit", location2.x, location2.y, location2.z)
                if IsControlJustPressed(0, 38) then  -- Key: E
                    teleportPly(plyPed, location1)
                end
            end
            if isNear(plyPos, location3, 0.4) then
                drawInfo("Press ~r~[E]~w~ to Enter", location3.x, location3.y, location3.z)
                if IsControlJustPressed(0, 38) then  -- Key: E
                    teleportPly(plyPed, location4)
                end
            end
            if isNear(plyPos, location4, 0.4) then
                drawInfo("Press ~r~[E]~w~ to Exit", location4.x, location4.y, location4.z)
                if IsControlJustPressed(0, 38) then  -- Key: E
                    teleportPly(plyPed, location3)
                end
            end
            if isNear(plyPos, location5, 0.4) then
                drawInfo("Press ~r~[E]~w~ to Enter", location5.x, location5.y, location5.z)
                if IsControlJustPressed(0, 38) then  -- Key: E
                    teleportPly(plyPed, location6)
                end
            end
            if isNear(plyPos, location6, 0.4) then
                drawInfo("Press ~r~[E]~w~ to Exit", location6.x, location6.y, location6.z)
                if IsControlJustPressed(0, 38) then  -- Key: E
                    teleportPly(plyPed, location5)
                end
            end
            if isNear(plyPos, location7, 3) then
                if not bagging then
                    drawInfo("Press ~r~[E]~w~ to Bag Cocaine", location7.x, location7.y, location7.z)
                    if IsControlJustPressed(0, 38) then  -- Key: E
                        TriggerServerEvent('scrubz_drugs_sv:packageCocaine')
                        packaging = true
                    end
                end
            end
        end
    end
end)

---------------------------
-- Event Handlers --
--------------------------
-- Set Various Vectors
RegisterNetEvent('scrubz_drugs_cl:assignVectors')
AddEventHandler('scrubz_drugs_cl:assignVectors', function(vector1, vector2, vector3, vector4, vector5, vector6, vector7)
    location1 = vector1
    location2 = vector2
    location3 = vector3
    location4 = vector4
    location5 = vector5
    location6 = vector6
    location7 = vector7
end)

RegisterNetEvent('scrubz_drugs_cl:packageCocaine')
AddEventHandler('scrubz_drugs_cl:packageCocaine', function()
    if Config.UseProgressBars then
        local plyPed = GetPlayerPed(-1)
        while not HasAnimDictLoaded("mp_safehouselost@") do
            RequestAnimDict("mp_safehouselost@")
            Citizen.Wait(5)
        end
        TaskPlayAnim(plyPed, "mp_safehouselost@", "package_dropoff", 5.0, 1.0, -1, 48, 0, 0, 0, 0)
        exports['progressBars']:startUI(5000, "Bagging up some coke...")
        Citizen.Wait(5000)
        StopAnimTask(plyPed, "mp_safehouselost@", "package_dropoff", 1.0)
        Citizen.Wait(1000)
        packaging = false
        exports['mythic_notify']:SendAlert('success', '1g of Coke Bagged!', 3500)
    elseif Config.UseMythicProgbar then
        while not HasAnimDictLoaded("mp_safehouselost@") do
            RequestAnimDict("mp_safehouselost@")
            Citizen.Wait(5)
        end
        TaskPlayAnim(plyPed, "mp_safehouselost@", "package_dropoff", 5.0, 1.0, -1, 48, 0, 0, 0, 0)
        exports['mythic_progbar']:Progress({
            name = "packaging_coke",
            duration = 5000,
            label = "Bagging up some coke...",
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = false,
            },
            }, function(status)
            if not status then
                StopAnimTask(plyPed, "mp_safehouselost@", "package_dropoff", 1.0)
                Citizen.Wait(1000)
                packaging = false
                exports['mythic_notify']:SendAlert('success', '1g of Coke Bagged!', 3500)
            end
        end)
    elseif Config.UserExport then
        -- //Add Your Export Here// --
    end
end)
