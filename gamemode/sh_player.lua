local meta = FindMetaTable("Player")
function meta:SetBalance()
	self:SetNetworkedInt( "Balance", amount )
	self:SaveMoney()
end
function meta:GetBalance()
	return self:GetNetworkedInt( "Balance" )
end
function meta:AddBalance(amount)
	local current_cash = self:GetMoney()
	self:SetMoney( current_cash + amount )
end
function meta:TakeBalance(amount)
    self:AddMoney(-amount)
end
function meta:DropBalance(amount)

end
