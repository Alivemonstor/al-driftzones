local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
	for k, v in pairs(Config.Locations) do
		local blipscenter = AddBlipForCoord(v.blip.x, v.blip.y, v.blip.z)
		SetBlipSprite(blipscenter, 641)
        SetBlipColour(blipscenter, 1)
		SetBlipAsShortRange(blipscenter, true)
        SetBlipScale(blipscenter, 0.7)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(v.name.. ' Drift Zone')
		EndTextCommandSetBlipName(blipscenter)
		driftzone = PolyZone:Create(v.zones, {
			name = v.name,
			debugPoly = v.debugPoly,
		})
		driftzone:onPlayerInOut(function(isPointInside)
			if isPointInside then
				inZone = 1
                QBCore.Functions.Notify('You\'ve entered a drift zone!')
                TriggerEvent('drift:enable')
			else
				inZone = 0
                QBCore.Functions.Notify('You\'ve left a drift zone!')
                TriggerEvent('drift:disable')
			end
		end)
	end
end)

RegisterNetEvent('drift:finish', function(score)
    if score > 0 then
        TriggerServerEvent('al-driftzone:finish', score)
    end
end)

RegisterCommand('driftleaderboard', function()
    TriggerServerEvent('al-driftzone:loadleaderboard')
end, false)

RegisterNetEvent('al-driftzone:leaderboardloaded', function(leaderboard)
    exports['qb-menu']:openMenu(leaderboard) 
end)


CreateThread(function()
    TriggerEvent('drift:disable')
end)