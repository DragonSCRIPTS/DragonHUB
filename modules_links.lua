-- Módulos de Link
local modules = {
    "loadstring(game:HttpGet('https://raw.githubusercontent.com/DragonSCRIPTS/DragonHUB/refs/heads/main/AntiKick%20Module.lua'))()",
    "loadstring(game:HttpGet('https://raw.githubusercontent.com/DragonSCRIPTS/DragonHUB/refs/heads/main/FlagPlayer%20Module.lua'))()",
    "loadstring(game:HttpGet('https://raw.githubusercontent.com/DragonSCRIPTS/DragonHUB/refs/heads/main/SeaWorld%20Module.lua'))()",
    "loadstring(game:HttpGet('https://raw.githubusercontent.com/DragonSCRIPTS/DragonHUB/refs/heads/main/Anti%20AFK%20Module.lua'))()"
}

-- Função para carregar os módulos
local function loadModules()
    for _, module in ipairs(modules) do
        loadstring(module)()  -- Carrega e executa o script do módulo
    end
end

-- Chama a função para carregar os módulos
loadModules()
