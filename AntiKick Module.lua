-- AntiKickModule.lua
local AntiKickModule = {}

--// Loaded check
if getgenv().ED_AntiKick then
    return
end

--// Variables
local Players, StarterGui, OldNamecall = game:GetService("Players"), game:GetService("StarterGui")

--// Global Variables
getgenv().ED_AntiKick = {
    Enabled = true, -- Set to false if you want to disable the Anti-Kick.
    SendNotifications = true, -- Set to true if you want to get notified for every event
    CheckCaller = true -- Set to true if you want to disable kicking by other executed scripts
}

--// Main
OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    if (getgenv().ED_AntiKick.CheckCaller and not checkcaller() or true) and stringlower(getnamecallmethod()) == "kick" and ED_AntiKick.Enabled then
        if getgenv().ED_AntiKick.SendNotifications then
            StarterGui:SetCore("SendNotification", {
                Title = "Nome Do Seu Hub",
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
        Title = "Nome Do Seu Hub",
        Text = "Anti-Kick script loaded!",
        Icon = "rbxassetid://88147973848189",
        Duration = 3,
    })
end

return AntiKickModule
