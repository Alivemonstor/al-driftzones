local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('al-driftzone:finish', function(score)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local oldpoints = MySQL.query.await('SELECT driftpoints FROM drift_leaderboard where citizenid = ?', {citizenid})
    if not oldpoints[1] then
        MySQL.insert.await('INSERT INTO `drift_leaderboard` (`citizenid`, `driftpoints`) VALUES (:citizenid, :driftpoints)', {
            citizenid = citizenid,
            driftpoints = score
	    })
    elseif oldpoints[1]['driftpoints'] then
        MySQL.insert.await('INSERT INTO `drift_leaderboard` (`citizenid`, `driftpoints`) VALUES (:citizenid, :driftpoints) ON DUPLICATE KEY UPDATE driftpoints = :driftpoints',{
            citizenid = citizenid,
            driftpoints = oldpoints[1]['driftpoints'] + score
	    })
    end
end)

RegisterNetEvent('al-driftzone:loadleaderboard', function()
    local src = source
    local data = MySQL.query.await('SELECT * FROM drift_leaderboard ORDER BY driftpoints DESC;')
    
    local leaderboard = {}
    leaderboard[#leaderboard + 1] = { 
        isMenuHeader = true,
        header = 'Leaderboard',
        icon = 'fas fa-list'
    }
    for k, v in pairs(data) do

        local player = QBCore.Functions.GetPlayerByCitizenId(v['citizenid'])
        leaderboard[#leaderboard + 1] = { 
            header = 'Name: '.. player.PlayerData.charinfo.firstname..' '.. player.PlayerData.charinfo.lastname,
            txt = 'Drift  Points:  '..v['driftpoints'],
            icon = 'fas fa-hand-point-right',
        }
    end
    TriggerClientEvent('al-driftzone:leaderboardloaded', src, leaderboard)
end)