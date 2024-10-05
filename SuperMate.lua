SuperMate = CreateFrame("Frame", nil, nil)  
SuperMate:RegisterEvent("UNIT_CASTEVENT")
SuperMate.ifCasting=0
SuperMate.CastState=nil

SuperMate:SetScript("OnEvent", function()
	if not SetAutoloot then
		DEFAULT_CHAT_FRAME:AddMessage("Need SuperWoW.")
		return
	end
    if event == "UNIT_CASTEVENT" then
		b,i=UnitExists("target")
		if i==arg2 and arg3=="START" then
			--DEFAULT_CHAT_FRAME:AddMessage("exist target:"..tostring(b).."----target id:"..tostring(i).."target:"..tostring(arg2).."cast state:"..tostring(arg3))
			SuperMate.ifCasting=1
			SuperMate.CastState=arg3
		else
			SuperMate.ifCasting=0
			SuperMate.CastState=nil
		end

	end
end)
