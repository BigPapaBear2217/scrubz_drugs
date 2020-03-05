---------------------------
-- Functions --
---------------------------
local entityEnumerator = {
    __gc = function(enum)
      if enum.destructor and enum.handle then
        enum.destructor(enum.handle)
      end
      enum.destructor = nil
      enum.handle = nil
    end
}

local function enumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)
        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function enumeratePeds()
    return enumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function isNear(pos1, pos2, maxDistance)
    local diff = pos2 - pos1
	local dist = (diff.x * diff.x) + (diff.y * diff.y)
	return (dist < (maxDistance * maxDistance))
end

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 370
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	DrawRect(_x,_y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 120)
end

function animStart(ply, ped)
    TaskPlayAnim(ply, "mp_safehouselost@", "package_dropoff", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
    TaskPlayAnim(ped, "mp_safehouselost@", "package_dropoff", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
end

function animEnd(ply, ped)
    StopAnimTask(ply, "mp_safehouselost@", "package_dropoff", 1.0)
    StopAnimTask(ped, "mp_safehouselost@", "package_dropoff", 1.0)
    Citizen.Wait(1000)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
end

function drawInfo(hint, x, y, z)
	ESX.Game.Utils.DrawText3D({x = x, y = y, z = z + 1.0}, hint, 0.4)
end

function teleportPly(plyPed, location)
    FreezeEntityPosition(plyPed, true)
    DoScreenFadeOut(500)
    Citizen.Wait(600)
    SetEntityCoords(plyPed, location)
    Citizen.Wait(1000)
    DoScreenFadeIn(500)
    Citizen.Wait(500)
    FreezeEntityPosition(plyPed, false)
end