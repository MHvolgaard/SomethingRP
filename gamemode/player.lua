local player = LocalPlayer()
local name = player:Nick()
local alias = "Leeroy Jenkins"
local balance
local job
local jobDescription = "Citizen"
local stamina = 100
local armor = 0

function ChangeAlias(ply, s)
    alias = s
end

function ChangeJob(ply)
end

function ChangeJobDescription(ply, s)
    jobDescription = s
end

function GM:PlayerLoadout(ply)
    ply:Give("SRP_Deagle")

    return true
end
