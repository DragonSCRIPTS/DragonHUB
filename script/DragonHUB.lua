-- Função para carregar os links dinamicamente
local function loadLinks()
    local HttpService = game:GetService("HttpService")
    local url = "https://raw.githubusercontent.com/DragonSCRIPTS/DragonHUB/refs/heads/main/modules_links.lua"
    local linksData = HttpService:GetAsync(url)
    local links = HttpService:JSONDecode(linksData) -- Supondo que os links estejam em formato JSON

    return links
end

-- Função para criar os botões de navegação dinamicamente
local function createDynamicTabs(links, parentFrame)
    for _, link in pairs(links) do
        local TabButton = Instance.new("TextButton")
        TabButton.Parent = parentFrame
        TabButton.Size = UDim2.new(0, 150, 0, 40)
        TabButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        TabButton.Text = link.name  -- O nome do botão
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 18

        TabButton.MouseButton1Click:Connect(function()
            loadstring(game:HttpGet(link.url))()  -- Executa o link associado ao botão
        end)
    end
end

-- Função para configurar a interface
local function setupUI()
    local Window = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local MainLabel = Instance.new("TextLabel")
    
    -- Propriedades do Window
    Window.Name = "Dragon HUB"  -- Nome do script
    Window.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Propriedades do MainFrame
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = Window
    MainFrame.Size = UDim2.new(0, 530, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -265, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    -- Propriedades do MainLabel
    MainLabel.Name = "MainLabel"
    MainLabel.Parent = MainFrame
    MainLabel.Size = UDim2.new(0, 530, 0, 50)
    MainLabel.Position = UDim2.new(0, 0, 0, 0)
    MainLabel.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    MainLabel.Text = "Dragon HUB - Canal Oficial"
    MainLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainLabel.TextSize = 24
    MainLabel.TextAlign = Enum.TextAlign.Center

    -- Carregar links e criar os botões dinamicamente
    local links = loadLinks()
    createDynamicTabs(links, MainFrame)
end

-- Função para validar o executor
local function validateExecutor()
    local exploit = getexecutorname or identifyexecutor
    local support = {
        ["Fluxus"] = true,
        ["Trigon"] = false,
        ["Codex"] = true,
        ["Delta"] = true,
        ["Vega X"] = true,
        ["Hydrogen"] = true,
        ["alysse"] = false,
        ["ArceusX"] = true,
        ["Electron"] = false,
    }

    if support[exploit()] then
        print("Correct Executor, Let's Run uwu")
    else
        game.Players.LocalPlayer:Kick("Ko Hỗ Trợ Executor | Not Supported Executor | Tidak Mendukung Pelaksana | Support: Fluxus, Hydrogen, Alysse, Trigon, Vega X")
    end
end

-- Função para coletar dados do jogador e enviar via webhook
local function sendPlayerData()
    local HttpService = game:GetService("HttpService")
    local ExecutorUsing = is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or secure_load and "Sentinel" or KRNL_LOADED and "Krnl" or SONA_LOADED and "Sona" or "Fluxus"

    local Data = {
        ["embeds"] = {
            {
                ["title"] = "𝙥𝙡𝙖𝙮𝙚𝙧𝙨 𝙥𝙧𝙤𝙛𝙞𝙡𝙚💻",
                ["url"] = "https://www.roblox.com/users/" .. game.Players.LocalPlayer.UserId,
                ["description"] = "||```" .. game.Players.LocalPlayer.DisplayName .. " (" .. game.Players.LocalPlayer.Name .. ")```||",
                ["color"] = tonumber(0x7269da),
                ["thumbnail"] = {["url"] = "https://your-image-url-here.com"},
                ["fields"] = {
                    {
                        ["name"] = "𝙀𝙭𝙚𝙘𝙪𝙩𝙤𝙧📑",
                        ["value"] = "```" .. ExecutorUsing .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "𝘼𝙜𝙚🗓",
                        ["value"] = "```" .. game.Players.LocalPlayer.AccountAge .. " Day```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "𝙎𝙘𝙧𝙞𝙥𝙩 𝙎𝙩𝙖𝙩𝙪𝙨ℹ️",
                        ["value"] = "```Người dùng đã chạy script Dragon HUB | Canal Oficial```",
                        ["inline"] = true
                    },
                }
            }
        }
    }

    local Headers = {["Content-Type"] = "application/json"}
    local Encoded = HttpService:JSONEncode(Data)

    local Request = http_request or request or HttpPost or syn.request
    local Final = {
        Url = "https://discord.com/api/webhooks/your-webhook-url",
        Body = Encoded,
        Method = "POST",
        Headers = Headers
    }
    Request(Final)
end

-- Função Anti-Kick
local function antiKick()
    local getgenv, getnamecallmethod, hookmetamethod, newcclosure, checkcaller, stringlower = getgenv, getnamecallmethod, hookmetamethod, newcclosure, checkcaller, string.lower

    if getgenv().ED_AntiKick then
        return
    end

    local Players, StarterGui, OldNamecall = game:GetService("Players"), game:GetService("StarterGui")
    getgenv().ED_AntiKick = {
        Enabled = true,
        SendNotifications = true,
        CheckCaller = true
    }

    OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
        if (getgenv().ED_AntiKick.CheckCaller and not checkcaller()) and stringlower(getnamecallmethod()) == "kick" and ED_AntiKick.Enabled then
            if getgenv().ED_AntiKick.SendNotifications then
                StarterGui:SetCore("SendNotification", {
                    Title = "Dragon HUB",
                    Text = "The script has successfully intercepted an attempted kick.",
                    Icon = "rbxassetid://88147973848189",
                    Duration = 2,
                })
            end
            return nil
        end
        return OldNamecall(...)
    end))

    if getgenv().ED_AntiKick.SendNotifications then
        StarterGui:SetCore("SendNotification", {
            Title = "Dragon HUB",
            Text = "Anti-Kick script loaded!",
            Icon = "rbxassetid://88147973848189",
            Duration = 3,
        })
    end
end

-- Executando as funções
validateExecutor()
setupUI()
sendPlayerData()
antiKick()
