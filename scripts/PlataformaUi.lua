local platform = script.Parent
local players = game:GetService("Players")

local plataformasActivas = {}

platform.Touched:Connect(function(obj)
	local humanoid = obj.Parent:FindFirstChild("Humanoid")
	if humanoid then
		local player = players:GetPlayerFromCharacter(obj.Parent)
		if player then
			plataformasActivas[player] = true
		end
	end
end)

platform.TouchEnded:Connect(function(obj)
	local humanoid = obj.Parent:FindFirstChild("Humanoid")
	if humanoid then
		local player = players:GetPlayerFromCharacter(obj.Parent)
		if player then
			plataformasActivas[player] = false
		end
	end
end)

game:GetService("RunService").Stepped:Connect(function()
	for player, encima in pairs(plataformasActivas) do
		if encima and _G.PlatformActive and _G.PlatformActive() then
			local char = player.Character
			if char then
				local hum = char:FindFirstChild("Humanoid")
				local root = char:FindFirstChild("HumanoidRootPart")

				if hum and root and hum.Jump then
					-- Elevar un poco
					root.Velocity = Vector3.new(root.Velocity.X, 50, root.Velocity.Z)

					-- Bajar poco a poco
					task.delay(0.5, function()
						if root then
							root.Velocity = Vector3.new(root.Velocity.X, -10, root.Velocity.Z)
						end
					end)
				end
			end
		end
	end
end)
