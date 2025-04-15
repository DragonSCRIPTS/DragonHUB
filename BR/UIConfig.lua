-- UIConfig.lua
-- Configuração da UI - Define os menus, botões, toggles e suas funções

-- Carrega a biblioteca principal
local UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/DragonSCRIPTS/DragonHUB/refs/heads/main/BR/UILibrary.lua"))()

-- Carrega o módulo de funções (opcional - você pode criar esse arquivo depois)
local Functions = loadstring(game:HttpGet("SEU_LINK_PARA_FUNÇÕES"))()

-- Cria a janela principal da UI
local Window = UILibrary:CreateWindow({
    Name = "Meu Script",
    ToggleKey = Enum.KeyCode.RightControl
})

-- Função para registrar menus/abas e seus elementos
local function SetupUI()
    -- === MENU PRINCIPAL ===
    local MainTab = Window:AddTab({
        Title = "Principal"
    })
    
    -- Seção: Controles Básicos
    MainTab:AddSection("Controles Básicos")
    
    -- Botão exemplo
    MainTab:AddButton({
        Title = "Iniciar Script",
        Callback = function()
            Functions.StartScript()
        end
    })
    
    -- Toggle exemplo
    local AutoFarmToggle = MainTab:AddToggle({
        Title = "Auto Farm",
        Default = false
    })
    
    AutoFarmToggle:OnChanged(function(value)
        Functions.ToggleAutoFarm(value)
    end)
    
    -- Slider exemplo
    local SpeedSlider = MainTab:AddSlider({
        Title = "Velocidade",
        Min = 1,
        Max = 100,
        Default = 16
    })
    
    SpeedSlider:OnChanged(function(value)
        Functions.SetSpeed(value)
    end)
    
    -- === MENU TELEPORTES ===
    local TeleportTab = Window:AddTab({
        Title = "Teleportes"
    })
    
    TeleportTab:AddSection("Áreas")
    
    TeleportTab:AddButton({
        Title = "Área Inicial",
        Callback = function()
            Functions.TeleportTo("Início")
        end
    })
    
    TeleportTab:AddButton({
        Title = "Loja",
        Callback = function()
            Functions.TeleportTo("Loja")
        end
    })
    
    -- === MENU CONFIGURAÇÕES ===
    local SettingsTab = Window:AddTab({
        Title = "Configurações"
    })
    
    SettingsTab:AddSection("Ajustes Visuais")
    
    local TransparencyToggle = SettingsTab:AddToggle({
        Title = "UI Transparente",
        Default = false
    })
    
    TransparencyToggle:OnChanged(function(value)
        Functions.SetTransparency(value)
    end)
    
    -- Você pode adicionar mais menus e elementos conforme necessário aqui
end

-- Inicializa a UI
SetupUI()

-- Retorna a janela para possibilitar acesso externo se necessário
return Window
