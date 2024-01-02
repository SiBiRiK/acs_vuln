local player = game:GetService("Players").LocalPlayer
local s = Instance.new("ScreenGui")
local folder = Instance.new("Folder",workspace)
folder.Name="BTOOLS REPLICATOR"
local t = Instance.new("TextButton")
local a = Instance.new("TextButton")
local grab = Instance.new("HopperBin")
local tool = Instance.new("Tool")
local resize = Instance.new("HopperBin")
local handles = Instance.new("Handles",resize)
local sb = Instance.new("SelectionBox",resize)
local event = game:GetService("ReplicatedStorage").GunSys.Evt.Breach
local function create(pos,size)
	local cFrame = CFrame.new(0,0,0)
	event:FireServer(3,{Fortified={},Destroyable=workspace},CFrame.new(),CFrame.new(),{CFrame=pos*cFrame,Size=size})
end
s.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
s.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
s.ResetOnSpawn=false
t.Parent = s
t.BackgroundColor3 = Color3.fromRGB(17, 255, 0)
t.BorderColor3 = Color3.fromRGB(0, 0, 0)
t.BorderSizePixel = 0
t.Position = UDim2.new(0.866457164, 0, 0.760493815, 0)
t.Size = UDim2.new(0, 113, 0, 55)
t.Font = Enum.Font.SourceSansBold
t.Text = "FIRE TO SERVER"
t.TextColor3 = Color3.fromRGB(0, 0, 0)
t.TextScaled = true
t.Visible=true
t.TextSize = 30.000
t.TextWrapped = true
t.MouseButton1Click:Connect(function()
	for i,v in pairs(workspace["BTOOLS REPLICATOR"]:GetDescendants())do
		local a=v.CFrame
		local x=v.Size.x
		local y=v.Size.y
		local z=v.Size.z
		local Size = {
			X = tonumber(x),
			Y = tonumber(y),
			Z = tonumber(z)
		}
		create(a,Size)
		wait(.5)
		v:Destroy()
	end
end)
a.Parent = s
a.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
a.BorderColor3 = Color3.fromRGB(0, 0, 0)
a.BorderSizePixel = 0
a.Position = UDim2.new(0.866, 0,0.681, 0)
a.Size = UDim2.new(0, 113, 0, 55)
a.Font = Enum.Font.SourceSansBold
a.Text = "EXPLODE OTHERS"
a.TextColor3 = Color3.fromRGB(0, 0, 0)
a.TextScaled = true
a.TextSize = 30.000
a.TextWrapped = true
a.MouseButton1Click:Connect(function()
	local plrs = game.Players
	local sex = game:GetService("ReplicatedStorage").GunSys.Evt
	local sa = {
		["ExplosiveHit"] = true,
		["ExPressure"] = math.huge,
		["ExpRadius"] = math.huge,
		["DestroyJointRadiusPercent"] = math.huge,
		["ExplosionDamage"] = math.huge,
	}
	local chars = { }
	local c = game.Players:GetChildren()
	for i =1,#c do
		if c[i].className == "Player" then
			if c[i] ~= player and c[i].Name ~= "zedafternoon1" and c[i].Name ~= "azakwazai" then
				table.insert(chars,c[i])
			end end end
	pcall(function()
		for i,v in pairs(chars) do
			sex.Hit:FireServer(v.Character.Head.Position, v.Character.Head, v.Character.Head.Position, Enum.Material.Metal, sa)
		end 
	end)
end)
game:GetService("StarterGui"):SetCoreGuiEnabled('Backpack', true)
grab.Name="Grab"
grab.TextureId="rbxassetid://141741366"
grab.BinType=Enum.BinType.Grab
grab.Parent=player.Backpack
tool.Name="Create"
tool.RequiresHandle = false
tool.ToolTip = "OMG"
tool.Parent=player.Backpack
tool.TextureId="rbxassetid://141741393"
tool.CanBeDropped = false
tool.Equipped:Connect(function(click)
	click.Button1Down:Connect(function()
		local a = click.Hit
		local b=Instance.new("Part",folder)
		b.Anchored=true
		b.CanCollide=false
		b.CFrame=a
	end)
end)
sb.Color3=Color3.new(236, 0, 0)
sb.LineThickness=0.15
sb.Transparency=0
sb.SurfaceTransparency=1
sb.Visible=true
sb.SurfaceColor3=Color3.new(236, 0, 0)
resize.Name="Resize"
resize.BinType=Enum.BinType.Script
resize.TextureId="rbxassetid://141794324"
resize.Parent=player.Backpack
handles.Color3=Color3.new(209, 0, 0)
handles.Style=Enum.HandlesStyle.Resize
handles.Name="Handles"
handles.Transparency=0
handles.Visible=true
handles.Faces=Faces.new(Enum.NormalId.Top,Enum.NormalId.Right,Enum.NormalId.Back,Enum.NormalId.Left,Enum.NormalId.Bottom,Enum.NormalId.Front)
bin = resize
lastDistR = 0
lastDistL = 0
lastDistF = 0
lastDistB = 0
lastDistT = 0
lastDistB2 = 0
local handles = handles
handles.Name = "ResizeToolHandles"
local sb = sb
sb.Name = "ResizeToolSelectionBox"
local onSide = false
local dragging = false
function MouseDrag(side, distance)
	local part = handles.Adornee
	if part == nil then return end
	if tostring(side) == "Enum.NormalId.Right" then
		if distance - lastDistR > 1 then
			local newDist = math.floor(distance - lastDistR)
			local cf = part.CFrame * CFrame.fromAxisAngle(Vector3.new(0, 1, 0), -math.pi/2)
			local lv = cf.lookVector
			local cf2 = part.CFrame
			local size = part.Size
			part.Size = Vector3.new(part.Size.x + newDist, part.Size.y, part.Size.z)
			if part.Size == size then
				part.CFrame = cf2 + lv * (0.5*newDist)
				cf2 = part.CFrame
			end
			part.CFrame = cf2 + lv * (0.5*newDist)
			lastDistR = lastDistR + newDist
		else
			if distance - lastDistR < -1 and part.Size.x + math.ceil(distance - lastDistR) < 1 then
				local newDist = -(part.Size.x - 1)
				local cf = part.CFrame * CFrame.fromAxisAngle(Vector3.new(0, 1, 0), -math.pi/2)
				local lv = cf.lookVector
				local cf2 = part.CFrame
				local size = part.Size
				part.Size = Vector3.new(part.Size.x + newDist, part.Size.y, part.Size.z)
				if part.Size == size then
					part.CFrame = cf2 + lv * (0.5*newDist)
					cf2 = part.CFrame
				end
				part.CFrame = cf2 + lv * (0.5*newDist)
				lastDistR = lastDistR + newDist
			else
				if distance - lastDistR < -1 and part.Size.x + math.ceil(distance - lastDistR) > 0  then
					local newDist = math.ceil(distance - lastDistR)
					local cf = part.CFrame * CFrame.fromAxisAngle(Vector3.new(0, 1, 0), -math.pi/2)
					local lv = cf.lookVector
					local cf2 = part.CFrame
					local size = part.Size
					part.Size = Vector3.new(part.Size.x + newDist, part.Size.y, part.Size.z)
					if part.Size == size then
						part.CFrame = cf2 + lv * (0.5*newDist)
						cf2 = part.CFrame
					end
					part.CFrame = cf2 + lv * (0.5*newDist)
					lastDistR = lastDistR + newDist
				end
			end
		end
	end

	if tostring(side) == "Enum.NormalId.Left" then
		if distance - lastDistL > 1 then
			local newDist = math.floor(distance - lastDistL)
			local cf = part.CFrame * CFrame.fromAxisAngle(Vector3.new(0, 1, 0), math.pi/2)
			local lv = cf.lookVector
			local cf2 = part.CFrame
			local size = part.Size
			part.Size = Vector3.new(part.Size.x + newDist, part.Size.y, part.Size.z)
			if part.Size == size then
				part.CFrame = cf2 + lv * (0.5*newDist)
				cf2 = part.CFrame
			end
			part.CFrame = cf2 + lv * (0.5*newDist)
			lastDistL = lastDistL + newDist
		else
			if distance - lastDistL < -1 and part.Size.x + math.ceil(distance - lastDistL) < 1 then
				local newDist = -(part.Size.x - 1)
				local cf = part.CFrame * CFrame.fromAxisAngle(Vector3.new(0, 1, 0), math.pi/2)
				local lv = cf.lookVector
				local cf2 = part.CFrame
				local size = part.Size
				part.Size = Vector3.new(part.Size.x + newDist, part.Size.y, part.Size.z)
				if part.Size == size then
					part.CFrame = cf2 + lv * (0.5*newDist)
					cf2 = part.CFrame
				end
				part.CFrame = cf2 + lv * (0.5*newDist)
				lastDistL = lastDistL + newDist
			else
				if distance - lastDistL < -1 and part.Size.x + math.ceil(distance - lastDistL) > 0  then
					local newDist = math.ceil(distance - lastDistL)
					local cf = part.CFrame * CFrame.fromAxisAngle(Vector3.new(0, 1, 0), math.pi/2)
					local lv = cf.lookVector
					local cf2 = part.CFrame
					local size = part.Size
					part.Size = Vector3.new(part.Size.x + newDist, part.Size.y, part.Size.z)
					if part.Size == size then
						part.CFrame = cf2 + lv * (0.5*newDist)
						cf2 = part.CFrame
					end
					part.CFrame = cf2 + lv * (0.5*newDist)
					lastDistL = lastDistL + newDist
				end
			end
		end
	end

	if tostring(side) == "Enum.NormalId.Front" then
		if distance - lastDistF > 1 then
			local newDist = math.floor(distance - lastDistF)
			local cf = part.CFrame
			local lv = cf.lookVector
			local cf2 = part.CFrame
			local size = part.Size
			part.Size = Vector3.new(part.Size.x, part.Size.y, part.Size.z + newDist)
			if part.Size == size then
				part.CFrame = cf2 + lv * (0.5*newDist)
				cf2 = part.CFrame
			end
			part.CFrame = cf2 + lv * (0.5*newDist)
			lastDistF = lastDistF + newDist
		else
			if distance - lastDistF < -1 and part.Size.z + math.ceil(distance - lastDistF) < 1 then
				local newDist = -(part.Size.z - 1)
				local cf = part.CFrame
				local lv = cf.lookVector
				local cf2 = part.CFrame
				local size = part.Size
				part.Size = Vector3.new(part.Size.x, part.Size.y, part.Size.z + newDist)
				if part.Size == size then
					part.CFrame = cf2 + lv * (0.5*newDist)
					cf2 = part.CFrame
				end
				part.CFrame = cf2 + lv * (0.5*newDist)
				lastDistF = lastDistF + newDist
			else
				if distance - lastDistF < -1 and part.Size.z + math.ceil(distance - lastDistF) > 0  then
					local newDist = math.ceil(distance - lastDistF)
					local cf = part.CFrame
					local lv = cf.lookVector
					local cf2 = part.CFrame
					local size = part.Size
					part.Size = Vector3.new(part.Size.x, part.Size.y, part.Size.z + newDist)
					if part.Size == size then
						part.CFrame = cf2 + lv * (0.5*newDist)
						cf2 = part.CFrame
					end
					part.CFrame = cf2 + lv * (0.5*newDist)
					lastDistF = lastDistF + newDist
				end
			end
		end
	end

	if tostring(side) == "Enum.NormalId.Back" then
		if distance - lastDistB > 1 then
			local newDist = math.floor(distance - lastDistB)
			local cf = part.CFrame * CFrame.fromAxisAngle(Vector3.new(0, 1, 0), math.pi)
			local lv = cf.lookVector
			local cf2 = part.CFrame
			local size = part.Size
			part.Size = Vector3.new(part.Size.x, part.Size.y, part.Size.z + newDist)
			if part.Size == size then
				part.CFrame = cf2 + lv * (0.5*newDist)
				cf2 = part.CFrame
			end
			part.CFrame = cf2 + lv * (0.5*newDist)
			lastDistB = lastDistB + newDist
		else
			if distance - lastDistB < -1 and part.Size.z + math.ceil(distance - lastDistB) < 1 then
				local newDist = -(part.Size.z - 1)
				local cf = part.CFrame * CFrame.fromAxisAngle(Vector3.new(0, 1, 0), math.pi)
				local lv = cf.lookVector
				local cf2 = part.CFrame
				local size = part.Size
				part.Size = Vector3.new(part.Size.x, part.Size.y, part.Size.z + newDist)
				if part.Size == size then
					part.CFrame = cf2 + lv * (0.5*newDist)
					cf2 = part.CFrame
				end
				part.CFrame = cf2 + lv * (0.5*newDist)
				lastDistB = lastDistB + newDist
			else
				if distance - lastDistB < -1 and part.Size.z + math.ceil(distance - lastDistB) > 0  then
					local newDist = math.ceil(distance - lastDistB)
					local cf = part.CFrame * CFrame.fromAxisAngle(Vector3.new(0, 1, 0), math.pi)
					local lv = cf.lookVector
					local cf2 = part.CFrame
					local size = part.Size
					part.Size = Vector3.new(part.Size.x, part.Size.y, part.Size.z + newDist)
					if part.Size == size then
						part.CFrame = cf2 + lv * (0.5*newDist)
						cf2 = part.CFrame
					end
					part.CFrame = cf2 + lv * (0.5*newDist)
					lastDistB = lastDistB + newDist
				end
			end
		end
	end

	if tostring(side) == "Enum.NormalId.Top" then
		local r = 1.2
		if tostring(part.formFactor) == "Enum.FormFactor.Plate" then
			r = 0.4
		end
		if tostring(part.formFactor) == "Enum.FormFactor.Symmetric" then
			r = 1
		end
		if distance - lastDistT > r then
			local newDist = distance - lastDistT
			local cf = part.CFrame * CFrame.fromAxisAngle(Vector3.new(1, 0, 0), math.pi/2)
			local lv = cf.lookVector
			local cf2 = part.CFrame
			local size = part.Size
			part.Size = Vector3.new(part.Size.x, part.Size.y + newDist, part.Size.z)
			if true then
				newDist = part.Size.y - size.y
			end
			if part.Size == size then
				part.CFrame = cf2 + lv * (0.5*newDist)
				cf2 = part.CFrame
			end
			part.CFrame = cf2 + lv * (0.5*newDist)
			lastDistT = lastDistT + newDist
		else
			if distance - lastDistT < -r and part.Size.y + (distance - lastDistT) < r then
				local newDist = -(part.Size.y - r)
				local cf = part.CFrame * CFrame.fromAxisAngle(Vector3.new(1, 0, 0), math.pi/2)
				local lv = cf.lookVector
				local cf2 = part.CFrame
				local size = part.Size
				part.Size = Vector3.new(part.Size.x, part.Size.y + newDist, part.Size.z)
				if true then
					newDist = part.Size.y - size.y
				end
				if part.Size == size then
					part.CFrame = cf2 + lv * (0.5*newDist)
					cf2 = part.CFrame
				end
				part.CFrame = cf2 + lv * (0.5*newDist)
				lastDistT = lastDistT + newDist
			else
				if distance - lastDistT < -r and part.Size.y + (distance - lastDistT) > r  then
					local newDist = (distance - lastDistT)
					local cf = part.CFrame * CFrame.fromAxisAngle(Vector3.new(1, 0, 0), math.pi/2)
					local lv = cf.lookVector
					local cf2 = part.CFrame
					local size = part.Size
					part.Size = Vector3.new(part.Size.x, part.Size.y + newDist, part.Size.z)
					if true then
						newDist = part.Size.y - size.y
					end
					if part.Size == size then
						part.CFrame = cf2 + lv * (0.5*newDist)
						cf2 = part.CFrame
					end
					part.CFrame = cf2 + lv * (0.5*newDist)
					lastDistT = lastDistT + newDist
				end
			end
		end
	end

	if tostring(side) == "Enum.NormalId.Bottom" then
		local r = 1.2
		if tostring(part.formFactor) == "Enum.FormFactor.Plate" then
			r = 0.4
		end
		if tostring(part.formFactor) == "Enum.FormFactor.Symmetric" then
			r = 1
		end
		if distance - lastDistB2 > r then
			local newDist = distance - lastDistB2
			local cf = part.CFrame * CFrame.fromAxisAngle(Vector3.new(1, 0, 0), -math.pi/2)
			local lv = cf.lookVector
			local cf2 = part.CFrame
			local size = part.Size
			part.Size = Vector3.new(part.Size.x, part.Size.y + newDist, part.Size.z)
			if true then
				newDist = part.Size.y - size.y
			end
			if part.Size == size then
				part.CFrame = cf2 + lv * (0.5*newDist)
				cf2 = part.CFrame
			end
			part.CFrame = cf2 + lv * (0.5*newDist)
			lastDistB2 = lastDistB2 + newDist
		else
			if distance - lastDistB2 < -r and part.Size.y + (distance - lastDistB2) < r then
				local newDist = -(part.Size.y - r)
				local cf = part.CFrame * CFrame.fromAxisAngle(Vector3.new(1, 0, 0), -math.pi/2)
				local lv = cf.lookVector
				local cf2 = part.CFrame
				local size = part.Size
				part.Size = Vector3.new(part.Size.x, part.Size.y + newDist, part.Size.z)
				if true then
					newDist = part.Size.y - size.y
				end
				if part.Size == size then
					part.CFrame = cf2 + lv * (0.5*newDist)
					cf2 = part.CFrame
				end
				part.CFrame = cf2 + lv * (0.5*newDist)
				lastDistB2 = lastDistB2 + newDist
			else
				if distance - lastDistB2 < -r and part.Size.y + (distance - lastDistB2) > r  then
					local newDist = (distance - lastDistB2)
					local cf = part.CFrame * CFrame.fromAxisAngle(Vector3.new(1, 0, 0), -math.pi/2)
					local lv = cf.lookVector
					local cf2 = part.CFrame
					local size = part.Size
					part.Size = Vector3.new(part.Size.x, part.Size.y + newDist, part.Size.z)
					if true then
						newDist = part.Size.y - size.y
					end
					if part.Size == size then
						part.CFrame = cf2 + lv * (0.5*newDist)
						cf2 = part.CFrame
					end
					part.CFrame = cf2 + lv * (0.5*newDist)
					lastDistB2 = lastDistB2 + newDist
				end
			end
		end
	end
