local meta = FindMetaTable("Player")
function meta:SetBalance()
	self:SetNetworkedInt( "Balance", amount )
	self:SaveBalance()
end
function meta:GetBalance()
	return self:GetNetworkedInt( "Balance" )
end
function meta:AddBalance(amount)
	local currentBalance = self:GetMoney()
	self:SetBalance( currentBalance + amount )
end
function meta:TakeBalance(amount)
    self:AddMoney(-amount)
end
function meta:DropBalance(amount)

end
