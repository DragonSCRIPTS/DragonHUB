-- Funções dos menus
local configuracoes = {
    {name = "Módulo AntiKick", url = "https://raw.githubusercontent.com/DragonSCRIPTS/DragonHUB/refs/heads/main/AntiKick%20Module.lua"},
    {name = "Módulo FlagPlayer", url = "https://raw.githubusercontent.com/DragonSCRIPTS/DragonHUB/refs/heads/main/FlagPlayer%20Module.lua"},
    {name = "Módulo SeaWorld", url = "https://raw.githubusercontent.com/DragonSCRIPTS/DragonHUB/refs/heads/main/SeaWorld%20Module.lua"},
    {name = "Módulo Anti AFK", url = "https://raw.githubusercontent.com/DragonSCRIPTS/DragonHUB/refs/heads/main/Anti%20AFK%20Module.lua"}
}

local principal = {
    {name = "Módulo Principal 1", url = "https://link_ficticio.com/Main%20Module%201.lua"},
    {name = "Módulo Principal 2", url = "https://link_ficticio.com/Main%20Module%202.lua"}
}

local estatisticas = {
    {name = "Módulo Estatísticas 1", url = "https://link_ficticio.com/Stats%20Module%201.lua"},
    {name = "Módulo Estatísticas 2", url = "https://link_ficticio.com/Stats%20Module%202.lua"}
}

local jogador = {
    {name = "Módulo Jogador 1", url = "https://link_ficticio.com/Player%20Module%201.lua"},
    {name = "Módulo Jogador 2", url = "https://link_ficticio.com/Player%20Module%202.lua"}
}

local teleporte = {
    {name = "Módulo Teleporte 1", url = "https://link_ficticio.com/Teleport%20Module%201.lua"},
    {name = "Módulo Teleporte 2", url = "https://link_ficticio.com/Teleport%20Module%202.lua"}
}

local frutas = {
    {name = "Módulo Frutas 1", url = "https://link_ficticio.com/Fruit%20Module%201.lua"},
    {name = "Módulo Frutas 2", url = "https://link_ficticio.com/Fruit%20Module%202.lua"}
}

local raid = {
    {name = "Módulo Raid 1", url = "https://link_ficticio.com/Raid%20Module%201.lua"},
    {name = "Módulo Raid 2", url = "https://link_ficticio.com/Raid%20Module%202.lua"}
}

local corrida = {
    {name = "Módulo Corrida 1", url = "https://link_ficticio.com/Race%20Module%201.lua"},
    {name = "Módulo Corrida 2", url = "https://link_ficticio.com/Race%20Module%202.lua"}
}

local loja = {
    {name = "Módulo Loja 1", url = "https://link_ficticio.com/Shop%20Module%201.lua"},
    {name = "Módulo Loja 2", url = "https://link_ficticio.com/Shop%20Module%202.lua"}
}

local diversos = {
    {name = "Módulo Diversos 1", url = "https://link_ficticio.com/Misc%20Module%201.lua"},
    {name = "Módulo Diversos 2", url = "https://link_ficticio.com/Misc%20Module%202.lua"}
}

-- Função para criar e exibir os botões para os links dos módulos
local function criar_botao(nome, url)
    return string.format('<button onclick="window.open(\'%s\')">%s</button>', url, nome)
end

-- Função para carregar e imprimir os botões com os links
local function carregar_menu(menu)
    for i, modulo in ipairs(menu) do
        print(criar_botao(modulo.name, modulo.url))  -- Gera e imprime o botão com o nome e URL
    end
end

-- Função para carregar todos os menus
local function carregar_todos_menus()
    print("Carregando Menu de Configurações:")
    carregar_menu(configuracoes)
    print("\nCarregando Menu Principal:")
    carregar_menu(principal)
    print("\nCarregando Menu de Estatísticas:")
    carregar_menu(estatisticas)
    print("\nCarregando Menu de Jogador:")
    carregar_menu(jogador)
    print("\nCarregando Menu de Teleporte:")
    carregar_menu(teleporte)
    print("\nCarregando Menu de Frutas:")
    carregar_menu(frutas)
    print("\nCarregando Menu de Raid:")
    carregar_menu(raid)
    print("\nCarregando Menu de Corrida:")
    carregar_menu(corrida)
    print("\nCarregando Menu de Loja:")
    carregar_menu(loja)
    print("\nCarregando Menu de Diversos:")
    carregar_menu(diversos)
end

-- Atualizar o menu a cada 1 minuto
while true do
    carregar_todos_menus()
    wait(60) -- Aguarda 60 segundos antes de carregar novamente
end
