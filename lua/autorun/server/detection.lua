resource.AddWorkshop( "1345205483 " )
resource.AddFile( "sound/eas/eas.mp3" )

local tornado = { "f1", "f2", "f3", "f4", "f5" }
hook.Add("AcceptInput", "tornado", function(ent,input)
	if ent:GetClass() == "info_particle_system" then
		for k, v in pairs(tornado) do
			if string.find(ent:GetName(), v, 1, true) then
				category = string.upper(v)
				if input == "Start" then
					SetGlobalBool("TActive", true)
					SetGlobalString("TCat", "E" .. category .. " Tornado" )
					SetGlobalEntity("TEnt", ent) 
				elseif input == "Stop" then
					SetGlobalBool("TActive", false)
					SetGlobalString("TCat", "Scanning")
					SetGlobalEntity("TEnt", nil)
				end
			end
		end
	end
end)

if gDisasters then
	hook.Add("PostGamemodeLoaded", "GdisastersOverride", function()
		OldCreateTornado = OldCreateTornado or createTornado
		function createTornado(data)
			local ent = OldCreateTornado(data)
			SetGlobalBool("TActive", true)
			SetGlobalString("TCat", ent.Data.Parent.PrintName or "Unknown")
			SetGlobalEntity("TEnt", ent) 
			ent:CallOnRemove( "Reset", function() 
				SetGlobalBool("TActive", false)
				SetGlobalString("TCat", "Scanning")
				SetGlobalEntity("TEnt", nil) 	
			end)
			return ent	
		end
	end)
end