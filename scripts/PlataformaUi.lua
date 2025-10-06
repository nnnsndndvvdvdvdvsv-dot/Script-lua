-- CONFIG
local NOMBRE_PLATAFORMA = "Platform"
local ELEVACION = 50       -- Fuerza al saltar
local DESCENSO = -10       -- Bajada suave
local DESCENSO_DELAY = 0.5 -- Segundos antes de bajar

-- Crear GUI
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlatformUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Name = "PlatformButton"
button.Size = UDim2.new(0, 150, 0, 50)
button.Position = UDim2.new(0.4, 0, 0.05, 0)
button.Text = "Platform (OFF)"
button.Parent = screenGui

local activado = false
button.MouseButton1Click:Connect(function()
	activado = not activado
	button.Text = activado and "Platform (ON)" or "Platform (OFF)"
end)

-- Buscar plataforma
local plataforma = game.Workspace:WaitForChild(NOMBRE_PLATAFORMA)
local plataformasActivas = {}

plataforma.Touched:Connect(function(obj)
	local humanoid = obj.Parent:FindFirstChild("Humanoid")
	if humanoid then
		local plr = game.Players:GetPlayerFromCharacter(obj.Parent)
		if plr then
			plataformasActivas[plr] = true
		end
	end
end)

plataforma.TouchEnded:Connect(function(obj)
	local humanoid = obj.Parent:FindFirstChild("Humanoid")
	if humanoid then
		local plr = game.Players:GetPlayerFromCharacter(obj.Parent)
		if plr then
			plataformasActivas[plr] = false
		end
	end
end)

game:GetService("RunService").Stepped:Connect(function()
	if not activado then return end
	for plr, encima in pairs(plataformasActivas) do
		if encima then
			local char = plr.Character
			if char then
				local hum = char:FindFirstChild("Humanoid")
				local root = char:FindFirstChild("HumanoidRootPart")
				if hum and root and hum.Jump then
					-- Elevar
					local vel = root.Velocity
					root.Velocity = Vector3.new(vel.X, ELEVACION, vel.Z)

					-- Bajar luego
					task.delay(DESCENSO_DELAY, function()
						if root and root:IsDescendantOf(game) then
							local vel2 = root.Velocity
							root.Velocity = Vector3.new(vel2.X, DESCENSO, vel2.Z)
						end
					end)
				end
			end
		end
	end
end)
