PTSR.ReturnPizzaTimeMusic = function()

	local song = mapmusname
	local songdata = {}

	songdata["It's Pizza Time!"] = 'PIZTIM'
	songdata["The Death That I Deservioli"] = 'DEAOLI'
	songdata["Pillar John's Revenge"] = 'PIJORE'
	songdata["Gluten Getaway"] = 'GLUWAY'
	songdata["Pasta La Vista"] = 'PASTVI'

	if PTSR.pizzatime and consoleplayer and consoleplayer.valid then
		if consoleplayer.ptsr.laps == 2 then
			song = "The Death That I Deservioli"
		elseif consoleplayer.ptsr.laps == 3 then
			song = "Pillar John's Revenge"
		elseif consoleplayer.ptsr.laps == 4 then
			song = "Gluten Getaway"
		elseif consoleplayer.ptsr.laps >= 5 then
			song = "Pasta La Vista"
		else
			if consoleplayer.ptsr.laps <= 1 then
				song = "It's Pizza Time!"
			end
		end
	end

	// modding check here

	return songdata[song] or 'PIZTIM'
end