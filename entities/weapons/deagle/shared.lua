if CLIENT then
    SWEP.PrintName = "Deagle"
    SWEP.Auther = "Noone"
    SWEP.slot = 1
    SWEP.slotPos = 1
    SWEP.IconLetter = "f"

    killicon.AddFont("weapon_deagle2", "CSKillIcons", SWEP.IconLetter, Color(255, 80, 0, 255))
end

--[[ SWEP.Base = "weapon_cs_deagle" ]]
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Category = "SomethingRP (Weapon)"

SWEP.ViewModel = "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel = "models/weapons/w_pist_deagle.mdl"

SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Pistol"

--[[ SWEP.Secondary.ClipSize = 10
SWEP.Secondary.DefaultClip = 10
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "pistol" ]]

function SWEP:Initialize()
    self:SetHoldType("pistol")
end

function SWEP:PrimaryAttack()
    if (not self:CanPrimaryAttack()) then
        return
    end

    self:EmitSound("Weapon_357.Single")

    self:ShootBullet(150, 1, 0.01)

    self:TakePrimaryAmmo(1)

    self.Owner:ViewPunch(Angle(-1, 0, 0))
end

--[[ function SWEP:SecondaryAttack()

	if ( not self:CanSecondaryAttack() ) then return end

	self:EmitSound("Weapon_Shotgun.Single")

	self:ShootBullet( 150, 9, 0.2 )

	self:TakeSecondaryAmmo( 1 )

	self.Owner:ViewPunch( Angle( -10, 0, 0 ) )

end ]]

function SWEP:Reload()
    self:DefaultReload(ACT_VM_RELOAD)
end

function SWEP:ShootBullet( damage, num_bullets, aimcone )

	local bullet = {}
	bullet.Num		= num_bullets
	bullet.Src		= self.Owner:GetShootPos()
	bullet.Dir		= self.Owner:GetAimVector()
	bullet.Spread	= Vector( aimcone, aimcone, 0 )
	bullet.Tracer	= 5
	bullet.Force	= 1
	bullet.Damage	= damage
	bullet.AmmoType = "Pistol"

	self.Owner:FireBullets( bullet )

	self:ShootEffects()

end

function SWEP:TakePrimaryAmmo( num )

	if ( self:Clip1() <= 0 ) then

		if ( self:Ammo1() <= 0 ) then return end

		self.Owner:RemoveAmmo( num, self:GetPrimaryAmmoType() )

	return end

	self:SetClip1( self:Clip1() - num )

end

function SWEP:TakeSecondaryAmmo( num )

	if ( self:Clip2() <= 0 ) then

		if ( self:Ammo2() <= 0 ) then return end

		self.Owner:RemoveAmmo( num, self:GetSecondaryAmmoType() )

	return end

	self:SetClip2( self:Clip2() - num )

end

function SWEP:CanPrimaryAttack()

	if ( self:Clip1() <= 0 ) then

		self:EmitSound( "Weapon_Pistol.Empty" )
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		self:Reload()
		return false

	end

	return true

end

function SWEP:CanSecondaryAttack()

	if ( self:Clip2() <= 0 ) then

		self:EmitSound( "Weapon_Pistol.Empty" )
		self:SetNextSecondaryFire( CurTime() + 0.2 )
		return false

	end

	return true

end
