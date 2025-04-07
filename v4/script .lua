-- Carregar a biblioteca UI personalizada
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/DragonSCRIPTS/DragonHUB/refs/heads/main/v4/UILibrary.lua"))()

-- Criar a janela principal
local window = Library:CreateWindow({
    Name = "Raças V4 - Blox Fruits",
    ToggleKey = Enum.KeyCode.RightControl
})

-- Funções auxiliares
local function Tween(Pos)
    local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
    local Distance = (HRP.Position - Pos.Position).Magnitude
    game:GetService("TweenService"):Create(
        HRP,
        TweenInfo.new(Distance/300, Enum.EasingStyle.Linear),
        {CFrame = Pos}
    ):Play()
    wait(Distance/300)
end

local function Tween2(Pos)
    local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
    local Distance = (HRP.Position - Pos.Position).Magnitude
    game:GetService("TweenService"):Create(
        HRP,
        TweenInfo.new(Distance/300, Enum.EasingStyle.Linear),
        {CFrame = Pos}
    ):Play()
end

local function toTarget(Pos)
    Tween(Pos)
end

local function AttackNoCoolDown()
    local Combat = game.Players.LocalPlayer.Character:FindFirstChild("Combat") or game.Players.LocalPlayer.Backpack:FindFirstChild("Combat")
    if Combat then
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(Combat)
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
    end
end

local function AutoHaki()
    if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end

local function EquipTool(ToolName)
    local Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolName) or game.Players.LocalPlayer.Character:FindFirstChild(ToolName)
    if Tool then
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
    end
end

-- Criando Abas
local raceTab = window:AddTab({Title = "Raça V4"})

-- Temple do Tempo
raceTab:AddSection("Templo do Tempo")

raceTab:AddButton({
    Title = "Ir ao Templo",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875))
    end
})

raceTab:AddButton({
    Title = "Puxar Alavanca",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875))
        wait(0.5)
        Tween2(CFrame.new(28575.181640625, 14936.6279296875, 72.31636810302734))
    end
})

raceTab:AddButton({
    Title = "Acient One",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875))
        wait(0.5)
        Tween2(CFrame.new(28981.552734375, 14888.4267578125, -120.245849609375))
    end
})

-- Trial de Raça
raceTab:AddSection("Trial de Raça")

raceTab:AddButton({
    Title = "Porta da Raça",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875))
        wait(0.5)
        local RaceValue = game:GetService("Players").LocalPlayer.Data.Race.Value
        
        if RaceValue == "Human" then
            Tween2(CFrame.new(29221.822265625, 14890.9755859375, -205.99114990234375))
        elseif RaceValue == "Skypiea" then
            Tween2(CFrame.new(28960.158203125, 14919.6240234375, 235.03948974609375))
        elseif RaceValue == "Fishman" then
            Tween2(CFrame.new(28231.17578125, 14890.9755859375, -211.64173889160156))
        elseif RaceValue == "Cyborg" then
            Tween2(CFrame.new(28502.681640625, 14895.9755859375, -423.7279357910156))
        elseif RaceValue == "Ghoul" then
            Tween2(CFrame.new(28674.244140625, 14890.6767578125, 445.4310607910156))
        elseif RaceValue == "Mink" then
            Tween2(CFrame.new(29012.341796875, 14890.9755859375, -380.1492614746094))
        end
    end
})

local humanGhoulToggle = raceTab:AddToggle({
    Title = "Auto Human/Ghoul Trial",
    Default = false
})

humanGhoulToggle:OnChanged(function(state)
    KillAura = state
    
    while KillAura do
        wait()
        for i, v in pairs(game.Workspace.Enemies:GetDescendants()) do
            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                pcall(function()
                    v.Humanoid.Health = 0
                    v.HumanoidRootPart.CanCollide = false
                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                end)
            end
        end
    end
end)

local autoTrialToggle = raceTab:AddToggle({
    Title = "Auto Trial de Raça",
    Default = false
})

