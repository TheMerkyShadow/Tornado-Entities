include('shared.lua')

function ENT:Draw()

	self:DrawModel()
	
	if self:GetPos():Distance(LocalPlayer():GetPos()) >= 500 then return end

	local position = self:LocalToWorld( Vector( 6.5, -28, 35 ) )
	local angles = self:LocalToWorldAngles( Angle(0,90,90) )

	cam.Start3D2D(position, angles, 0.1)
		surface.SetDrawColor(0, 0, 0)
		surface.DrawRect(0, 0, 565, 330)
		draw.Eas( self, angles )
	cam.End3D2D()
	
	--WaterMark

	cam.Start3D2D(self:LocalToWorld( Vector( -0.1, 29, 55 ) ), self:LocalToWorldAngles( Angle(0,270,90) ), 0.1)
		draw.SimpleTextOutlined( "Created By TheMerkyShadow", "DebugFixedSmall", 282, 300, Color(0,0,255), 1, 1, 1, color_black)	
	cam.End3D2D()
	
end

function draw.Eas(self,angles)

	local originX = 170
	local originY = 150	
						
	surface.DrawCircle( originX, originY, 5, Color( 0, 100, 0 ) )	
	surface.DrawCircle( originX, originY, 25, Color( 0, 100, 0 ) )					
	surface.DrawCircle( originX, originY, 50, Color( 0, 100, 0 ) )			
	surface.DrawCircle( originX, originY, 75, Color( 0, 100, 0 ) )	
	surface.DrawCircle( originX, originY, 100, Color( 0, 100, 0 ) )
	surface.DrawCircle( originX, originY, 125, Color( 0, 100, 0 ) )
	
	if self.ValidTornado then
	
		angle = ( self.Tornado:GetPos() - self:GetPos() )
		angle = ( angle:Angle() - angles )
		angle = math.rad( angle.Yaw )
	
		local range = 15000
		radius = math.Clamp( (self.Distance/range)*125,0,125)
	
		X = math.cos( -angle ) * radius + originX
		Y = math.sin( -angle ) * radius + originY 
				
		surface.DrawLine( originX, originY, X, Y )
		draw.SimpleText( "Distance: " .. self.Distance, "DermaDefault", 420, 200, color_white, 1, 1)
		
	end
	
	draw.SimpleText( self.Category, "DermaLarge", 420, 135, Color( 255, 0, 0, 255 ), 1, 1)

end
