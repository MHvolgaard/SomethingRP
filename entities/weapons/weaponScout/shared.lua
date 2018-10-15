
if SERVER then
    AddCSLuaFile("shared.lua")
end

SWEP.PrintName = "Scout"

SWEP.Auther = "Noone"
SWEP.Contact = "Noon"
SWEP.Purpose = "Noone"
SWEP.Instructions = "Noone"

SWEP.Category = "SomethingRP (Weapon)"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/cstrike/c_snip_scout.mdl"
SWEP.WorldModel = "models/weapons/w_snip_scout.mdl"
SWEP.ViewModelFlip = false


SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false


SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.UseHands = true

SWEP.HoldType = "ar2" 


SWEP.FiresUnderwater = false

SWEP.DrawCrosshair = false

SWEP.DrawAmmo = true

SWEP.ReloadSound = ""

SWEP.Base = "weapon_base"


SWEP.Primary.Sound = Sound("weapons/scout/scout_fire-1.wav")
SWEP.Primary.Damage = 51
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 10
SWEP.Primary.Ammo = "SniperRound"
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Spread = 0
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 1
SWEP.Primary.Delay = 0.90
SWEP.Primary.Force = 15
SWEP.Primary.Cone = 0.02

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.CSMuzzleFlashes = false

--[[ if CLIENT then
    SWEP.Icon = "vgui/entities/weapon_ak472"
    SWEP.EquipMenuData = {
        type = "Weapon",
        desc = "Something RP AK47"
    };
end

if SERVER then
    resource.AddFile("materials/vgui/entities/weapon_ak472.vmt")
end ]]

    function SWEP:Initialize()
        util.PrecacheSound(self.Primary.Sound)
        util.PrecacheSound(self.ReloadSound)
        self:SetWeaponHoldType( self.HoldType )
    end 


    function SWEP:PrimaryAttack() 

        if ( !self:CanPrimaryAttack() ) then return end
        
        local bullet = {}
        bullet.Num = self.Primary.NumberofShots
        bullet.Src = self.Owner:GetShootPos()
        bullet.Dir = self.Owner:GetAimVector()
        bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
        bullet.Tracer = 0
        bullet.Force = self.Primary.Force
        bullet.Damage = self.Primary.Damage
        bullet.AmmoType = self.Primary.Ammo
        
        local rnda = self.Primary.Recoil * -1
        local rndb = self.Primary.Recoil * math.random(-1, 1)
        
        self:ShootEffects()
        
        self.Owner:FireBullets( bullet )
        self:EmitSound(Sound(self.Primary.Sound))
        self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) )
        self:TakePrimaryAmmo(self.Primary.TakeAmmo)
        
        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
        self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
    end

    Zoom = 0 
    function SWEP:SecondaryAttack() 
        if(Zoom == 0) then 
            if(SERVER) then 
                self.Owner:SetFOV( 45, 0 )
            end 
            Zoom = 1
        elseif(Zoom == 1) then 
            if(SERVER) then 
                self.Owner:SetFOV( 25, 0 )
            end
            Zoom = 2
        elseif(Zoom == 2) then 
            if(SERVER) then 
                self.Owner:SetFOV( 0, 0 )
            end 
            Zoom = 0
        end
    end



function SWEP:Holster() 
    self.Owner:SetFOV( 0, 0 ) 
    ScopeLevel = 0 
    return true 
end

function SWEP:Reload()
    self:EmitSound(Sound(self.ReloadSound))
    self.Weapon:DefaultReload( ACT_VM_RELOAD );
end


local scope = surface.GetTextureID("sprites/scope")
function SWEP:DrawHUD()
    if(Zoom == 0) then return end

    surface.SetDrawColor( 0, 0, 0, 255 )
         
         local scrW = ScrW()
         local scrH = ScrH()

         local x = scrW / 2.0
         local y = scrH / 2.0
         local scope_size = scrH

         -- crosshair
         local gap = 80
         local length = scope_size
         surface.DrawLine( x - length, y, x - gap, y )
         surface.DrawLine( x + length, y, x + gap, y )
         surface.DrawLine( x, y - length, x, y - gap )
         surface.DrawLine( x, y + length, x, y + gap )

         gap = 0
         length = 50
         surface.DrawLine( x - length, y, x - gap, y )
         surface.DrawLine( x + length, y, x + gap, y )
         surface.DrawLine( x, y - length, x, y - gap )
         surface.DrawLine( x, y + length, x, y + gap )


         -- cover edges
         local sh = scope_size / 2
         local w = (x - sh) + 2
         surface.DrawRect(0, 0, w, scope_size)
         surface.DrawRect(x + sh - 2, 0, w, scope_size)
         
         -- cover gaps on top and bottom of screen
         surface.DrawLine( 0, 0, scrW, 0 )
         surface.DrawLine( 0, scrH - 1, scrW, scrH - 1 )

         surface.SetDrawColor(255, 0, 0, 255)
         surface.DrawLine(x, y, x + 1, y + 1)

         -- scope
         surface.SetTexture(scope)
         surface.SetDrawColor(255, 255, 255, 255)

surface.DrawTexturedRectRotated(x, y, scope_size, scope_size, 0)


end
