
if SERVER then
    AddCSLuaFile("shared.lua")
end

SWEP.PrintName = "AK47"

SWEP.Auther = "Noone"
SWEP.Contact = "Noon"
SWEP.Purpose = "Noone"
SWEP.Instructions = "Noone"

SWEP.Category = "SomethingRP (Weapon)"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"
SWEP.ViewModelFlip = false


SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false


SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.UseHands = true

SWEP.HoldType = "ar2" 


SWEP.FiresUnderwater = false

SWEP.DrawCrosshair = true

SWEP.DrawAmmo = true

SWEP.ReloadSound = ""

SWEP.Base = "weapon_base"


SWEP.Primary.Sound = Sound("weapons/ak47/ak47-1.wav")
SWEP.Primary.Damage = 21
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 30
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Spread = 0.10
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 1.75
SWEP.Primary.Delay = 0.12
SWEP.Primary.Force = 10
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
        
    function SWEP:SecondaryAttack()
    end
        
    function SWEP:Reload()
        self:EmitSound(Sound(self.ReloadSound))
        self.Weapon:DefaultReload( ACT_VM_RELOAD );
    end
        

    function SWEP:DrawHUD()

        -- No crosshair when ironsights is on
        if ( self.Weapon:GetNetworkedBool( "Ironsights" ) ) then return end
    
        local x, y -- local, always
    
        -- If we're drawing the local player, draw the crosshair where they're aiming
        -- instead of in the center of the screen.
        if ( self.Owner == LocalPlayer() && self.Owner:ShouldDrawLocalPlayer() ) then
            local tr = util.GetPlayerTrace( self.Owner )
            tr.mask = ( CONTENTS_SOLID+CONTENTS_MOVEABLE+CONTENTS_MONSTER+CONTENTS_WINDOW+CONTENTS_DEBRIS+CONTENTS_GRATE+CONTENTS_AUX ) -- List the enums that should mask the crosshair on camrea/thridperson
            local trace = util.TraceLine( tr )
    
            local coords = trace.HitPos:ToScreen()
            x, y = coords.x, coords.y
    
        else
            x, y = ScrW() / 2.0, ScrH() / 2.0 -- Center of screen
        end
    
        local scale = 10 * self.Primary.Cone
        local LastShootTime = self.Weapon:GetNetworkedFloat( "LastShootTime", 0 )
            -- Scale the size of the crosshair according to how long ago we fired our weapon
        scale = scale * ( 2 - math.Clamp( ( CurTime() - LastShootTime ) * 5, 0.0, 1.0 ) )
        surface.SetDrawColor( 255, 0, 0, 255 )
    
    -- Draw a crosshair
        local gap = 40 * scale
        local length = gap + 20 * scale
            --				 x1,		 y1, x2,	 y2
        surface.DrawLine( x - length, y, x - gap, y )	-- Left
        surface.DrawLine( x + length, y, x + gap, y )	-- Right
        surface.DrawLine( x, y - length, x, y - gap )	-- Top
        surface.DrawLine( x, y + length, x, y + gap )	-- Bottom
    
    end
