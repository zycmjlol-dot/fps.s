-- Services
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

-- ลบ UI เก่าทิ้งถ้ามีอยู่แล้ว
if CoreGui:FindFirstChild("MobilePotatoGui") then
    CoreGui.MobilePotatoGui:Destroy()
end

-- สร้าง ScreenGui หลัก
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MobilePotatoGui"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ปุ่มเปิด/ปิดหน้าต่าง (ลอยบนจอมือถือ)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 110, 0, 45)
ToggleButton.Position = UDim2.new(0.05, 0, 0.1, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 105, 180) -- ชมพู
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "MENU"
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 10)
ToggleCorner.Parent = ToggleButton

-- หน้าต่างหลัก (สีชมพูอมม่วง)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 280, 0, 220)
MainFrame.Position = UDim2.new(0.5, -140, 0.4, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 20, 55) -- พื้นหลังสีม่วงเข้ม
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

-- แถบหัวข้อ (สีชมพูอมม่วงสว่าง)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(186, 85, 211) -- ชมพูอมม่วง (Orchid)
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 14)
TopBarCorner.Parent = TopBar

-- แก้ขอบล่างของ TopBar ให้เป็นเหลี่ยมปกติ
local FixBar = Instance.new("Frame")
FixBar.Size = UDim2.new(1, 0, 0, 10)
FixBar.Position = UDim2.new(0, 0, 1, -10)
FixBar.BackgroundColor3 = Color3.fromRGB(186, 85, 211)
FixBar.BorderSizePixel = 0
FixBar.Parent = TopBar

-- ข้อความหัวข้อ
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "EVADE MOBILE OPTIMIZER"
TitleLabel.Parent = TopBar

-- ปุ่มเปิด/ปิดเมนูผ่านปุ่มลอย
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ฟังก์ชันเปิดใช้งาน Potato Graphics (ภาพดินน้ำมัน / ลบแสงเงา / เคลียร์แมพ)
local function EnablePotatoGraphics()
    -- ปิดเอฟเฟกต์แสงทั้งหมดใน Lighting
    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("SunRaysEffect") then
            v:Destroy()
        end
    end
    
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 999999
    Lighting.Brightness = 2

    -- ลดรายละเอียดวัตถุใน Workspace (ลบของตกแต่ง, เอฟเฟกต์, พาร์ทเล็กๆ)
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            v.CastShadow = false
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
            v:Destroy() -- ลบเอฟเฟกต์รกตาและกินเครื่อง
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy() -- ลบพื้นผิวลายละเอียด
        end
    end

    -- ปรับ Terrain (พื้นดิน) ให้เรียบและไม่กินสเปก
    if Workspace:FindFirstChildOfClass("Terrain") then
        local terrain = Workspace:FindFirstChildOfClass("Terrain")
        terrain.WaterWaveSize = 0
        terrain.WaterWaveSpeed = 0
        terrain.WaterTransparency = 0
        terrain.WaterReflectance = 0
        sethiddenproperty(terrain, "Decoration", false)
    end
end

-- ปุ่มกดรัน Potato Graphics ในหน้าต่าง UI
local PotatoButton = Instance.new("TextButton")
PotatoButton.Size = UDim2.new(0.85, 0, 0, 50)
PotatoButton.Position = UDim2.new(0.075, 0, 0.35, 0)
PotatoButton.BackgroundColor3 = Color3.fromRGB(219, 112, 147) -- สีชมพูเข้ม
PotatoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PotatoButton.TextSize = 14
PotatoButton.Font = Enum.Font.GothamBold
PotatoButton.Text = "⚡ เปิดโหมดภาพดินน้ำมัน (ลบลื่นสุดๆ)"
PotatoButton.Parent = MainFrame

local PotatoCorner = Instance.new("UICorner")
PotatoCorner.CornerRadius = UDim.new(0, 10)
PotatoCorner.Parent = PotatoButton

PotatoButton.MouseButton1Click:Connect(function()
    EnablePotatoGraphics()
    PotatoButton.Text = "✔ เปิดใช้งานแล้ว (ลื่นมาก)"
    PotatoButton.BackgroundColor3 = Color3.fromRGB(50, 205, 50) -- เปลี่ยนเป็นสีเขียวเมื่อกดแล้ว
end)

-- เครดิตเล็กๆ ด้านล่าง
local CreditLabel = Instance.new("TextLabel")
CreditLabel.Size = UDim2.new(1, 0, 0, 30)
CreditLabel.Position = UDim2.new(0, 0, 0.8, 0)
CreditLabel.BackgroundTransparency = 1
CreditLabel.TextColor3 = Color3.fromRGB(200, 160, 220)
CreditLabel.TextSize = 11
CreditLabel.Font = Enum.Font.Gotham
CreditLabel.Text = "Mobile Boosted for Evade"
CreditLabel.Parent = MainFrame
