AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "hud.lua" )
AddCSLuaFile( "sh_player.lua" )

include( "shared.lua" )
include("hud.lua")
include( 'sh_player.lua' )
BALANCE_STARTAMOUNT = 10000
function FirstSpawn( ply )
	local balance = ply:GetPData("Balance") --Get the saved money amount
 
	if cash == nil then --If it doesn't exist supply the player with the starting money amount
		ply:SetPData("Balance", BALANCE_STARTAMOUNT) --Save it
		ply:SetBalance( BALANCE_STARTAMOUNT ) --Set it to the networked ints that can be called from the client too
	else
	ply:SetBalance( balance ) --If not, set the networked ints to what we last saved
	end
 
end
hook.Add( "PlayerInitialSpawn", "playerInitialSpawn", FirstSpawn )

function PrintBalance( ply )
	ply:ChatPrint("Your balance is: " .. pl:GetBalance())
end
 
function fPlayerDisconnect( ply )
	print("Player Disconnect: Balance saved")
	ply:SaveBalance()
end
 
concommand.Add("balance_get",PrintBalance)