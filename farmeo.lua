-- ==========================================
-- SCRIPT 1: AUTO-RESET CADA 2 ENTREGAS
-- ==========================================
local POS_ARTURO_1 = CFrame.new(154.02, 43.73, 513.57)
local carpetaNPCs_1 = game.Workspace:WaitForChild("Works"):WaitForChild("DeliveryNpcs")
local jugador_1 = game.Players.LocalPlayer
local RADIO_DETECCION_1 = 12 

local entregasRealizadas = 0
local bloqueadoPorReset = false

local function interactuar_1(p)
    p.HoldDuration = 0
    fireproximityprompt(p)
    task.wait(0.5) 
end

local function ejecutarCiclo_1()
    if bloqueadoPorReset then return end
    local char = jugador_1.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    if not hrp or not hum or hum.Health <= 0 then return end

    local npcDestino = carpetaNPCs_1:FindFirstChildOfClass("Model") or carpetaNPCs_1:FindFirstChildOfClass("Part")
    
    if npcDestino then
        hrp.CFrame = npcDestino:GetPivot() * CFrame.new(0, 0, 2)
    else
        hrp.CFrame = POS_ARTURO_1
    end

    hrp.Velocity = Vector3.zero

    local objetos = game.Workspace:GetPartBoundsInRadius(hrp.Position, RADIO_DETECCION_1)
    for _, obj in pairs(objetos) do
        local p = obj:FindFirstChildWhichIsA("ProximityPrompt") or obj.Parent:FindFirstChildWhichIsA("ProximityPrompt")
        if p then
            interactuar_1(p)
            if npcDestino then
                entregasRealizadas = entregasRealizadas + 1
                print("Entregas: " .. entregasRealizadas .. "/2")
                task.wait(1)
            end
            break
        end
    end

    if entregasRealizadas >= 2 then
        entregasRealizadas = 0
        bloqueadoPorReset = true
        hum.Health = 0 
    end
end

jugador_1.CharacterAdded:Connect(function()
    task.wait(1)
    bloqueadoPorReset = false
end)

game:GetService("RunService").Heartbeat:Connect(function()
    ejecutarCiclo_1()
end)

-- ==========================================
-- SCRIPT 2: ANTI-DETECCIÓN (JITTER)
-- ==========================================
local POS_ARTURO_2 = CFrame.new(154.02, 43.73, 513.57)
local carpetaNPCs_2 = game.Workspace:WaitForChild("Works"):WaitForChild("DeliveryNpcs")
local jugador_2 = game.Players.LocalPlayer
local RADIO_DETECCION_2 = 12 
local intentos = 0

local function interactuar_2(p)
    p.HoldDuration = 0
    fireproximityprompt(p)
    task.wait(math.random(3, 7) / 10) 
end

local function ejecutarCiclo_2()
    local char = jugador_2.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local npcDestino = carpetaNPCs_2:FindFirstChildOfClass("Model") or carpetaNPCs_2:FindFirstChildOfClass("Part")
    
    if npcDestino then
        hrp.CFrame = npcDestino:GetPivot() * CFrame.new(0, 0, 2)
    else
        local offset = Vector3.new(math.random(-1, 1), 0, math.random(-1, 1))
        hrp.CFrame = POS_ARTURO_2 + offset
    end

    hrp.Velocity = Vector3.zero

    local objetos = game.Workspace:GetPartBoundsInRadius(hrp.Position, RADIO_DETECCION_2)
    for _, obj in pairs(objetos) do
        local p = obj:FindFirstChildWhichIsA("ProximityPrompt") or obj.Parent:FindFirstChildWhichIsA("ProximityPrompt")
        if p then
            interactuar_2(p)
            intentos = intentos + 1
            break
        end
    end
end

task.spawn(function()
    while task.wait(1) do
        if intentos >= 5 then
            intentos = 0
            if jugador_2.Character and jugador_2.Character:FindFirstChild("Humanoid") then
                jugador_2.Character.Humanoid.Health = 0
                task.wait(5)
            end
        end
    end
end)

game:GetService("RunService").Heartbeat:Connect(function()
    ejecutarCiclo_2()
end)

-- ==========================================
-- SCRIPT 3: MODO LOCURA X2 (BYPASS CARGA)
-- ==========================================
local POS_ARTURO_3 = CFrame.new(154.02, 43.73, 513.57)
local carpetaNPCs_3 = game.Workspace.Works.DeliveryNpcs
local jugador_3 = game.Players.LocalPlayer
local RADIO_DETECCION_3 = 10 
local TIEMPO_RESPAWN_3 = 10 

jugador_3.ReplicationFocus = nil 
settings().Physics.AllowSleep = false
settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled

local function interactuar_3(p)
    if p.HoldDuration ~= 0 then p.HoldDuration = 0 end
    p:InputHoldBegin()
    task.delay(0.001, function() 
        p:InputHoldEnd()
        fireproximityprompt(p)
    end)
end

jugador_3.CharacterAdded:Connect(function(character)
    local hrp = character:WaitForChild("HumanoidRootPart", 10)
    if hrp then
        local npcActual = carpetaNPCs_3:FindFirstChildOfClass("Model") or carpetaNPCs_3:FindFirstChildOfClass("Part")
        hrp.CFrame = npcActual and (npcActual:GetPivot() * CFrame.new(0, 0, 2)) or POS_ARTURO_3
    end
end)

local function ejecutarCiclo_3()
    local car = jugador_3.Character
    local hrp = car and car:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        local npcActual = carpetaNPCs_3:FindFirstChildOfClass("Model") or carpetaNPCs_3:FindFirstChildOfClass("Part")
        local destino = npcActual and (npcActual:GetPivot() * CFrame.new(0, 0, 2)) or POS_ARTURO_3
        hrp.CFrame = destino
        hrp.Velocity = Vector3.new(0, 0, 0)

        local objetos = game.Workspace:GetPartBoundsInRadius(hrp.Position, RADIO_DETECCION_3)
        for i = 1, #objetos do
            local p = objetos[i]:FindFirstChildWhichIsA("ProximityPrompt") or objetos[i].Parent:FindFirstChildWhichIsA("ProximityPrompt")
            if p then 
                interactuar_3(p) 
            end
        end
    end
end

local ultimoRespawn_3 = tick()

game:GetService("RunService").Heartbeat:Connect(function()
    for i = 1, 10 do
        task.spawn(ejecutarCiclo_3)
    end

    if tick() - ultimoRespawn_3 > TIEMPO_RESPAWN_3 then
        ultimoRespawn_3 = tick()
        if jugador_3.Character and jugador_3.Character:FindFirstChild("Humanoid") then
            jugador_3.Character.Humanoid.Health = 0
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        local alerts = jugador_3:FindFirstChild("PlayerGui") and jugador_3.PlayerGui:FindFirstChild("InGameWarnings")
        if alerts then alerts:Destroy() end
    end
end)

print("--- LOS 3 SCRIPTS UNIDOS Y EJECUTÁNDOSE ---")
