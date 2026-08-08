-- KelvinGMC - Country Guesser Assistant
-- Fixed: Draggable + Minimize to small circle

local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

-- DB
local Countries = {
    "Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros", "Congo", "Costa Rica", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Eswatini", "Ethiopia", "Fiji", "Finland", "France", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Honduras", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea North", "Korea South", "Kosovo", "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria", "North Macedonia", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Romania", "Russia", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "Uzbekistan", "Vanuatu", "Vatican City", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe"
}

-- ============================================
-- CREATE MINIMIZED ICON (SMALL CIRCLE)
-- ============================================
local minimizedIcon = Instance.new("TextButton")
minimizedIcon.Size = UDim2.fromOffset(40, 40)
minimizedIcon.Position = UDim2.fromOffset(20, 100)
minimizedIcon.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
minimizedIcon.BorderSizePixel = 0
minimizedIcon.Text = "🌍"
minimizedIcon.TextSize = 18
minimizedIcon.Font = Enum.Font.GothamBold
minimizedIcon.AutoButtonColor = false
minimizedIcon.Active = true
minimizedIcon.Visible = false -- Hidden by default
minimizedIcon.Parent = CoreGui
Instance.new("UICorner", minimizedIcon).CornerRadius = UDim.new(1, 0)

local iconStroke = Instance.new("UIStroke", minimizedIcon)
iconStroke.Color = Color3.fromRGB(100, 200, 255)
iconStroke.Thickness = 2

-- Make minimized icon draggable
local iconDragging = false
local iconDragStart = nil
local iconStartPos = nil

minimizedIcon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        iconDragging = true
        iconDragStart = input.Position
        iconStartPos = minimizedIcon.Position
        iconStroke.Color = Color3.fromRGB(255, 200, 50)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        iconDragging = false
        iconStroke.Color = Color3.fromRGB(100, 200, 255)
    end
end)

UIS.InputChanged:Connect(function(input)
    if iconDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - iconDragStart
        local screenSize = Workspace.CurrentCamera.ViewportSize
        local newX = math.clamp(iconStartPos.X.Offset + delta.X, 0, screenSize.X - 40)
        local newY = math.clamp(iconStartPos.Y.Offset + delta.Y, 0, screenSize.Y - 40)
        minimizedIcon.Position = UDim2.fromOffset(newX, newY)
    end
end)

-- ============================================
-- CREATE MAIN GUI
-- ============================================
local gui = Instance.new("ScreenGui")
gui.Name = "KelvinGMC"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(210, 240)
frame.Position = UDim2.fromOffset(20, 100)
frame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.ClipsDescendants = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(70, 70, 80)
stroke.Thickness = 1

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 28)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
titleBar.BorderSizePixel = 0
titleBar.Active = true
titleBar.Parent = frame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -65, 1, 0)
title.Position = UDim2.new(0, 8, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "KelvinGMC"
title.TextSize = 11
title.TextColor3 = Color3.new(1, 1, 1)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- Minimize to icon button
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 22, 0, 22)
minimizeBtn.Position = UDim2.new(1, -48, 0, 3)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 160, 0)
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Text = "—"
minimizeBtn.TextSize = 11
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
minimizeBtn.AutoButtonColor = false
minimizeBtn.Parent = titleBar
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 11)

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -24, 0, 3)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.BorderSizePixel = 0
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "✕"
closeBtn.TextSize = 10
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.AutoButtonColor = false
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 11)

-- Scroll content
local scroll = Instance.new("ScrollingFrame")
scroll.Position = UDim2.new(0, 4, 0, 32)
scroll.Size = UDim2.new(1, -8, 1, -36)
scroll.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 2
scroll.CanvasSize = UDim2.new(0, 0, 0, 500)
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
-- MINIMIZE TO ICON / RESTORE
-- ============================================
local function minimizeToIcon()
    frame.Visible = false
    minimizedIcon.Visible = true
    minimizedIcon.Position = frame.Position
end

local function restoreFromIcon()
    frame.Visible = true
    minimizedIcon.Visible = false
    frame.Position = minimizedIcon.Position
end

minimizeBtn.MouseButton1Click:Connect(minimizeToIcon)
minimizedIcon.MouseButton1Click:Connect(function()
    if not iconDragging then
        restoreFromIcon()
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
    minimizedIcon:Destroy()
end)

-- ============================================
-- MAKE FRAME DRAGGABLE
-- ============================================
local frameDragging = false
local frameDragStart = nil
local frameStartPos = nil

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        frameDragging = true
        frameDragStart = input.Position
        frameStartPos = frame.Position
        stroke.Color = Color3.fromRGB(100, 200, 255)
        stroke.Thickness = 2
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        frameDragging = false
        stroke.Color = Color3.fromRGB(70, 70, 80)
        stroke.Thickness = 1
    end
end)

UIS.InputChanged:Connect(function(input)
    if frameDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - frameDragStart
        local screenSize = Workspace.CurrentCamera.ViewportSize
        local newX = math.clamp(frameStartPos.X.Offset + delta.X, -frame.Size.X.Offset + 30, screenSize.X - 30)
        local newY = math.clamp(frameStartPos.Y.Offset + delta.Y, 0, screenSize.Y - 28)
        frame.Position = UDim2.fromOffset(newX, newY)
    end
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
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextSize = 10
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.TextColor3 = isMatch and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(200, 200, 200)
    if isMatch then label.Font = Enum.Font.GothamBold end
    label.Parent = scroll
end

local function normalizeText(text)
    text = text:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
    return text:upper()
end

local function matchesPattern(country, pattern)
    country = normalizeText(country)
    pattern = normalizeText(pattern)
    local pNoSpace = pattern:gsub("%s+", "")
    local cNoSpace = country:gsub("%s+", "")
    if #pattern ~= #country then
        if #pNoSpace ~= #cNoSpace then return false end
        for i = 1, #pNoSpace do
            local p = pNoSpace:sub(i, i)
            if p ~= "_" and p ~= " " and p ~= cNoSpace:sub(i, i) then return false end
        end
        return true
    end
    for i = 1, #pattern do
        local p = pattern:sub(i, i)
        if p ~= "_" and p ~= " " and p ~= country:sub(i, i) then return false end
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
    local text = display:FindFirstChild("GuessText")
    return text
end

-- ============================================
-- MAIN LOOP
-- ============================================
local lastPattern = ""

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
                    statusLabel.Text = pattern
                    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
                elseif #possible == 1 then
                    statusLabel.Text = "✅ " .. possible[1]
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