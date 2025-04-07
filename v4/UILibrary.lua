-- UILibrary - init.lua
-- Biblioteca para criação de interface com abas, seções, botões, toggles e função de arrastar.
-- Versão melhorada com suporte para arrastar a janela.

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
    
    -- Cria a barra de título (para arrastar)
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 25)
    titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    titleBar.Parent = mainFrame
    
    -- Título da janela
    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, -10, 1, 0)
    titleText.Position = UDim2.new(0, 10, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = options.Name or "UI Library"
    titleText.TextColor3 = Color3.new(1, 1, 1)
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = titleBar
    
    -- Cria o container para as abas (lado esquerdo)
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(0, 100, 1, -25)
    tabContainer.Position = UDim2.new(0, 0, 0, 25)
    tabContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    tabContainer.Parent = mainFrame

    -- Cria o container para o conteúdo das abas
    local contentContainer = Instance.new("Frame")
    contentContainer.Size = UDim2.new(1, -100, 1, -25)
    contentContainer.Position = UDim2.new(0, 100, 0, 25)
    contentContainer.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    contentContainer.Parent = mainFrame

    -- Configurações da janela
    window.ScreenGui = screenGui
    window.MainFrame = mainFrame
    window.TabContainer = tabContainer
    window.ContentContainer = contentContainer
    window.Tabs = {}  -- Armazena as abas criadas
    window.Options = {}  -- Para armazenar toggles ou outras opções globais
    
    -- Implementação do sistema de arrastar
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function updateDrag(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateDrag(input)
        end
    end)
    
    -- Botão para fechar a UI
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 20, 0, 20)
    closeButton.Position = UDim2.new(1, -25, 0, 2.5)
    closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.Parent = titleBar
    
    closeButton.MouseButton1Click:Connect(function()
        screenGui.Enabled = false
    end)
    
    -- Função para mostrar/ocultar a UI (tecla de atalho)
    local function toggleUI()
        screenGui.Enabled = not screenGui.Enabled
    end
    
    -- Conectar tecla de atalho para mostrar/ocultar a UI
    game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == (options.ToggleKey or Enum.KeyCode.RightControl) then
            toggleUI()
        end
    end)

    -- Função para adicionar uma nova aba
    function window:AddTab(tabOptions)
        tabOptions = tabOptions or {}
        local tab = {}
        tab.Title = tabOptions.Title or "Tab"
        tab.Icon = tabOptions.Icon or ""
        
        -- Cria o frame que conterá o conteúdo da aba
        tab.Content = Instance.new("ScrollingFrame")
        tab.Content.Size = UDim2.new(1, 0, 1, 0)
        tab.Content.BackgroundTransparency = 1
        tab.Content.Visible = false
        tab.Content.ScrollBarThickness = 4
        tab.Content.CanvasSize = UDim2.new(0, 0, 0, 0) -- Será atualizado dinamicamente
        tab.Content.Parent = window.ContentContainer
        
        -- Layout automático para os elementos da aba
        local listLayout = Instance.new("UIListLayout")
        listLayout.Padding = UDim.new(0, 5)
        listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        listLayout.Parent = tab.Content
        
        -- Padding para os elementos
        local padding = Instance.new("UIPadding")
        padding.PaddingTop = UDim.new(0, 10)
        padding.PaddingLeft = UDim.new(0, 10)
        padding.PaddingRight = UDim.new(0, 10)
        padding.Parent = tab.Content

        -- Cria o botão da aba no container de abas
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(1, 0, 0, 30)
        tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tabButton.Text = tab.Title
        tabButton.Parent = window.TabContainer
        tab.Button = tabButton
        
        -- Atualizar o canvas size baseado nos elementos
        listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tab.Content.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 20)
        end)

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
            local section = Instance.new("Frame")
            section.Size = UDim2.new(1, 0, 0, 30)
            section.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            section.Parent = tab.Content
            
            local sectionTitle = Instance.new("TextLabel")
            sectionTitle.Size = UDim2.new(1, 0, 1, 0)
            sectionTitle.BackgroundTransparency = 1
            sectionTitle.Text = title or "Section"
            sectionTitle.TextColor3 = Color3.new(1, 1, 1)
            sectionTitle.Font = Enum.Font.SourceSansBold
            sectionTitle.Parent = section
            
            return section
        end

        -- Método para adicionar um botão na aba
        function tab:AddButton(buttonOptions)
            buttonOptions = buttonOptions or {}
            local buttonContainer = Instance.new("Frame")
            buttonContainer.Size = UDim2.new(1, 0, 0, 35)
            buttonContainer.BackgroundTransparency = 1
            buttonContainer.Parent = tab.Content
            
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, 0, 1, 0)
            button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            button.Text = buttonOptions.Title or "Button"
            button.TextColor3 = Color3.new(1, 1, 1)
            button.Parent = buttonContainer
            
            -- Efeito de hover
            button.MouseEnter:Connect(function()
                button.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
            end)
            
            button.MouseLeave:Connect(function()
                button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            end)
            
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
            
            local toggleContainer = Instance.new("Frame")
            toggleContainer.Size = UDim2.new(1, 0, 0, 35)
            toggleContainer.BackgroundTransparency = 1
            toggleContainer.Parent = tab.Content
            
            local toggleButton = Instance.new("TextButton")
            toggleButton.Size = UDim2.new(1, -30, 1, 0)
            toggleButton.Position = UDim2.new(0, 0, 0, 0)
            toggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            toggleButton.Text = toggleOptions.Title or "Toggle"
            toggleButton.TextColor3 = Color3.new(1, 1, 1)
            toggleButton.TextXAlignment = Enum.TextXAlignment.Left
            toggleButton.Parent = toggleContainer
            
            -- Padding para o texto
            local textPadding = Instance.new("UIPadding")
            textPadding.PaddingLeft = UDim.new(0, 10)
            textPadding.Parent = toggleButton
            
            -- Indicador visual do toggle
            local toggleIndicator = Instance.new("Frame")
            toggleIndicator.Size = UDim2.new(0, 20, 0, 20)
            toggleIndicator.Position = UDim2.new(1, -25, 0.5, -10)
            toggleIndicator.BackgroundColor3 = toggle.Value and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(200, 200, 200)
            toggleIndicator.Parent = toggleButton
            
            local changedCallback = nil
            function toggle:OnChanged(callback)
                changedCallback = callback
            end
            
            local function updateToggle()
                toggle.Value = not toggle.Value
                toggleIndicator.BackgroundColor3 = toggle.Value and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(200, 200, 200)
                if changedCallback then
                    changedCallback(toggle.Value)
                end
            end

            toggleButton.MouseButton1Click:Connect(updateToggle)
            
            -- Para acesso direto aos componentes visuais
            toggle.Container = toggleContainer
            toggle.Button = toggleButton
            toggle.Indicator = toggleIndicator
            
            -- Método para definir o valor programaticamente
            function toggle:SetValue(value)
                if toggle.Value ~= value then
                    toggle.Value = value
                    toggleIndicator.BackgroundColor3 = value and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(200, 200, 200)
                    if changedCallback then
                        changedCallback(value)
                    end
                end
            end
            
            return toggle
        end
        
        -- Método para adicionar um slider (controle deslizante)
        function tab:AddSlider(sliderOptions)
            sliderOptions = sliderOptions or {}
            local slider = {}
            slider.Min = sliderOptions.Min or 0
            slider.Max = sliderOptions.Max or 100
            slider.Value = sliderOptions.Default or slider.Min
            
            local sliderContainer = Instance.new("Frame")
            sliderContainer.Size = UDim2.new(1, 0, 0, 50)
            sliderContainer.BackgroundTransparency = 1
            sliderContainer.Parent = tab.Content
            
            local sliderTitle = Instance.new("TextLabel")
            sliderTitle.Size = UDim2.new(1, 0, 0, 20)
            sliderTitle.BackgroundTransparency = 1
            sliderTitle.Text = sliderOptions.Title or "Slider"
            sliderTitle.TextColor3 = Color3.new(1, 1, 1)
            sliderTitle.TextXAlignment = Enum.TextXAlignment.Left
            sliderTitle.Parent = sliderContainer
            
            local sliderValueDisplay = Instance.new("TextLabel")
            sliderValueDisplay.Size = UDim2.new(0, 40, 0, 20)
            sliderValueDisplay.Position = UDim2.new(1, -40, 0, 0)
            sliderValueDisplay.BackgroundTransparency = 1
            sliderValueDisplay.Text = tostring(slider.Value)
            sliderValueDisplay.TextColor3 = Color3.new(1, 1, 1)
            sliderValueDisplay.Parent = sliderContainer
            
            local sliderBackground = Instance.new("Frame")
            sliderBackground.Size = UDim2.new(1, 0, 0, 10)
            sliderBackground.Position = UDim2.new(0, 0, 0, 25)
            sliderBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            sliderBackground.Parent = sliderContainer
            
            local sliderFill = Instance.new("Frame")
            local fillSize = (slider.Value - slider.Min) / (slider.Max - slider.Min)
            sliderFill.Size = UDim2.new(fillSize, 0, 1, 0)
            sliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            sliderFill.Parent = sliderBackground
            
            local sliderButton = Instance.new("TextButton")
            sliderButton.Size = UDim2.new(0, 10, 0, 20)
            sliderButton.Position = UDim2.new(fillSize, -5, 0, -5)
            sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sliderButton.Text = ""
            sliderButton.Parent = sliderBackground
            
            local changedCallback = nil
            function slider:OnChanged(callback)
                changedCallback = callback
            end
            
            local function updateSlider(input)
                local pos = math.clamp((input.Position.X - sliderBackground.AbsolutePosition.X) / sliderBackground.AbsoluteSize.X, 0, 1)
                local value = math.floor(slider.Min + (slider.Max - slider.Min) * pos)
                slider.Value = value
                sliderFill.Size = UDim2.new(pos, 0, 1, 0)
                sliderButton.Position = UDim2.new(pos, -5, 0, -5)
                sliderValueDisplay.Text = tostring(value)
                
                if changedCallback then
                    changedCallback(value)
                end
            end
            
            local dragging = false
            
            sliderButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                end
            end)
            
            sliderButton.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
            
            sliderBackground.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    updateSlider(input)
                end
            end)
            
            game:GetService("UserInputService").InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateSlider(input)
                end
            end)
            
            -- Método para definir o valor programaticamente
            function slider:SetValue(value)
                value = math.clamp(value, slider.Min, slider.Max)
                if slider.Value ~= value then
                    slider.Value = value
                    local pos = (value - slider.Min) / (slider.Max - slider.Min)
                    sliderFill.Size = UDim2.new(pos, 0, 1, 0)
                    sliderButton.Position = UDim2.new(pos, -5, 0, -5)
                    sliderValueDisplay.Text = tostring(value)
                    
                    if changedCallback then
                        changedCallback(value)
                    end
                end
            end
            
            -- Para acesso direto aos componentes visuais
            slider.Container = sliderContainer
            slider.Background = sliderBackground
            slider.Fill = sliderFill
            slider.Button = sliderButton
            
            return slider
        end

        table.insert(window.Tabs, tab)
        return tab
    end

    return window
end

return Library
