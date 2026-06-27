-==================================================
-- PAINEL DO NINJA | AIMBOT + ESP FUNCIONAL + ESQUELETO
--==================================================

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local LoadGui = Instance.new("ScreenGui", game.CoreGui)
LoadGui.IgnoreGuiInset = true
LoadGui.ResetOnSpawn = false
LoadGui.DisplayOrder = 999999999 -- 🔥 PRIORIDADE MÁXIMA

local function NewL(i,p)
	local o = Instance.new(i)
	for k,v in pairs(p) do o[k]=v end
	return o
end

local Bg = NewL("ImageLabel",{
	Size = UDim2.new(1,0,1,0),
	Image = "rbxassetid://86174967937156",
	BackgroundTransparency = 0,
	ImageTransparency = 0,
	ZIndex = 1000,
	Parent = LoadGui
})

NewL("Frame",{
	Size=UDim2.new(1,0,1,0),
	BackgroundColor3=Color3.new(0,0,0),
	BackgroundTransparency=0.45,
	ZIndex = 1001,
	Parent=Bg
})

local Title = NewL("TextLabel",{
	Size=UDim2.new(1,0,0,80),
	Position = UDim2.new(0,0,0.1,5,0),
	Text="PORTUGA XITER",
	TextColor3=Color3.fromRGB(255,0,0),
	BackgroundTransparency=1,
	Font=Enum.Font.GothamBlack,
	TextScaled=true,
	ZIndex = 1002,
	Parent=Bg
})

local Percent = NewL("TextLabel",{
	Size=UDim2.new(1,0,0,50),
	Position=UDim2.new(0,0,0.75,0),
	Text="Carregando... 0%",
	TextColor3=Color3.new(1,1,1),
	BackgroundTransparency=1,
	Font=Enum.Font.GothamBold,
	TextScaled=true,
	ZIndex = 1002,
	Parent=Bg
})

local BarBG = NewL("Frame",{
	Size=UDim2.new(0.5,0,0,20),
	Position=UDim2.new(0.25,0,0.70,0),
	BackgroundColor3=Color3.fromRGB(30,30,30),
	BorderSizePixel=0,
	ZIndex = 1002,
	Parent=Bg
})
Instance.new("UICorner",BarBG).CornerRadius=UDim.new(0,10)

local Bar = NewL("Frame",{
	Size=UDim2.new(0,0,1,0),
	BackgroundColor3=Color3.fromRGB(255,0,0),
	BorderSizePixel=0,
	ZIndex = 1003,
	Parent=BarBG
})
Instance.new("UICorner",Bar).CornerRadius=UDim.new(0,10)

task.spawn(function()
	for i=1,100 do
		Percent.Text = "Carregando... "..i.."%"
		TweenService:Create(Bar, TweenInfo.new(0.02), {
			Size = UDim2.new(i/100,0,1,0)
		}):Play()
		task.wait(0.02)
	end

	Percent.Text = "INJETADO COM SUCESSO"
	task.wait(0.5)

	LoadGui:Destroy()
end)


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local VIM = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local KEY = "portuga_xiter"
local NINJA_ID = 6091965593

--================ STATES =================
local S = {
	Aimbot=false,
	AutoFire=false,
	ESP_Lines=false,
	Night=false,
	Noclip=false,
	AimbotRival=false,
}

local AIM_PART = "Head"
local FOV_RADIUS = 160
local currentTarget = nil

--================ GUI =================
local Gui = Instance.new("ScreenGui", game.CoreGui)
Gui.ResetOnSpawn=false
Gui.IgnoreGuiInset=true

local function New(i,p)
	local o = Instance.new(i)
	for k,v in pairs(p) do o[k]=v end
	return o
end



--================ KEY PANEL =================
local KeyF = New("Frame",{
	Size=UDim2.new(0,400,0,200),
	Position=UDim2.new(.5,-200,.5,-100),
	BackgroundColor3=Color3.fromRGB(15,15,15),
	Active=true,Draggable=true,
	Parent=Gui
})