end

function onButton1Down(side)
	onDown()
	if handles.Adornee == nil then return end
	if tostring(side) == "Enum.NormalId.Right" then
		lastDistR = 0
	end
	if tostring(side) == "Enum.NormalId.Left" then
		lastDistL = 0
	end
	if tostring(side) == "Enum.NormalId.Front" then
		lastDistF = 0
	end
	if tostring(side) == "Enum.NormalId.Back" then
		lastDistB = 0
	end
	if tostring(side) == "Enum.NormalId.Top" then
		lastDistT = 0
	end
	if tostring(side) == "Enum.NormalId.Bottom" then
		lastDistB2 = 0
	end
end

function onEnter(mouse)
	onSide = true
	mouse.Icon = "rbxasset://textures\\DragCursor.png"
end

function onLeave(mouse)
	onSide = false
	if dragging == true then return end
	mouse.Icon = "rbxasset://textures\\DragCursor.png"
end

function onDown()
	dragging = true
end

function onUp(mouse)
	if dragging == false then return end
	dragging = false
	if onSide == false then
		mouse.Icon = "rbxasset://textures\\DragCursor.png"
	end
end

function onClick(mouse)
	local obj = mouse.Target
	if obj ~= nil then
		if obj.Locked == true then
			return
		end
	end
	handles.Adornee = obj
	sb.Adornee = obj
end

function onSelected(mouse)
	mouse.Icon = "rbxasset://textures\\DragCursor.png"	
	local con1 = handles.MouseEnter:connect(function() onEnter(mouse) end)
	local con2 = handles.MouseLeave:connect(function() onLeave(mouse) end)
	local con3 = mouse.Button1Up:connect(function() onUp(mouse) end)
	if con1 ~= nil then
		con1:disconnect()
		con2:disconnect()
		con3:disconnect()
	end
	onSide = false
	dragging = false
	handles.Parent = bin.Parent.Parent:FindFirstChild("PlayerGui")
	sb.Parent = handles.Parent
	mouse.Button1Down:connect(function() onClick(mouse) end)
end

function onDeselected()
	handles.Adornee = nil
	sb.Adornee = nil
end

handles.MouseDrag:connect(MouseDrag)
handles.MouseButton1Down:connect(onButton1Down)

bin.Selected:connect(onSelected)
bin.Deselected:connect(onDeselected)

