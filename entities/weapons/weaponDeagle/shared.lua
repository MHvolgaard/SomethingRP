
if SERVER then
    AddCSLuaFile("shared.lua")
end

SWEP.PrintName = "Deagle"

SWEP.Auther = "Noone"
SWEP.Contact = "Noon"
SWEP.Purpose = "Noone"
SWEP.Instructions = "Noone"

SWEP.Category = "SomethingRP (Weapon)"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel = "models/weapons/w_pist_deagle.mdl"
SWEP.ViewModelFlip = false


SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false


SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.UseHands = true

SWEP.HoldType = "Pistol" 


SWEP.FiresUnderwater = false

SWEP.DrawCrosshair = true

SWEP.DrawAmmo = false

SWEP.ReloadSound = ""

SWEP.Base = "weapon_base"


SWEP.Primary.Sound = Sound("weapons/deagle/deagle-1.wav")
SWEP.Primary.Damage = 49
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 7
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.DefaultClip = 7
SWEP.Primary.Spread = 0
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Recoil = 1.25
SWEP.Primary.Delay = 0.50
SWEP.Primary.Force = 15

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.CSMuzzleFlashes = false

--[[ if CLIENT then
    SWEP.Icon = "vgui/entities/weapon_deagle2"
    SWEP.EquipMenuData = {
        type = "Weapon",
        desc = "Something RP Deagle"
    };
end

if SERVER then
    resource.AddFile("materials/vgui/entities/weapon_deagle2.vmt")
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
        