New("TextLabel",{
	Size=UDim2.new(1,0,0,40),
	Text="Painel do portuga",
	TextColor3=Color3.new(1,1,1),
	BackgroundTransparency=1,
	Font=Enum.Font.GothamBlack,
	TextSize=20,
	Parent=KeyF
})

local KeyBox = New("TextBox",{
	Size = UDim2.new(.8,0,0,40),
	Position = UDim2.new(.1,0,.4,0),

	Text = "", -- IMPORTANTE
	PlaceholderText = "Digite a key aqui",
	ClearTextOnFocus = false,

	BackgroundColor3 = Color3.fromRGB(25,25,25),
	TextColor3 = Color3.new(1,1,1),
	Font = Enum.Font.Gotham,
	TextSize = 16,

	Parent = KeyF
})


local Confirm = New("TextButton",{
	Size=UDim2.new(.5,0,0,35),
	Position=UDim2.new(.25,0,.7,0),
	Text="CONFIRMAR",
	BackgroundColor3=Color3.fromRGB(150,0,0),
	TextColor3=Color3.new(1,1,1),
	Parent=KeyF
})

--================ ERRO DE KEY =================
local function KeyErrada()
	local f = New("Frame",{
		Size=UDim2.new(0,420,0,120),
		Position=UDim2.new(0.5,-210,0.5,-60),
		BackgroundColor3=Color3.fromRGB(10,10,10),
		BorderColor3=Color3.fromRGB(180,0,0),
		BorderSizePixel=3,
		Parent=Gui
	})
	New("TextLabel",{
		Size=UDim2.new(1,-20,1,-20),
		Position=UDim2.new(0,10,0,10),
		Text="Você errou a key seu fracassado!!!",
		TextColor3=Color3.fromRGB(255,0,0),
		BackgroundTransparency=1,
		Font=Enum.Font.GothamBlack,
		TextSize=20,
		TextWrapped=true,
		Parent=f
	})
	task.delay(3,function() f:Destroy() end)
end

--================ MAIN PANEL =================
local Main = New("Frame",{
	Size=UDim2.new(0,520,0,380),
	Position=UDim2.new(.5,-260,.5,-190),
	BackgroundColor3=Color3.fromRGB(10,10,10),
	Visible=false,
	Active=true,Draggable=true,
	Parent=Gui
})

-- FECHAR
local Close = New("TextButton",{
	Size=UDim2.new(0,30,0,30),
	Position=UDim2.new(1,-35,0,5),
	Text="X",
	BackgroundColor3=Color3.fromRGB(180,0,0),
	TextColor3=Color3.new(1,1,1),
	Parent=Main
})
Close.MouseButton1Click:Connect(function() Gui:Destroy() end)

-- MINIMIZAR
local Min = New("TextButton",{
	Size=UDim2.new(0,30,0,30),
	Position=UDim2.new(1,-70,0,5),
	Text="-",
	BackgroundColor3=Color3.fromRGB(80,80,80),
	TextColor3=Color3.new(1,1,1),
	Parent=Main
})
local minimized=false
Min.MouseButton1Click:Connect(function()
	minimized = not minimized
	Main.Size = minimized and UDim2.new(0,200,0,40) or UDim2.new(0,520,0,380)
end)

UIS.InputBegan:Connect(function(i,g)
	if g then return end
	if i.KeyCode==Enum.KeyCode.L then
		Main.Visible = not Main.Visible
	end
end)

--================ SCROLL =================
local Scroll = New("ScrollingFrame",{
	Size=UDim2.new(1,-10,1,-50),
	Position=UDim2.new(0,5,0,45),
	CanvasSize=UDim2.new(0,0,0,0),
	Parent=Main
})
local UIList = Instance.new("UIListLayout",Scroll)
UIList.Padding = UDim.new(0,6)
UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	Scroll.CanvasSize = UDim2.new(0,0,0,UIList.AbsoluteContentSize.Y+10)
end)

