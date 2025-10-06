-- Crear GUI y Botón
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlatformUI"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Name = "PlatformButton"
button.Size = UDim2.new(0, 150, 0, 50)
button.Position = UDim2.new(0.4, 0, 0.05, 0)
button.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
button.Text = "Platform"
button.Parent = screenGui

-- Variable para activar/desactivar
local activado = false

button.MouseButton1Click:Connect(function()
	activado = not activado
	if activado then
		button.Text = "Platform (ON)"
	else
		button.Text = "Platform (OFF)"
	end
end)

_G.PlatformActive = function()
	return activado
end
