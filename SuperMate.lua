SuperMate = CreateFrame("Frame", nil, nil)  

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

