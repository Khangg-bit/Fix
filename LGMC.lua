-- KelvinGMC - Country Guesser Assistant
-- Final Fix: Minimize to small circle works 100%

local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local Countries = {
    "Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros", "Congo", "Costa Rica", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Eswatini", "Ethiopia", "Fiji", "Finland", "France", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Honduras", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea North", "Korea South", "Kosovo", "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria", "North Macedonia", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Romania", "Russia", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "Uzbekistan", "Vanuatu", "Vatican City", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe"
}

-- ============================================
-- MAIN SCREEN GUI
-- ============================================
local gui = Instance.new("ScreenGui")
gui.Name = "KelvinGMC"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

-- ============================================
-- MAIN FRAME
-- ============================================
local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(210, 250)
frame.Position = UDim2.fromOffset(15, 80)
frame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.ClipsDescendants = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(80, 80, 90)
stroke.Thickness = 1

-- ============================================
-- TITLE BAR
-- ============================================
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 28)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
titleBar.BorderSizePixel = 0
titleBar.Active = true
titleBar.Parent = frame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 8, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "KelvinGMC"
title.TextSize = 11
title.TextColor3 = Color3.new(1, 1, 1)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- Minimize button
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 22, 0, 22)
minimizeBtn.Position = UDim2.new(1, -46, 0, 3)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 160, 0)
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Text = "_"
minimizeBtn.TextSize = 14
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
minimizeBtn.AutoButtonColor = false
minimizeBtn.Parent = titleBar
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 11)

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -22, 0, 3)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.BorderSizePixel = 0
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextSize = 12
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.AutoButtonColor = false
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 11)

-- ============================================
-- SCROLL CONTENT
-- ============================================
local scroll = Instance.new("ScrollingFrame")
scroll.Position = UDim2.new(0, 4, 0, 32)
scroll.Size = UDim2.new(1, -8, 1, -36)
scroll.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 2
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.Parent = frame
Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 6)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 2)
UIListLayout.Parent = scroll

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -6, 0, 20)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.Gotham
statusLabel.Text = "Waiting..."
statusLabel.TextSize = 10
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.Parent = scroll

-- ============================================
-- MINIMIZED ICON (SEPARATE FROM FRAME)
-- ============================================
local iconBtn = Instance.new("TextButton")
iconBtn.Size = UDim2.fromOffset(36, 36)
iconBtn.Position = UDim2.fromOffset(15, 80)
iconBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
iconBtn.BorderSizePixel = 0
iconBtn.Text = "🌍"
iconBtn.TextSize = 16
iconBtn.Font = Enum.Font.GothamBold
iconBtn.AutoButtonColor = false
iconBtn.Active = true
iconBtn.Visible = false
iconBtn.Parent = gui
Instance.new("UICorner", iconBtn).CornerRadius = UDim.new(1, 0)

local iconStroke = Instance.new("UIStroke", iconBtn)
iconStroke.Color = Color3.fromRGB(100, 200, 255)
iconStroke.Thickness = 2

-- ============================================
-- DRAG FOR FRAME
-- ============================================
local dragFrame = false
local dragStartFrame = nil
local frameStart = nil

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragFrame = true
        dragStartFrame = input.Position
        frameStart = frame.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragFrame and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartFrame
        local screen = Workspace.CurrentCamera.ViewportSize
        local x = math.clamp(frameStart.X.Offset + delta.X, -180, screen.X - 30)
        local y = math.clamp(frameStart.Y.Offset + delta.Y, 0, screen.Y - 30)
        frame.Position = UDim2.fromOffset(x, y)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragFrame = false
    end
end)

-- ============================================
-- DRAG FOR ICON
-- ============================================
local dragIcon = false
local dragStartIcon = nil
local iconStart = nil

iconBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragIcon = true
        dragStartIcon = input.Position
        iconStart = iconBtn.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragIcon and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartIcon
        local screen = Workspace.CurrentCamera.ViewportSize
        local x = math.clamp(iconStart.X.Offset + delta.X, 0, screen.X - 36)
        local y = math.clamp(iconStart.Y.Offset + delta.Y, 0, screen.Y - 36)
        iconBtn.Position = UDim2.fromOffset(x, y)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragIcon = false
    end