local function Toggle(name,cb)
	local on=false
	local b = New("TextButton",{
		Size=UDim2.new(1,-10,0,35),
		Text=name.." [DESATIVADO]",
		BackgroundColor3=Color3.fromRGB(140,0,0),
		TextColor3=Color3.new(1,1,1),
		Parent=Scroll
	})
	b.MouseButton1Click:Connect(function()
		on = not on
		b.Text = name..(on and " [ATIVADO]" or " [DESATIVADO]")
		b.BackgroundColor3 = on and Color3.fromRGB(0,150,0) or Color3.fromRGB(140,0,0)
		cb(on)
	end)
end

--================ NOCLIP =================
RunService.Stepped:Connect(function()
	if not S.Noclip then return end
	if LocalPlayer.Character then
		for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)
Toggle("Noclip", function(v)
	S.Noclip = v
end)


--================ FLY =================
local FlyBV, FlyBG
local FlySpeed = 3

local function StartFly()
	local char = LocalPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	FlyBV = Instance.new("BodyVelocity")
	FlyBV.Velocity = Vector3.zero
	FlyBV.MaxForce = Vector3.new(9e9,9e9,9e9)
	FlyBV.Parent = hrp

	FlyBG = Instance.new("BodyGyro")
	FlyBG.MaxTorque = Vector3.new(9e9,9e9,9e9)
	FlyBG.CFrame = hrp.CFrame
	FlyBG.Parent = hrp

	RunService.RenderStepped:Connect(function()
		if not S.Fly or not hrp then return end

		local cam = Camera.CFrame
		local move = Vector3.zero

		if UIS:IsKeyDown(Enum.KeyCode.W) then move += cam.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then move -= cam.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then move -= cam.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then move += cam.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then move += cam.UpVector end
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move -= cam.UpVector end

		FlyBV.Velocity = move * (FlySpeed * 50)
		FlyBG.CFrame = cam
	end)
end

local function StopFly()
	if FlyBV then FlyBV:Destroy() FlyBV=nil end
	if FlyBG then FlyBG:Destroy() FlyBG=nil end
end

Toggle("Fly", function(v)
	S.Fly = v
	if v then
		StartFly()
	else
		StopFly()
	end
end)


--================ FUNÇÕES =================
local function IsAlive(c)
	local h=c and c:FindFirstChildOfClass("Humanoid")
	return h and h.Health>0
end

local function HasLOS(char)
	local part = char:FindFirstChild(AIM_PART)
	if not part then return false end
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Blacklist
	params.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
	local r = workspace:Raycast(Camera.CFrame.Position, part.Position - Camera.CFrame.Position, params)
	return (not r) or r.Instance:IsDescendantOf(char)
end

local function GetTarget()
	local best, dist = nil, FOV_RADIUS
	for _,p in ipairs(Players:GetPlayers()) do
		if p~=LocalPlayer and p.Character and IsAlive(p.Character) and HasLOS(p.Character) then
			local part = p.Character:FindFirstChild(AIM_PART)
			local pos, vis = Camera:WorldToViewportPoint(part.Position)
			if vis then
				local d = (Vector2.new(pos.X,pos.Y) - Camera.ViewportSize/2).Magnitude
				if d<dist then dist=d best=p end
			end
		end
	end
	return best
end

--================ LOS REAL (ANTI WALL AIMBOT) =================
local function HasClearView(targetPart)
    if not targetPart then return false end

    local origin = Camera.CFrame.Position
    local direction = (targetPart.Position - origin)

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.FilterDescendantsInstances = {LocalPlayer.Character, Camera}

    local result = workspace:Raycast(origin, direction, params)

    if not result then
        return true
    end

    return result.Instance:IsDescendantOf(targetPart.Parent)
end

--================ PEGAR TARGET SÓ INIMIGO (TEAM CHECK) =================
local function GetTargetRival()
    local closestPlayer = nil
    local shortestDistance = FOV_RADIUS

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and IsAlive(player.Character) then

            if player.Team ~= LocalPlayer.Team then
                
                local part = player.Character:FindFirstChild(AIM_PART)
                if part then
                    local screenPos, visible = Camera:WorldToViewportPoint(part.Position)

                    if visible then
                        local distance = (Vector2.new(screenPos.X, screenPos.Y) - Camera.ViewportSize/2).Magnitude

                        if distance < shortestDistance and HasClearView(part) then
                            shortestDistance = distance
                            closestPlayer = player
                        end
                    end
                end
            end
        end
    end

    return closestPlayer
