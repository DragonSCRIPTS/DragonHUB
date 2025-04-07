-- UILibrary - init.lua
-- Biblioteca simples para criação de interface com abas, seções, botões e toggles.
-- Você pode expandir as funcionalidades conforme necessário.

local Library = {}

-- Função para criar a janela principal
function Library:CreateWindow(options)
    local window = {}
    options = options or {}
    
    -- Cria o ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = options.Name or "UI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui")
    
    -- Cria a janela principal (Frame)
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.Parent = screenGui

    -- Cria o container para as abas (lado esquerdo)
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(0, 100, 1, 0)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = mainFrame

    -- Cria o container para o conteúdo das abas
    local contentContainer = Instance.new("Frame")
    contentContainer.Size = UDim2.new(1, -100, 1, 0)
    contentContainer.Position = UDim2.new(0, 100, 0, 0)
    contentContainer.BackgroundTransparency = 1
    contentContainer.Parent = mainFrame

    -- Configurações da janela
    window.ScreenGui = screenGui
    window.MainFrame = mainFrame
    window.TabContainer = tabContainer
    window.ContentContainer = contentContainer
    window.Tabs = {}  -- Armazena as abas criadas
    window.Options = {}  -- Para armazenar toggles ou outras opções globais

    -- Função para adicionar uma nova aba
    function window:AddTab(tabOptions)
        tabOptions = tabOptions or {}
        local tab = {}
        tab.Title = tabOptions.Title or "Tab"
        tab.Icon = tabOptions.Icon or ""
        
        -- Cria o frame que conterá o conteúdo da aba
        tab.Content = Instance.new("Frame")
        tab.Content.Size = UDim2.new(1, 0, 1, 0)
        tab.Content.BackgroundTransparency = 1
        tab.Content.Visible = false
        tab.Content.Parent = window.ContentContainer

        -- Cria o botão da aba no container de abas
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(1, 0, 0, 30)
        tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tabButton.Text = tab.Title
        tabButton.Parent = window.TabContainer
        tab.Button = tabButton

        -- Conecta o clique do botão para mostrar esta aba e esconder as demais
        tabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(window.Tabs) do
                t.Content.Visible = false
                t.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            end
            tab.Content.Visible = true
            tab.Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        end)

        -- Se for a primeira aba, exibe-a automaticamente
        if #window.Tabs == 0 then
            tab.Content.Visible = true
            tabButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        end

        -- Método para adicionar uma seção na aba (ex.: título de grupo)
        function tab:AddSection(title)
            local section = Instance.new("TextLabel")
            section.Size = UDim2.new(1, -10, 0, 20)
            section.Position = UDim2.new(0, 5, 0, #tab.Content:GetChildren() * 25)
            section.BackgroundTransparency = 1
            section.Text = title or "Section"
            section.TextColor3 = Color3.new(1, 1, 1)
            section.Parent = tab.Content
            return section
        end

        -- Método para adicionar um botão na aba
        function tab:AddButton(buttonOptions)
            buttonOptions = buttonOptions or {}
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, -10, 0, 30)
            button.Position = UDim2.new(0, 5, 0, #tab.Content:GetChildren() * 35)
            button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            button.Text = buttonOptions.Title or "Button"
            button.Parent = tab.Content
            button.MouseButton1Click:Connect(function()
                if buttonOptions.Callback then
                    buttonOptions.Callback()
                end
            end)
            return button
        end

        -- Método para adicionar um toggle (botão de alternância) na aba
        function tab:AddToggle(toggleOptions)
            toggleOptions = toggleOptions or {}
            local toggle = {}
            toggle.Value = toggleOptions.Default or false
            local toggleButton = Instance.new("TextButton")
            toggleButton.Size = UDim2.new(1, -10, 0, 30)
            toggleButton.Position = UDim2.new(0, 5, 0, #tab.Content:GetChildren() * 35)
            toggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            toggleButton.Text = toggleOptions.Title .. " : " .. tostring(toggle.Value)
            toggleButton.Parent = tab.Content

            local changedCallback = nil
            function toggle.OnChanged(callback)
                changedCallback = callback
            end

            toggleButton.MouseButton1Click:Connect(function()
                toggle.Value = not toggle.Value
                toggleButton.Text = toggleOptions.Title .. " : " .. tostring(toggle.Value)
                if changedCallback then
                    changedCallback(toggle.Value)
                end
            end)

            toggle.UI = toggleButton
            return toggle
        end

        table.insert(window.Tabs, tab)
        return tab
    end

    return window
end

return Library
