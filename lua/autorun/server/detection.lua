resource.AddWorkshop( "1345205483" )

local tornado = { "f1", "f2", "f3", "f4", "f5" }
hook.Add("AcceptInput", "tornado", function(ent,input)
	if ent:GetClass() == "info_particle_system" then
		for k, v in pairs(tornado) do
			if string.find(ent:GetName(), v, 1, true) then
				category = string.upper(v)
				if input == "Start" then
					SetGlobalInt("TActive", 1)
					SetGlobalString("TCat", "E" .. category .. " Tornado" )
					SetGlobalEntity("TEnt", ent:GetParent() ) 
				elseif input == "Stop" then
					SetGlobalInt("TActive", 0)
					SetGlobalString("TCat", "Scanning")
					SetGlobalEntity("TEnt", NULL )
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
			SetGlobalInt("TActive", 1)
			SetGlobalString("TCat", ent.Data.Parent.PrintName or "Unknown")
			SetGlobalEntity("TEnt", ent) 
			ent:CallOnRemove( "Reset", function() 
				SetGlobalInt("TActive", 0)
				SetGlobalString("TCat", "Scanning")
				SetGlobalEntity("TEnt", NULL ) 	
			end)
			return ent	
		end
	end)
end
