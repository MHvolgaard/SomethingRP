local meta = FindMetaTable("Player")
-- BALANCE SYSTEM
function meta:SetBalance(amount)
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
    self:AddBalance(-amount)
end
function meta:DropBalance(amount)
	--Ikke udviklet
end
function meta:SaveBalance()
	local balance = self:GetBalance()
	self:SetPData("Balance", balance)
end
-- JOB SYSTEM
function meta:SetJob(jobName)
	self:SetNetworkedString("Job", jobName)
end
function meta:GetJob()
	return self:GetNetworkedString("Job")
end
function meta:SetJobDescription(jobDescription)

end
function meta:GetJobDescription()
	
end

-- ALIAS SYSTEM
function meta:SetAlias(alias)
	self:SetNetworkedString("Alias", alias)
	self:SaveAlias()
end
function meta:GetAlias()
	return self:GetNetworkedString("Alias")
end
function meta:SaveAlias(alias)
	local alias = self:GetAlias()
	self:SetPData("Alias", alias)
end

-- STAMINA
function meta:GetStamina()
	self:GetNetworkedInt("Stamina")
end
function meta:SetStamina(stamina)
	self:SetNetworkedInt("Stamina", stamina)
end
