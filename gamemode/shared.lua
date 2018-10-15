GM.Name = "somethingrp"
GM.Author = "Noone"
GM.Email = "N/A"
GM.Website = "N/A"
DeriveGamemode( "sandbox" )

function GM:Initialize(ply)
	print("Welcome")
end	

team.SetUp(0, "Citizen", Color( 0, 225, 0 ))
