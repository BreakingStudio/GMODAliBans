if CLIENT then

net.Receive( "AliBanMenu", function( len, ply )
if(LocalPlayer():IsSuperAdmin()) then
local Frame = vgui.Create( "DFrame" )
Frame:SetSize( 300, 200 )
Frame:SetTitle( "연합벤 시스템" )
Frame:SetVisible( true )
Frame:SetDraggable( true )
Frame:ShowCloseButton( true )
Frame:MakePopup()
	
local DermaButton = vgui.Create( "DButton", Frame )
DermaButton:SetText( "연합벤 목록 업데이트" )
DermaButton:SetPos( 25, 50 )
DermaButton:SetSize( 250, 30 )
DermaButton.DoClick = function()	
	RunConsoleCommand("aliban_update")
end

local DermaButton = vgui.Create( "DButton", Frame )
DermaButton:SetText( "연합벤 홈페이지" )
DermaButton:SetPos( 25, 100 )
DermaButton:SetSize( 250, 30 )
DermaButton.DoClick = function()	
	gui.OpenURL( "https://goo.gl/opVL5a" )
end

local TextEntry = vgui.Create( "DTextEntry", Frame ) -- create the form as a child of frame
TextEntry:SetPos( 25, 150 )
TextEntry:SetSize( 250, 30 )
TextEntry:SetText( net.ReadString())
TextEntry.OnEnter = function( self )
	chat.AddText( self:GetValue() )	-- print the form's text as server text
end

else
return false
end
end)
end