end)

-- ============================================
-- MINIMIZE / RESTORE LOGIC
-- ============================================
minimizeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    iconBtn.Position = frame.Position
    iconBtn.Visible = true
end)

iconBtn.MouseButton1Click:Connect(function()
    -- Only restore if not dragging
    task.wait(0.05)
    if not dragIcon then
        iconBtn.Visible = false
        frame.Position = iconBtn.Position
        frame.Visible = true
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- ============================================
-- FUNCTIONS
-- ============================================
local function clearResults()
    for _, child in ipairs(scroll:GetChildren()) do
        if child:IsA("TextLabel") and child ~= statusLabel then
            child:Destroy()
        end
    end
end

local function addResult(text, isMatch)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -6, 0, 18)
    label.BackgroundTransparency = 1
    label.Font = isMatch and Enum.Font.GothamBold or Enum.Font.Gotham
    label.Text = text
    label.TextSize = 10
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.TextColor3 = isMatch and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(200, 200, 200)
    label.Parent = scroll
end

local function normalizeText(text)
    text = text:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
    return text:upper()
end

local function matchesPattern(country, pattern)
    country = normalizeText(country)
    pattern = normalizeText(pattern)
    local pns = pattern:gsub("%s+", "")
    local cns = country:gsub("%s+", "")
    if #pattern ~= #country then
        if #pns ~= #cns then return false end
        for i = 1, #pns do
            local pc = pns:sub(i, i)
            if pc ~= "_" and pc ~= " " and pc ~= cns:sub(i, i) then return false end
        end
        return true
    end
    for i = 1, #pattern do
        local pc = pattern:sub(i, i)
        if pc ~= "_" and pc ~= " " and pc ~= country:sub(i, i) then return false end
    end
    return true
end

local function getPossibleCountries(pattern)
    if not pattern or pattern == "" then return {} end
    local matches = {}
    for _, country in ipairs(Countries) do
        if matchesPattern(country, pattern) then
            table.insert(matches, country)
        end
    end
    return matches
end

local function findOpponentGuessText()
    local char = LocalPlayer.Character
    if not char then return nil end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or not hum.Sit then return nil end
    local seat = hum.SeatPart
    if not seat then return nil end
    local model = seat:FindFirstAncestorWhichIsA("Model")
    if not model then return nil end
    local globe = model:FindFirstChild("Globe")
    if not globe then return nil end
    local guess = globe:FindFirstChild("Guess")
    if not guess then return nil end
    local display = guess:FindFirstChild("GuessDisplay")
    if not display then return nil end
    return display:FindFirstChild("GuessText")
end

-- ============================================
-- MAIN LOOP
-- ============================================
local lastPattern = ""

coroutine.wrap(function()
    while gui and gui.Parent do
        task.wait(0.1)
        if not gui or not gui.Parent then break end
        
        local guessTextObj = findOpponentGuessText()
        if guessTextObj then
            local pattern = guessTextObj.Text or ""
            if pattern ~= lastPattern then
                lastPattern = pattern
                clearResults()
                if pattern == "" then
                    statusLabel.Text = "Starting..."
                    statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
                else
                    local possible = getPossibleCountries(pattern)
                    if #possible == 0 then
                        statusLabel.Text = "❌ " .. pattern
                        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
                    elseif #possible == 1 then
                        statusLabel.Text = "✅ ANSWER!"
                        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
                        addResult(possible[1], true)
                    else
                        statusLabel.Text = pattern .. " (" .. #possible .. ")"
                        statusLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
                        for i = 1, math.min(8, #possible) do
                            addResult(possible[i], false)
                        end
                        if #possible > 8 then
                            addResult("+" .. (#possible - 8) .. " more", false)
                        end
                    end
                    scroll.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 5)
                end
            end
        else
            if lastPattern ~= "NOT_SITTING" then
                lastPattern = "NOT_SITTING"
                clearResults()
                statusLabel.Text = "Sit to start"
                statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            end
        end
    end
end)()