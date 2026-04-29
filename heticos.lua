-- ============================================================
-- 🚂 MOD PINKY_TREN / EL TREN DEL DESASTRE 🚂
-- ============================================================

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local pGui = lp:WaitForChild("PlayerGui")

-- [ ELIMINAR INTERFAZ PREVIA ]
if pGui:FindFirstChild("ModPinkyTren") then pGui.ModPinkyTren:Destroy() end

-- [ BASE DE DATOS DE COORDENADAS ]
local ubicaciones = {
    {Nombre = "TRABAJO DE CAJAS", Pos = Vector3.new(688, 73, -749)},
    {Nombre = "BANCO", Pos = Vector3.new(522, 72, -614)},
    {Nombre = "TIENDA DE COMIDA", Pos = Vector3.new(616, 73, -875)},
    {Nombre = "PLAYA ESCONDIDA", Pos = Vector3.new(1298, 77, -1152)},
    {Nombre = "LA PLATABANDA", Pos = Vector3.new(480, 132, -1162)},
    {Nombre = "CALLEJÓN 1", Pos = Vector3.new(100, 132, -1249)},
    {Nombre = "CALLEJÓN 2", Pos = Vector3.new(132, 215, -1433)},
    {Nombre = "CRISTO", Pos = Vector3.new(154, 329, -1583)},
    {Nombre = "ZONA CENTRAL", Pos = Vector3.new(-340, 303, -1642)},
    {Nombre = "CUEVA (ZONA CENTRAL)", Pos = Vector3.new(-465, 208, -1628)},
    {Nombre = "MONTAÑA (ZONA CENTRAL)", Pos = Vector3.new(-569, 274, -1636)},
    {Nombre = "MINA V1", Pos = Vector3.new(-1043, 12, -1487)},
    {Nombre = "MINA (V2 V3)", Pos = Vector3.new(-963, -8, -1830)},
    {Nombre = "MINA (TRABAJO)", Pos = Vector3.new(-1073, -41, -2095)},
    {Nombre = "MINA (LAGO)", Pos = Vector3.new(-921, -52, -2124)},
    {Nombre = "SECTOR SUR", Pos = Vector3.new(-550, 74, -2753)},
    {Nombre = "BAY PLAYA", Pos = Vector3.new(762, 72, -2822)},
    {Nombre = "FARMACIA", Pos = Vector3.new(184, 75, 15)},
    {Nombre = "PLAZA", Pos = Vector3.new(356, 81, 105)},
    {Nombre = "PLAYA TAQUEQUE", Pos = Vector3.new(778, 73, 851)},
    {Nombre = "ARAGUANEY", Pos = Vector3.new(312, 73, 870)},
    {Nombre = "EL RANCHO", Pos = Vector3.new(-573, 110, 162)}
}

-- [ CREACIÓN DE INTERFAZ ]
local sg = Instance.new("ScreenGui", pGui)
sg.Name = "ModPinkyTren"
sg.ResetOnSpawn = false

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 300, 0, 450)
Main.Position = UDim2.new(0.5, -150, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(130, 0, 0)
Main.BackgroundTransparency = 0.1
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

-- [ BARRA SUPERIOR ]
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(0.8, 0, 1, 0)
Title.Text = "MOD PINKY_TREN"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

-- Botón de Minimizar
local MiniBtn = Instance.new("TextButton", Header)
MiniBtn.Size = UDim2.new(0, 40, 0, 40)
MiniBtn.Position = UDim2.new(1, -45, 0, 0)
MiniBtn.Text = "-"
MiniBtn.TextColor3 = Color3.new(1, 1, 1)
MiniBtn.TextSize = 25
MiniBtn.BackgroundTransparency = 1
MiniBtn.Font = Enum.Font.GothamBold

-- [ ELEMENTOS DEL CUERPO ]
local Body = Instance.new("Frame", Main)
Body.Size = UDim2.new(1, 0, 1, -40)
Body.Position = UDim2.new(0, 0, 0, 40)
Body.BackgroundTransparency = 1

local Search = Instance.new("TextBox", Body)
Search.Size = UDim2.new(0.9, 0, 0, 35)
Search.Position = UDim2.new(0.05, 0, 0, 5)
Search.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
Search.PlaceholderText = "🔍 Buscar zona..."
Search.TextColor3 = Color3.new(1, 1, 1)
Search.Font = Enum.Font.Gotham
Search.TextSize = 14
Instance.new("UICorner", Search)

local Scroll = Instance.new("ScrollingFrame", Body)
Scroll.Size = UDim2.new(0.95, 0, 0.8, 0)
Scroll.Position = UDim2.new(0.025, 0, 0.15, 0)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.ScrollBarThickness = 2
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 5)

-- [ LÓGICA DE MINIMIZAR ]
local isMinimized = false
MiniBtn.MouseButton1Click:Connect(function()
    if not isMinimized then
        Body.Visible = false
        Main:TweenSize(UDim2.new(0, 300, 0, 40), "Out", "Quad", 0.3, true)
        MiniBtn.Text = "+"
    else
        Main:TweenSize(UDim2.new(0, 300, 0, 450), "Out", "Quad", 0.3, true)
        task.wait(0.3)
        Body.Visible = true
        MiniBtn.Text = "-"
    end
    isMinimized = not isMinimized
end)

-- [ EFECTO DE RAYOS ]
task.spawn(function()
    while sg and sg.Parent do
        task.wait(5)
        Title.Text = "⚡ EL TREN DEL DESASTRE ⚡"
        Title.TextColor3 = Color3.new(1, 1, 0)
        task.wait(0.2)
        Title.Text = "MOD PINKY_TREN"
        Title.TextColor3 = Color3.new(1, 1, 1)
    end
end)

-- [ TELETRANSPORTE ]
local function tp(targetPos)
    local char = lp.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(targetPos)
    end
end

-- [ ACTUALIZAR LISTA ]
local function update(filter)
    for _, v in pairs(Scroll:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    local count = 0
    for _, u in pairs(ubicaciones) do
        if filter == "" or string.find(string.lower(u.Nombre), string.lower(filter)) then
            local b = Instance.new("TextButton", Scroll)
            b.Size = UDim2.new(1, -10, 0, 35)
            b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            b.Text = u.Nombre
            b.TextColor3 = Color3.new(1, 1, 1)
            b.Font = Enum.Font.GothamBold
            Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(function() tp(u.Pos) end)
            count = count + 1
        end
    end
    Scroll.CanvasSize = UDim2.new(0, 0, 0, count * 40)
end

Search:GetPropertyChangedSignal("Text"):Connect(function() update(Search.Text) end)
update("")

print("Script Mod Pinky_tren cargado con éxito.")
