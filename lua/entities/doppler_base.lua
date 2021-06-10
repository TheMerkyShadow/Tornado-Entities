AddCSLuaFile()
if not WireLib then return end

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.Spawnable = false
ENT.AdminOnly = false

ENT.Sound = Sound("eas/eas.mp3")

if SERVER then
	function ENT:Initialize()
		if self.OutputWire then
			self.Outputs = WireLib.CreateOutputs(self,{ "Active", "Category [STRING]", "Distance", "Tornado [ENTITY]" })
		end
	end
end

function ENT:Think()
	self.Active = GetGlobalBool("TActive")
	self.Category = GetGlobalString("TCat", "Scanning" )
	self.Tornado = GetGlobalEntity("TEnt")
	self.ValidTornado = (self.Active and IsValid(self.Tornado))
	self.Distance = 0
	if self.ValidTornado then 
		self.Distance = math.Round( self:GetPos():Distance(self.Tornado:GetPos()) )
	end
	if SERVER then
		if self.OutputWire then
			WireLib.TriggerOutput(self, "Active", self.Active )
			WireLib.TriggerOutput(self, "Category", self.Category )
			WireLib.TriggerOutput(self, "Distance", self.Distance )
			WireLib.TriggerOutput(self, "Tornado", self.Tornado )
		end
		if self.Sound then
			if self.ValidTornado and self.PlaySound then
				self:EmitSound( self.Sound )
				self.PlaySound = false			
			elseif not self.ValidTornado then
				self.PlaySound = true	
			end
		end
	end
end
