surface.CreateFont("HUDStyle", {
	font = "Roboto",
	size = 32,
	weight = 700,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	outline = true
})

hook.Add("HUDPaint", "hud", function()
	local player = LocalPlayer()
	--Background
	surface.SetDrawColor(50,50,50,150)
	surface.DrawRect(20,surface.ScreenHeight() - 220,400,200)
	--Job box
	draw.RoundedBox(5, 20, surface.ScreenHeight() - 220, 200,40, team.GetColor(player:Team()))
	-- Job name
	surface.SetFont("HUDStyle")
	surface.SetTextColor(Color(255,255,255,255))
	surface.SetTextPos(90, surface.ScreenHeight() -210)
	draw.DrawText(string.upper(team.GetName(player:Team())), "HUDStyle", 120, surface.ScreenHeight()-215, Color(255,255,255,255), TEXT_ALIGN_CENTER)
	-- Player name
	surface.SetFont("HUDStyle")
	surface.SetTextPos(30, surface.ScreenHeight() -170)
	surface.DrawText("Name: " .. player:Nick())
	-- Balance
	surface.SetTextPos(30, surface.ScreenHeight() - 140)
	surface.DrawText("Balance: " .. player:GetBalance())

end)

function GM:HUDShouldDraw( name )
	local hud = {"CHudHealth", "CHudBattery"}
	for n, element in pairs(hud) do
		if name == element then return false end
	end
	return true
end