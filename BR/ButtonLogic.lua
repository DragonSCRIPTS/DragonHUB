-- ButtonLogic.lua
-- Contém todas as lógicas dos botões e elementos da UI

local Logic = {}

-- Função para o botão "Iniciar Script"
function Logic.StartScript()
    print("Script iniciado!")
    -- Implementação completa aqui
end

-- Função para o toggle "Auto Farm"
function Logic.ToggleAutoFarm(enabled)
    if enabled then
        print("Auto Farm ativado")
        -- Iniciar loop de farm
    else
        print("Auto Farm desativado")
        -- Parar loop de farm
    end
end

-- Mais funções aqui...

return Logic
