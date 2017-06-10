AliBansConfig = {}
local Config = AliBansConfig
Config.Version = "1.0" --연합벤 현재 버전
Config.Commander = "!연합벤" --연합벤 메뉴 명령어


if SERVER then
util.AddNetworkString( "AliBanMenu" )
    print("[AliBans] AliBan System Loaded")
	banlist = {}
	content = ""
	local url = "https://goo.gl/zprHvJ"
	
	function check()
	http.Fetch(url, function(html)
			banlist = string.Explode("|",html)
			content = html
			if(banlist[1] > Config.Version) then
			print("[AliBans] Please update aliban addon!")

			for k, v in pairs(player.GetAll()) do
				v:PrintMessage( HUD_PRINTTALK, "[AliBans] 새로운 업데이트가 있습니다!" )
			end

			end
			
			for k, v in pairs(player.GetAll()) do
				v:PrintMessage( HUD_PRINTTALK, "[AliBans] 데이터베이스 업데이트 완료!" )
			end
		    print("Complete updating aliban list")
	end)
	end
	
	function usercheck()
			for k, v in pairs(player.GetAll()) do
				for _,ban in pairs(banlist) do
					if ban == v:SteamID() then
					    kickuser(v)
					end
				end
			end
	end
	
	function aliget(v)
	usercheck()
				for _,ban in pairs(banlist) do
					if ban == v:SteamID() then
					     kickuser(v)
					end
				end
	end
	
             function kickuser(v)
             	 print("Kick " .. v:Nick() .. " by AliBans")
             	user:Kick("[AliBans] 연합벤 사유: https://goo.gl/opVL5a")
             	for k, v in pairs(player.GetAll()) do
				v:PrintMessage( HUD_PRINTTALK, user:Nick() .. " 님이 연합벤 시스템에 의해 차단당했습니다!")
		end
             end

	function init()
	check()
	timer.Create("UpdateAlibanList", 120 , 0, check)
	print("[AliBans] Initialize AliBan System")
	end
	
	hook.Add( "PlayerInitialSpawn", "CheckUsers", aliget )
	hook.Add( "Initialize", "InitializeAliBans", init )
	
	concommand.Add( "aliban_update", function( ply, cmd, args )
	if(ply:IsSuperAdmin()) then
	check()
	else
	return false
	end
end )


	hook.Add( "PlayerSay", "AliBanMenu", function( ply, text, public )
	if ( text == Config.Commander ) then
	if(ply:IsSuperAdmin()) then
	net.Start( "AliBanMenu" )
	net.WriteString(content)
    net.Send(ply)
	else
	return false
	end
	end
	end)
end