end


--================ PEGAR TARGET SEM TEAM CHECK =================
local function GetTarget()
    local closestPlayer = nil
    local shortestDistance = FOV_RADIUS

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and IsAlive(player.Character) then
            
            local part = player.Character:FindFirstChild(AIM_PART)
            if part then
                local screenPos, visible = Camera:WorldToViewportPoint(part.Position)

                if visible then
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - Camera.ViewportSize/2).Magnitude

                    if distance < shortestDistance then
                        if HasClearView(part) then
                            shortestDistance = distance
                            closestPlayer = player
                        end
                    end
                end
            end
        end
    end

    return closestPlayer
end

--================ AIMBOT LOCK ATÉ MORRER (FIXADO) =================
RunService.RenderStepped:Connect(function()
    if not S.Aimbot then
        currentTarget = nil
        return
    end

    if not currentTarget or not currentTarget.Character or not IsAlive(currentTarget.Character) then
        currentTarget = GetTarget()
    end

    if currentTarget and currentTarget.Character then
        local part = currentTarget.Character:FindFirstChild(AIM_PART)
        if part and HasClearView(part) then
            local vel = part.AssemblyLinearVelocity or Vector3.zero
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, part.Position + vel * 0.12)
        else
            currentTarget = nil
        end
    end
end)

--================ AIMBOT RIVAL (SÓ INIMIGO + SEM WALL) =================
local currentTargetRival = nil

RunService.RenderStepped:Connect(function()
    if not S.AimbotRival then
        currentTargetRival = nil
        return
    end

    if not currentTargetRival or not currentTargetRival.Character or not IsAlive(currentTargetRival.Character) then
        currentTargetRival = GetTargetRival()
    end

    if currentTargetRival and currentTargetRival.Character then
        local part = currentTargetRival.Character:FindFirstChild(AIM_PART)
        if part and HasClearView(part) then
            local vel = part.AssemblyLinearVelocity or Vector3.zero
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, part.Position + vel * 0.12)
        else
            currentTargetRival = nil
        end
    end
end)


--================ TIRO AUTOMÁTICO =================
RunService.RenderStepped:Connect(function()
	if not S.AutoFire then return end
	if UIS.MouseBehavior~=Enum.MouseBehavior.LockCenter then return end

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Blacklist
	params.FilterDescendantsInstances={LocalPlayer.Character}

	local r = workspace:Raycast(
		Camera.CFrame.Position,
		Camera.CFrame.LookVector*600,
		params
	)
	if r then
		local char = r.Instance:FindFirstAncestorOfClass("Model")
		local plr = Players:GetPlayerFromCharacter(char)
		if plr and plr~=LocalPlayer and IsAlive(char) and HasLOS(char) then
			VIM:SendMouseButtonEvent(0,0,0,true,game,0)
			task.wait()
			VIM:SendMouseButtonEvent(0,0,0,false,game,0)
		end
	end
end)

--================ ESP CORPO VERMELHO FIX =================
local ESPObjects = {}
local Highlights = {}

local function ClearESP()
	for _,v in pairs(ESPObjects) do
		if v.Remove then
			v:Remove()
		end
	end
	ESPObjects = {}
end

local function ClearHighlightPlayer(p)
	if Highlights[p] then
		Highlights[p]:Destroy()
		Highlights[p] = nil
	end
end

-- 🔁 RECOLAR HIGHLIGHT QUANDO RESPAWNAR
for _,p in pairs(Players:GetPlayers()) do
	if p ~= LocalPlayer then
		p.CharacterAdded:Connect(function(char)
			task.wait(1)
			ClearHighlightPlayer(p)
		end)
	end
