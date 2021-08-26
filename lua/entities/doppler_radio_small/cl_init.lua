include('shared.lua')

function ENT:Draw()

	self:DrawModel()
	
	if self:GetPos():Distance(LocalPlayer():GetPos()) >= 500 then return end

	local position = self:LocalToWorld( Vector( -2.8, 9.9, 9.5 ) )
	local angles = self:LocalToWorldAngles( Angle(0,270,90) )

	cam.Start3D2D(position, angles, 0.035)
		draw.SimpleTextOutlined( "Created By TheMerkyShadow", "GModNotify", 282, 300, Color(0,0,255), 1, 1, 1, color_black)	
	cam.End3D2D()
	
end