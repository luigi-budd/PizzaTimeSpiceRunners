// TODO: Make DoLapBonus not call ChatLapStatus, and seperately use them when they're needed.

PTSR.ChatLapStatus = function(player)
	local lapstring = "\x82\*LAP ".. player.ptsr.laps.. " ("..player.name.." "..G_TicsToMTIME(player.ptsr.laptime, true)..")"
	local isonconsole = CV_PTSR.lapbroadcast_type.value == 1
	local isonchat = CV_PTSR.lapbroadcast_type.value == 2

	if isonconsole then
		print(lapstring)
	elseif isonchat then
		chatprint(lapstring, true)
	end
end

PTSR.DoLapBonus = function(player)
	local gm_metadata = PTSR.currentModeMetadata()
	
	PTSR.ChatLapStatus(player)
	
	if player.ptsr.laps ~= nil then
		local escapebonus = true
		
		local lapbonus = player.ptsr.laps * (gm_metadata.lapbonus or PTSR.lapbonus)
		local ringbonus = player.rings * (gm_metadata.ringlapbonus or PTSR.ringlapbonus)
		local combobonus = player.ptsr.combo_count * (gm_metadata.combobonus or PTSR.combobonus)
		
		if PTSR_DoHook("onbonus", player) == true then
			escapebonus = false
		end
		
		if PTSR_DoHook("onlapbonus", player) == true then
			lapbonus = 0
		end
		
		if PTSR_DoHook("onringbonus", player) == true then
			ringbonus = 0
		end
		
		-- This might get deleted later. TODO: Remove this comment if this stays in final release
		if PTSR_DoHook("oncombobonus", player) == true then
			ringbonus = 0
		end
		
		if escapebonus then
			P_AddPlayerScore(player, lapbonus + ringbonus ) -- Bonus!
			if lapbonus or ringbonus then
				CONS_Printf(player, "** Lap "..player.ptsr.laps.." bonuses **")
			end
			
			if lapbonus then
				CONS_Printf(player, "* "..lapbonus.." point lap bonus!")
			end
			
			if ringbonus then
				CONS_Printf(player, "* "..ringbonus.." point ring bonus!")
			end
			
			if combobonus then
				CONS_Printf(player, "* "..combobonus.." combo bonus!")
			end
		end
	end
end