end

Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function(char)
		task.wait(1)
		ClearHighlightPlayer(p)
	end)
end)

RunService.RenderStepped:Connect(function()
	ClearESP()

	if not S.ESP_Lines then
		for _,h in pairs(Highlights) do
			if h then h:Destroy() end
		end
		Highlights = {}
		return
	end

	for _,p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character and IsAlive(p.Character) then
			local char = p.Character
			local hrp = char:FindFirstChild("HumanoidRootPart")
			local hum = char:FindFirstChildOfClass("Humanoid")
			if not hrp or not hum then continue end

			-- 🔴 HIGHLIGHT FIXADO NO CHARACTER ATUAL
			if not Highlights[p] or Highlights[p].Parent ~= char then
				ClearHighlightPlayer(p)

				local hl = Instance.new("Highlight")
				hl.FillColor = Color3.fromRGB(255,0,0)
				hl.OutlineColor = Color3.fromRGB(255,0,0)
				hl.FillTransparency = 0.4
				hl.OutlineTransparency = 0
				hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				hl.Parent = char

				Highlights[p] = hl
			end

			-- DISTÂNCIA
			local dist = (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude

			-- POS NA TELA
			local pos, vis = Camera:WorldToViewportPoint(hrp.Position)
			if not vis then continue end

			-- LINHA
			local line = Drawing.new("Line")
			line.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
			line.To = Vector2.new(pos.X, pos.Y)
			line.Color = Color3.fromRGB(255,0,0)
			line.Thickness = 2
			line.Visible = true
			table.insert(ESPObjects,line)

			-- TEXTO
			local text = Drawing.new("Text")
			text.Text = string.format("%s | HP: %d | %.0f studs", p.Name, hum.Health, dist)
			text.Position = Vector2.new(pos.X-50, pos.Y-60)
			text.Size = 16
			text.Color = Color3.fromRGB(255,255,255)
			text.Outline = true
			text.Visible = true
			table.insert(ESPObjects,text)
		end
	end
end)



--================ TOGGLES =================
Toggle("Aimbot", function(v) S.Aimbot=v end)
Toggle("Tiro automático", function(v) S.AutoFire=v end)
Toggle("ESP Linhas", function(v) S.ESP_Lines=v end)
Toggle("Night Vision", function(v)
	S.Night=v
	Lighting.Brightness = v and 5 or 1
end)
Toggle("Aimbot Rival", function(v)
	S.AimbotRival = v
end)

--================ NOVAS FUNÇÕES =================
-- Visão Raio X
Toggle("Visão Raio X", function(v)
	S.RaioX=v
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" and obj.Parent ~= LocalPlayer.Character then
			obj.Transparency = v and 0.5 or 0
		end
	end
end)

-- ESCONDER / MOSTRAR PAINEL COM CTRL
local panelHidden = false

UIS.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
		panelHidden = not panelHidden
		Main.Visible = not panelHidden
	end
end)



-- Pulos Automáticos CORRIGIDO
Toggle("Pulos Automáticos", function(v)
	S.AutoJump=v
	local function AutoJumpLoop(humanoid)
		task.spawn(function()
			while S.AutoJump and humanoid and humanoid.Parent do
				if humanoid.FloorMaterial ~= Enum.Material.Air then
					humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
				task.wait(0.3)
			end
		end)
	end

	local function SetupHumanoid(char)
		local humanoid = char:FindFirstChildOfClass("Humanoid")
		if humanoid then
			AutoJumpLoop(humanoid)
		end
	end

	if LocalPlayer.Character then
		SetupHumanoid(LocalPlayer.Character)
	end

	LocalPlayer.CharacterAdded:Connect(function(char)
		task.wait(0.5)
		if S.AutoJump then
			SetupHumanoid(char)
		end
	end)
end)

--================ KEY CONFIRM + FESTA FULLSCREEN =================
Confirm.MouseButton1Click:Connect(function()
	if KeyBox.Text==KEY then
		KeyF.Visible = false
		Main.Visible = true
	else
		KeyErrada()
	end
end)
