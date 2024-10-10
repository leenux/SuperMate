SuperMate = CreateFrame("Frame", nil, nil)  
SuperMate:RegisterEvent("UNIT_CASTEVENT")

local SM = {};
SM.ifCasting=0
SM.CastState=nil
SM.spellID = 0
SM.dura = 0
SM.defaultDura = 2500

SuperMate:SetScript("OnEvent", function()
	if not SetAutoloot then
		DEFAULT_CHAT_FRAME:AddMessage("Need SuperWoW.")
		return
	end
	if event == "UNIT_CASTEVENT" then
		b,i=UnitExists("target")
		if i==arg2 then
			if arg3=="START" then
				--DEFAULT_CHAT_FRAME:AddMessage("cast state:"..tostring(arg3).." -spellID:"..tostring(arg4).." -dura:"..tostring(arg5))
				SM.spellID = arg4
				SM.dura = arg5
				SM.ifCasting=1
				SM.CastState=arg3
			else
				SM.ifCasting=0
				SM.CastState=nil
				SM.spellID = 0
				SM.dura = 0
			end
		end

	end
end)

function SM_IsCastingIncludeName(SpellName)
	if SM.spellID == 0 or SM.dura == 0 then
		return false
	end
	sname = SpellInfo(SM.spellID)
	--DEFAULT_CHAT_FRAME:AddMessage("-SpellName-:"..sname)
	if SpellName ~= nil then
		if string.find(sname, SpellName) ~= nil and SM.dura > SM.defaultDura then
			--DEFAULT_CHAT_FRAME:AddMessage(sname.."-include- "..SpellName)
			return true
		end
	else
		if SM.dura > SM.defaultDura then
			return true
		end
	end
	return false
end

function SM_ifCastingTime(Dura)
	if SM.spellID == 0 or SM.dura == 0 then
		--DEFAULT_CHAT_FRAME:AddMessage("id dura 0")
		return false
	end
	if Dura == nil then
		Dura = SM.defaultDura
	end
	if SM.dura > Dura then
		return true
	end
	return false
end


function SM.IdAndNameFromLink(link)
	local name
	if (not link) then
		return ""
	end
	for id, name in string.gfind(link, "|c%x+|Hitem:(%d+):%d+:%d+:%d+|h%[(.-)%]|h|r$") do
		return tonumber(id), name
	end
	return nil
end

function SM_IsEquipped(item)
	local itemId
	local itemName
	if (string.find(item, '^%d')) then
		itemId = tonumber(item)
	else
		itemName = item
	end
	for slot = 0, 19 do
		local link = GetInventoryItemLink("player", slot)
		if (link) then
			local id, name = SM.IdAndNameFromLink(link)
			if (id) then
				if ((itemId and id == itemId)) then
					return true
				elseif (itemName) then
					if string.lower(name) == string.lower(itemName) then
						return true
					end
				end
			end
		end
	end
	return false
end

function SM_ItemCD(name) 
	local cooldown = Roids.GetInventoryCooldownByName(name); 
	if not cooldown then 
		cooldown = Roids.GetContainerItemCooldownByName(name) 
	end 
	return cooldown > 0
end