SuperMate = CreateFrame("Frame", nil, nil)  

SuperMate:RegisterEvent("UNIT_CASTEVENT")

local SM = {};
SM.spellID = 0
SM.dura = 0
SM.defaultDura = 2500
SM.targetID = 0

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
				SM.targetID = arg2
			else
				SM.spellID = 0
				SM.dura = 0
				SM.targetID = 0
			end
		end

	end
end)

SuperMate.IsCastingIncludeName = function(SpellName)
	b,i=UnitExists("target")
	if not b or SM.spellID == 0 or SM.dura == 0 or i~= SM.targetID then
		return false
	end
	local sname = SpellInfo(SM.spellID)
	local sub = SpellName or ""
	--DEFAULT_CHAT_FRAME:AddMessage("-SpellName-:"..sname)
	if string.find(sname, sub) ~= nil and SM.dura > SM.defaultDura then
		--DEFAULT_CHAT_FRAME:AddMessage(sname.."-include- "..sub)
		return true
	end
	return false
end

SuperMate.ifCastingTime = function(Dura)
	b,i=UnitExists("target")
	if not b or SM.spellID == 0 or SM.dura == 0 or i~= SM.targetID then
		return false
	end
	local d = Dura or SM.defaultDura
	if SM.dura > Dura then
		return true
	end
	return false
end

SuperMate.IsMoving = false;
SuperMate.m_vCurrPos = {};

SuperMate.m_vLastPos = {};
SuperMate.m_vLastPos.x, SuperMate.m_vLastPos.y = GetPlayerMapPosition("player");

SuperMate:SetScript("OnUpdate", function()
	SuperMate.m_vCurrPos.x, SuperMate.m_vCurrPos.y = GetPlayerMapPosition("player");
	SuperMate.m_vCurrPos.x = SuperMate.m_vCurrPos.x + 0.0;
	SuperMate.m_vCurrPos.y = SuperMate.m_vCurrPos.y + 0.0;
	
	if (SuperMate.m_vCurrPos.x) then
		local dist;
		
		-- travel speed ignores Z-distance (i.e. you run faster up or down hills)	
		-- x and y coords are not square, had to weight the x by 2.25 to make the readings match the y axis.
		dist = math.sqrt(
				((SuperMate.m_vLastPos.x - SuperMate.m_vCurrPos.x) * (SuperMate.m_vLastPos.x - SuperMate.m_vCurrPos.x) * 2.25 ) +
				((SuperMate.m_vLastPos.y - SuperMate.m_vCurrPos.y) * (SuperMate.m_vLastPos.y - SuperMate.m_vCurrPos.y)));
		
		if (dist > 0) then
			SuperMate.IsMoving = true;		
		else
			SuperMate.IsMoving = false;
		end

		SuperMate.m_vLastPos.x = SuperMate.m_vCurrPos.x;
		SuperMate.m_vLastPos.y = SuperMate.m_vCurrPos.y;
		SuperMate.m_vLastPos.z = SuperMate.m_vCurrPos.z;
	end
end)

local function MonkeySpeed_Round(x)
	if(x - floor(x) > 0.5) then
		x = x + 0.5;
	end
	return floor(x);
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

SuperMate.IsEquipped = function(item)
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
