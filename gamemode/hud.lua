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
surface.CreateFont("ItemStyle", {
	font = "Roboto",
	size = 20,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	outline = false
})
surface.CreateFont("HeaderStyle", {
	font = "Roboto",
	size = 18,
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
surface.CreateFont("TimerStyle", {
	font = "Roboto",
	size = 26,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	outline = false
})

local TIMER_PANEL = {
	Init = function( self )
		self.Body = self:Add("Panel")
		self.Body:Dock(BOTTOM)
		self.Body:SetHeight(100)

		self.Timer = self.Body:Add("DLabel")
		self.Timer:SetFont("TimerStyle")
		self.Timer:SetTextColor(Color(255,255,255,255))
		--self.Timer:Dock(LEFT)
		self.Timer:SetContentAlignment(5)
	end,
	PerformLayout = function(self)
		self:SetSize(200,100)
		self:SetPos(215,surface.ScreenHeight() - 210 )
	end,
 
	Think = function(self, w, h)
		net.Receive("round_timer", function( len, pl )
			time = net.ReadInt(10)
		end)
		if time == nil then
			self.Timer:SetText("")
		else
			self.Timer:SetText(time)
		end
	end
}
local PHASE_PANEL = {
	Init = function( self )
		self.Body = self:Add("Panel")
		self.Body:Dock(BOTTOM)
		self.Body:SetHeight(100)

		self.Timer = self.Body:Add("DLabel")
		self.Timer:SetFont("TimerStyle")
		self.Timer:SetTextColor(Color(255,255,255,255))
		--self.Timer:Dock(LEFT)
		self.Timer:SetContentAlignment(5)
	end,
	PerformLayout = function(self)
		self:SetSize(200,100)
		self:SetPos(295,surface.ScreenHeight() - 210 )
	end,
 
	Think = function(self, w, h)
		net.Receive("round_type", function( len, pl )
			phase = net.ReadString()
		end)
		if phase == nil then
			self.Timer:SetText("")
		else
			self.Timer:SetText(string.upper(phase))
		end
	end
}

TIMER_PANEL = vgui.RegisterTable(TIMER_PANEL, "EditablePanel")
PHASE_PANEL = vgui.RegisterTable(PHASE_PANEL, "EditablePanel")
RoundActive = false

net.Receive("round_active", function( len )
	RoundActive = net.ReadBool()
end)

hook.Add("HUDPaint", "hud", function()
	if ( !IsValid(TimerPanel )) then
		TimerPanel = vgui.CreateFromTable(TIMER_PANEL)
	end
	if ( IsValid(TimerPanel )) then
		TimerPanel:Show()
	end
	if (!IsValid(PhasePanel)) then
		PhasePanel = vgui.CreateFromTable(PHASE_PANEL)
	end
	if (IsValid(PhasePanel)) then
		PhasePanel:Show()
	end
	local player = LocalPlayer()
	local role = player_manager.GetPlayerClass(player)
	--Background
	surface.SetDrawColor(50,50,50,150)
	surface.DrawRect(20,surface.ScreenHeight() - 220,400,200)
	--Team box
	draw.RoundedBox(5, 20, surface.ScreenHeight() - 220, 200,40, team.GetColor(player:Team()))
	-- Team name
	surface.SetFont("HUDStyle")
	surface.SetTextColor(Color(255,255,255,255))
	surface.SetTextPos(90, surface.ScreenHeight() -210)
	--surface.DrawText(string.upper(player_manager.GetPlayerClass(player)))
	draw.DrawText(string.upper(role), "HUDStyle", 120, surface.ScreenHeight()-215, Color(255,255,255,255), TEXT_ALIGN_CENTER)
	-- Player name
	surface.SetFont("ItemStyle")
	surface.SetTextPos(30, surface.ScreenHeight() -170)
	surface.DrawText("Name: " .. player:Nick())
	-- Credit
	surface.SetTextPos(30, surface.ScreenHeight() - 140)
	surface.DrawText("Balance: ")
	--Time header
	surface.SetFont("HeaderStyle")
	surface.SetTextPos(230, surface.ScreenHeight() - 227)
	surface.DrawText("TIME:")
	--Phase header
	surface.SetTextPos(300, surface.ScreenHeight() - 227)
	surface.DrawText("PHASE:")
	--
end)

function GM:HUDShouldDraw( name )
	local hud = {"CHudHealth", "CHudBattery"}
	for n, element in pairs(hud) do
		if name == element then return false end
	end
	return true
end