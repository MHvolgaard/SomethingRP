if CLIENT then
    SWEP.PrintName = "Deagle"
    SWEP.Auther = "Noone"
    SWEP.slot = 1
    SWEP.slotPos = 1
    SWEP.IconLetter = "f"

    killicon.AddFont("weapon_deagle2", "CSKillIcons", SWEP.IconLetter, Color(255, 80, 0, 255))
end

SWEP.Base = "weapon_cs_base2"

SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Category = "SomethingRP (Weapon)"

SWEP.ViewModel = "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel = "models/weapons/w_pist_deagle.mdl"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.HoldType = "pistol"

SWEP.Primary.Sound = Sound("Weapon_Deagle_Single")
SWEP.Primary.Recoil = 0
SWEP.Primary.Damage = 50
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.00
SWEP.Primary.ClipSize = 10
SWEP.Primary.Delay = 0.1
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "pistol"

SWEP.IronSightsPos = Vector(-6.35, -7.5, 2.02)
SWEP.IronSightsAng = Vector(0.51, 0, 0)