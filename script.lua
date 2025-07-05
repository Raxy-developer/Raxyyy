--[[ 
    Script by Raxy-developer 
    Script Name: Raxy Ikan
    Repo: https://github.com/Raxy-developer/Raxyyy
]]

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- PIN akses
local inputPin = "230511"
local function verifyPin()
    local userPin = tostring(game:GetService("StarterGui"):PromptInput("Masukkan PIN untuk akses fitur", "PIN:"))
    if userPin ~= inputPin then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "PIN Salah", 
            Text = "Akses ditolak!",
            Duration = 3
        })
        return false
    end
    return true
end

if not verifyPin() then return end

-- UI Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name = "RAXY IKAN 🐟", HidePremium = false, SaveConfig = true, ConfigFolder = "RaxyIkan"})

local MainTab = Window:MakeTab({Name = "Main", Icon = "rbxassetid://7734053492", PremiumOnly = false})
local EspTab = Window:MakeTab({Name = "ESP", Icon = "rbxassetid://7734053492", PremiumOnly = false})
local MiscTab = Window:MakeTab({Name = "Misc", Icon = "rbxassetid://7734053492", PremiumOnly = false})

-- Boost toggle
local speedEnabled, jumpEnabled = false, false
local speedValue, jumpValue = 100, 100

MainTab:AddToggle({
    Name = "Speed Boost",
    Default = false,
    Callback = function(v) speedEnabled = v end
})

MainTab:AddToggle({
    Name = "Jump Boost",
    Default = false,
    Callback = function(v) jumpEnabled = v end
})

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = speedEnabled and speedValue or 16
            humanoid.JumpPower = jumpEnabled and jumpValue or 50
        end
    end
end)

-- ESP function
local function createESP(obj, color, text)
    local BillboardGui = Instance.new("BillboardGui", obj)
    BillboardGui.Size = UDim2.new(0,100,0,40)
    BillboardGui.Adornee = obj
    BillboardGui.AlwaysOnTop = true

    local label = Instance.new("TextLabel", BillboardGui)
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color
    label.TextScaled = true
end

EspTab:AddButton({
    Name = "ESP Orang",
    Callback = function()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local head = player.Character:FindFirstChild("Head")
                if head then createESP(head, Color3.new(1, 0, 0), "PLAYER") end
            end
        end
    end
})

EspTab:AddButton({
    Name = "ESP Ikan OP",
    Callback = function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name:lower():find("ikan") and obj:IsA("Model") then
                local head = obj:FindFirstChild("Head")
                if head then createESP(head, Color3.new(0, 1, 0), "IKAN OP") end
            end
        end
    end
})

EspTab:AddButton({
    Name = "ESP Ikan Secret",
    Callback = function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name:lower():find("secret") and obj:IsA("Model") then
                local head = obj:FindFirstChild("Head")
                if head then createESP(head, Color3.new(1, 1, 0), "SECRET") end
            end
        end
    end
})

EspTab:AddButton({
    Name = "ESP Ikan Shop",
    Callback = function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name:lower():find("shop") and obj:IsA("Model") then
                local head = obj:FindFirstChild("Head")
                if head then createESP(head, Color3.new(0, 0.7, 1), "SHOP") end
            end
        end
    end
})

MiscTab:AddButton({
    Name = "Sembunyikan Menu",
    Callback = function()
        OrionLib:Destroy()
    end
})

OrionLib:Init()