autoTrialToggle:OnChanged(function(state)
    _G.AutoQuestRace = state
    
    spawn(function()
        pcall(function()
            while wait() do
                if _G.AutoQuestRace then
                    local RaceValue = game:GetService("Players").LocalPlayer.Data.Race.Value
                    
                    if RaceValue == "Human" then
                        for i, v in pairs(game.Workspace.Enemies:GetDescendants()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                pcall(function()
                                    v.Humanoid.Health = 0
                                    v.HumanoidRootPart.CanCollide = false
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                end)
                            end
                        end
                    elseif RaceValue == "Skypiea" then
                        for i, v in pairs(game:GetService("Workspace").Map.SkyTrial.Model:GetDescendants()) do
                            if v.Name == "snowisland_Cylinder.081" then
                                toTarget(v.CFrame * CFrame.new(0, 0, 0))
                            end
                        end
                    elseif RaceValue == "Fishman" then
                        for i, v in pairs(game:GetService("Workspace").SeaBeasts.SeaBeast1:GetDescendants()) do
                            if v.Name == "HumanoidRootPart" then
                                Tween(v.CFrame * CFrame.new(0, 30, 0))
                                UseSkill()
                            end
                        end
                    elseif RaceValue == "Cyborg" then
                        Tween(CFrame.new(28654, 14898.7832, -30, 1, 0, 0, 0, 1, 0, 0, 0, 1))
                    elseif RaceValue == "Ghoul" then
                        for i, v in pairs(game.Workspace.Enemies:GetDescendants()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                pcall(function()
                                    v.Humanoid.Health = 0
                                    v.HumanoidRootPart.CanCollide = false
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                end)
                            end
                        end
                    elseif RaceValue == "Mink" then
                        for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                            if v.Name == "StartPoint" then
                                Tween(v.CFrame * CFrame.new(0, 10, 0))
                            end
                        end
                    end
                end
            end
        end)
    end)
end)

-- Função para usar skills em monstros (para Fishman Trial)
function UseSkill()
    local Weapons = {"Melee", "Blox Fruit", "Sword", "Gun"}
    local Keys = {"Z", "X", "C"}
    
    for _, WeaponType in pairs(Weapons) do
        for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v:IsA("Tool") and v.ToolTip == WeaponType then
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                wait(0.1)
                
                for _, Key in pairs(Keys) do
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, Key, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                    wait(0.1)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, Key, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                    wait(0.2)
                end
            end
        end
    end
end

-- Configurações
raceTab:AddSection("Configurações")

-- Obter armas do jogador em tempo real
local WeaponOptions = {}
local SelectedWeapon = "Combat"

-- Atualizar a lista de armas disponíveis
spawn(function()
    while wait() do
        pcall(function()
            local foundWeapons = {}
            for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if v:IsA("Tool") then
                    table.insert(foundWeapons, v.Name)
                end
            end
            for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v:IsA("Tool") then
                    table.insert(foundWeapons, v.Name)
                end
            end
            
            -- Atualizar a lista de armas disponíveis se necessário
            if #foundWeapons > 0 and #WeaponOptions == 0 then
                WeaponOptions = foundWeapons
                -- A interface atual não tem um método para atualizar uma lista de dropdown existente
                -- Então o dropdown seria criado inicialmente vazio e preenchido depois
            end
        end)
    end
end)

-- Informações da Raça
raceTab:AddSection("Informações")

-- Criar label para informações da raça
local raceInfoLabel = "Carregando..."

-- Atualizar informações da raça constantemente
spawn(function()
    while wait(1) do
        pcall(function()
            local Player = game:GetService("Players").LocalPlayer
            local RaceValue = Player.Data.Race.Value
            local RaceLevel = "V1"
            
            if Player.Character:FindFirstChild("RaceTransformed") then
                if Player.Character.RaceTransformed.Value then
                    RaceLevel = "V4 (Transformado)"
                else
                    if Player.Data.Race.Value ~= "Human" and require(game:GetService("ReplicatedStorage").Quests.QuestManager).GetQuestDatas().V3 then
                        RaceLevel = "V3"
                    elseif Player.Data.Race.Value ~= "Human" and require(game:GetService("ReplicatedStorage").Quests.QuestManager).GetQuestDatas().V2 then
                        RaceLevel = "V2"
                    end
                end
            end
            
            raceInfoLabel = "Sua Raça: " .. RaceValue .. " " .. RaceLevel
            -- A biblioteca atual não tem um método direto para atualizar labels
            -- Se sua biblioteca tiver alguma função para isso, deveria ser chamada aqui
        end)
    end
end)

-- Adicionar informações da raça
raceTab:AddSection(raceInfoLabel)

-- Créditos
local creditTab = window:AddTab({Title = "Créditos"})
creditTab:AddSection("Script por: Dragon")
