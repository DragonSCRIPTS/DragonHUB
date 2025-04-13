-- BloxFruitsMenu.lua
-- Script para registrar menus e botões usando a biblioteca BloxFruitsUI

-- Carregar a biblioteca UI
local UILibrary = require("BloxFruitsUI")

-- Configurações da interface
local config = {
    title = "Blox Fruits Hub",
    size = Vector2.new(400, 350)
}

-- Criar a janela principal
local window = UILibrary.CreateWindow(config.title, config.size)

-- Função para configurar a aba de Farm
local function setupFarmTab(tab)
    tab:AddLabel("Auto Farm", 18)
    tab:AddSeparator()
    
    -- Informações sobre o auto farm
    tab:AddInformation("Esta seção permite ativar funções de farm automático para ajudar na coleta de recursos e experiência.")
    
    -- Toggle para Auto Farm Nível
    local autoLevelFarm = tab:AddToggle("Auto Farm Nível", false, function(value)
        if value then
            window:Notify("Auto Farm", "Farm de nível ativado!", 3)
            -- Aqui você adicionaria sua lógica de farm
        else
            window:Notify("Auto Farm", "Farm de nível desativado!", 3)
            -- Aqui você pararia a lógica de farm
        end
    end)
    
    -- Toggle para Auto Farm Frutas
    tab:AddToggle("Auto Farm Frutas", false, function(value)
        if value then
            window:Notify("Auto Farm", "Farm de frutas ativado!", 3)
            -- Lógica de farm de frutas
        end
    end)
    
    -- Dropdown para selecionar método de farm
    local farmMethods = {"Ilha mais próxima", "Ilha específica", "NPC específico", "Boss"}
    tab:AddDropdown("Método de Farm", farmMethods, "Ilha mais próxima", function(selected)
        window:Notify("Farm Method", "Método alterado para: " .. selected, 3)
    end)
    
    -- Botão para teleportar para área de farm
    tab:AddButton("Teleportar para Área de Farm", function()
        window:Notify("Teleporte", "Tentando teleportar para área de farm...", 3)
        -- Lógica de teleporte
    end)
end

-- Função para configurar a aba de Combate
local function setupCombatTab(tab)
    tab:AddLabel("Configurações de Combate", 18)
    tab:AddSeparator()
    
    tab:AddInformation("Ajuste suas configurações de combate para maximizar sua eficiência em batalhas.")
    
    -- Toggles para habilidades de combate
    tab:AddToggle("Ativar Auto Ataque", false, function(value)
        -- Lógica de auto ataque
    end)
    
    tab:AddToggle("Usar Habilidades Automático", false, function(value)
        -- Lógica para usar habilidades
    end)
    
    tab:AddToggle("Kill Aura", false, function(value)
        window:Notify("Combate", value and "Kill Aura ativada!" or "Kill Aura desativada!", 3)
        -- Lógica kill aura
    end)
    
    -- Dropdown para selecionar arma
    local weapons = {"Espada", "Arma de Fogo", "Fruta do Diabo", "Punhos"}
    tab:AddDropdown("Arma Principal", weapons, "Espada", function(selected)
        -- Lógica para mudar arma
    end)
    
    -- Botão para equipar melhor arma
    tab:AddButton("Equipar Melhor Arma", function()
        window:Notify("Armas", "Equipando melhor arma disponível...", 3)
        -- Lógica para equipar arma
    end)
end

-- Função para configurar a aba de Teleporte
local function setupTeleportTab(tab)
    tab:AddLabel("Teleportes", 18)
    tab:AddSeparator()
    
    tab:AddInformation("Teleporte-se instantaneamente para diversas ilhas e locais no jogo.")
    
    -- Lista de ilhas para teleporte
    local islands = {"Ilha Inicial", "Middletown", "Jungle", "Pirate Village", "Desert", "Frozen Village", "Marine Fortress", "Skylands", "Prison", "Magma Village", "Fountain City"}
    tab:AddDropdown("Ilhas", islands, "Ilha Inicial", function(selected)
        window:Notify("Teleporte", "Teleportando para " .. selected, 3)
        -- Lógica de teleporte
    end)
    
    -- Botões de teleporte para locais importantes
    tab:AddButton("Teleportar para Loja", function()
        window:Notify("Teleporte", "Teleportando para loja...", 3)
        -- Lógica de teleporte
    end)
    
    tab:AddButton("Teleportar para Boss Atual", function()
        window:Notify("Teleporte", "Teleportando para boss...", 3)
        -- Lógica de teleporte
    end)
    
    tab:AddButton("Retornar ao Último Local", function()
        window:Notify("Teleporte", "Retornando ao local anterior...", 3)
        -- Lógica de teleporte
    end)
end

-- Função para configurar a aba de Configurações
local function setupSettingsTab(tab)
    tab:AddLabel("Configurações do Hub", 18)
    tab:AddSeparator()
    
    tab:AddInformation("Personalize as configurações do hub de acordo com suas preferências.")
    
    -- Configurações visuais
    tab:AddLabel("Configurações Visuais", 16)
    
    tab:AddToggle("Mostrar Notificações", true, function(value)
        -- Lógica para mostrar/ocultar notificações
    end)
    
    tab:AddToggle("Modo Discreto", false, function(value)
        if value then
            window:Notify("Configurações", "Modo discreto ativado!", 3)
            -- Lógica para modo discreto
        else
            window:Notify("Configurações", "Modo discreto desativado!", 3)
        end
    end)
    
    -- Configurações de segurança
    tab:AddLabel("Segurança", 16)
    
    tab:AddToggle("Anti-AFK", true, function(value)
        window:Notify("Anti-AFK", value and "Proteção Anti-AFK ativada!" or "Proteção Anti-AFK desativada!", 3)
        -- Lógica anti-afk
    end)
    
    tab:AddToggle("Auto Rejoin", false, function(value)
        -- Lógica de auto rejoin
    end)
    
    -- Créditos e informações
    tab:AddLabel("Informações", 16)
    tab:AddInformation("Blox Fruits Hub v1.0\nCriado por: Seu Nome\nAgradecimentos: Comunidade")
