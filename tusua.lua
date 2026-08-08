-- Open Sourced Country Guesser Assistant, Fully Scripted By ( @jassmineta. ) On Discord
-- u can do whatever u want with this, but dont take full credits for my sh
-- Modified: Smaller GUI + Minimize button instead of Close

local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- DB
local Countries = {
    "Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros", "Congo", "Costa Rica", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Eswatini", "Ethiopia", "Fiji", "Finland", "France", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Honduras", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea North", "Korea South", "Kosovo", "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria", "North Macedonia", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Romania", "Russia", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "Uzbekistan", "Vanuatu", "Vatican City", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe"
}

-- GUI - Smaller Size
local gui = Instance.new("ScreenGui")
gui.Name = "TestingAC"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(250, 300) -- Smaller: 320x430 -> 250x300
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
frame.BorderSizePixel = 0
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(70, 70, 80)
stroke.Thickness = 1

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 35) -- Smaller: 40 -> 35
titleBar.BackgroundColor3 = Color3.fromRGB(38, 38, 45)
titleBar.BorderSizePixel = 0
titleBar.Parent = frame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -75, 1, 0) -- Make room for both buttons
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "GMC! Assistant:"
title.TextSize = 14 -- Smaller font
title.TextColor3 = Color3.new(1, 1, 1)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- Minimize Button (-) instead of Close (X)
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 28, 0, 28)
minimizeBtn.Position = UDim2.new(1, -62, 0, 4) -- Left of close button
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 0) -- Orange
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Text = "—" -- Minimize symbol
minimizeBtn.TextSize = 14
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
minimizeBtn.AutoButtonColor = false
minimizeBtn.Parent = titleBar
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 5)

-- Close Button (X) - Actually closes script
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -32, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Red
closeBtn.BorderSizePixel = 0
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.AutoButtonColor = false
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)

-- Minimize/Restore Function
local isMinimized = false
local originalSize = frame.Size
local minimizedSize = UDim2.fromOffset(250, 35)

minimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        frame.Size = minimizedSize
        scroll.Visible = false
        minimizeBtn.Text = "+" -- Change to restore symbol
        minimizeBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100) -- Green when minimized
    else
        frame.Size = originalSize
        scroll.Visible = true
        minimizeBtn.Text = "—"
        minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 0) -- Orange when normal
    end
end)

-- Close button destroys GUI completely
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local scroll = Instance.new("ScrollingFrame")
scroll.Position = UDim2.new(0, 8, 0, 42) -- Adjusted position
scroll.Size = UDim2.new(1, -16, 1, -48)
scroll.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3 -- Thinner scrollbar
scroll.CanvasSize = UDim2.new(0, 0, 0, 500)
scroll.Parent = frame
Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 8)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 3) -- Smaller padding
UIListLayout.Parent = scroll

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -10, 0, 25)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.Gotham
statusLabel.Text = "Waiting for game..."
statusLabel.TextSize = 12 -- Smaller font
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.Parent = scroll

-- Dragging
local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        frame.Position = startPos + UDim2.fromOffset(delta.X, delta.Y)
    end
end)

local function clearResults()
    for _, child in ipairs(scroll:GetChildren()) do
        if child:IsA("TextLabel") and child ~= statusLabel then
            child:Destroy()
        end
    end
end

local function addResult(text, isMatch)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 22) -- Smaller height
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextSize = 12 -- Smaller font
    if isMatch then
        label.TextColor3 = Color3.fromRGB(100, 255, 100)
        label.Font = Enum.Font.GothamBold -- Bold for match
    else
        label.TextColor3 = Color3.fromRGB(220, 220, 220)
    end
    label.Parent = scroll
end

local function normalizeText(text)
    text = text:gsub("%s+", " ")
    text = text:gsub("^%s+", ""):gsub("%s+$", "")
    return text:upper()
end

local function matchesPattern(country, pattern)
    country = normalizeText(country)
    pattern = normalizeText(pattern)
    local patternNoSpaces = pattern:gsub("%s+", "")
    local countryNoSpaces = country:gsub("%s+", "")
    if #pattern ~= #country then
        if #patternNoSpaces ~= #countryNoSpaces then
            return false
        end
        for i = 1, #patternNoSpaces do
            local pChar = patternNoSpaces:sub(i, i)
            local cChar = countryNoSpaces:sub(i, i)
            if pChar ~= "_" and pChar ~= " " and pChar ~= cChar then
                return false
            end
        end
        return true
    end
    for i = 1, #pattern do
        local pChar = pattern:sub(i, i)
        if pChar ~= "_" and pChar ~= " " and pChar ~= country:sub(i, i) then
            return false
        end
    end
    return true
end

local function getPossibleCountries(pattern)
    if pattern == "" or pattern == nil then return {} end
    local matches = {}
    for _, country in ipairs(Countries) do
        if matchesPattern(country, pattern) then
            table.insert(matches, country)
        end
    end
    return matches
end

local function findOpponentGuessText()
    local character = LocalPlayer.Character
    if not character then return nil end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return nil end
    if humanoid.Sit then
        local seat = humanoid.SeatPart
        if seat then
            local chairModel = seat:FindFirstAncestorWhichIsA("Model")
            if chairModel then
                local globe = chairModel:FindFirstChild("Globe")
                if globe then
                    local guessPart = globe:FindFirstChild("Guess")
                    if guessPart then
                        local billboard = guessPart:FindFirstChild("GuessDisplay")
                        if billboard then
                            local guessText = billboard:FindFirstChild("GuessText")
                            if guessText then
                                return guessText
                            end
                        end
                    end
                end
            end
        end
    end
    return nil
end

local lastPattern = ""
local currentGuessText = nil

while gui and gui.Parent do
    task.wait(0.1)
    if not gui or not gui.Parent then break end
    
    local guessTextObj = findOpponentGuessText()
    if guessTextObj then
        currentGuessText = guessTextObj
        local pattern = guessTextObj.Text or ""
        if pattern ~= lastPattern then
            lastPattern = pattern
            clearResults()
            if pattern == "" then
                statusLabel.Text = "Game starting..."
                statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            else
                local possible = getPossibleCountries(pattern)
                if #possible == 0 then
                    statusLabel.Text = "Pattern: " .. pattern
                    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
                    addResult("No matches found", false)
                elseif #possible == 1 then
                    statusLabel.Text = "ANSWER FOUND!"
                    statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
                    addResult(possible[1], true)
                else
                    statusLabel.Text = pattern .. " (" .. #possible .. " matches)"
                    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
                    for i = 1, math.min(12, #possible) do -- Show fewer results
                        addResult(possible[i], false)
                    end
                    if #possible > 12 then
                        addResult("... and " .. (#possible - 12) .. " more", false)
                    end
                end
                scroll.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
            end
        end
    else
        if lastPattern ~= "NOT_SITTING" then
            lastPattern = "NOT_SITTING"
            clearResults()
            statusLabel.Text = "Not in game. Sit to start."
            statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
    end
end