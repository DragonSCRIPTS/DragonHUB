-- Módulos de Link com nome
local modules = {
    -- AntiKick Module
    {name = "AntiKick Module", url = "https://raw.githubusercontent.com/DragonSCRIPTS/DragonHUB/refs/heads/main/AntiKick%20Module.lua"},
    
    -- FlagPlayer Module
    {name = "FlagPlayer Module", url = "https://raw.githubusercontent.com/DragonSCRIPTS/DragonHUB/refs/heads/main/FlagPlayer%20Module.lua"},
    
    -- SeaWorld Module
    {name = "SeaWorld Module", url = "https://raw.githubusercontent.com/DragonSCRIPTS/DragonHUB/refs/heads/main/SeaWorld%20Module.lua"},
    
    -- Anti AFK Module
    {name = "Anti AFK Module", url = "https://raw.githubusercontent.com/DragonSCRIPTS/DragonHUB/refs/heads/main/Anti%20AFK%20Module.lua"}
}

-- Função para carregar os módulos
local function loadModules()
    for _, module in ipairs(modules) do
        print("Carregando módulo: " .. module.name)  -- Exibe o nome do módulo
        loadstring(game:HttpGet(module.url))()  -- Carrega e executa o script do módulo
    end
end

-- Chama a função para carregar os módulos
loadModules()
