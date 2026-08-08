-- Open Sourced Country Guesser Assistant, Fully Scripted By ( @jassmineta. ) On Discord
-- u can do whatever u want with this, but dont take full credits for my sh
-- Modified: Smaller GUI + Minimize button + Freely Draggable Anywhere

local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- DB
local Countries = {
    "Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros", "Congo", "Costa Rica", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Eswatini", "Ethiopia", "Fiji", "Finland", "France", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Honduras", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea North", "Korea South", "Kosovo", "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria", "North Macedonia", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Romania", "Russia", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "Uzbekistan", "Vanuatu", "Vatican City", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe"
}

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "TestingAC"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(250, 300)
frame.Position = UDim2.fromOffset(30, 100) -- Top-left corner instead of center
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
frame.BorderSizePixel = 0
frame.Active = true -- Allow input
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(70, 70, 80)
stroke.Thickness = 1

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(38, 38, 45)
titleBar.BorderSizePixel = 0
titleBar.Active = true -- For dragging
titleBar.Parent = frame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

-- Dragging indicator
local dragHint = Instance.new("TextLabel")
dragHint.Size = UDim2.new(1, -80, 1, 0)
dragHint.Position = UDim2.new(0, 10, 0, 0)
dragHint.BackgroundTransparency = 1
dragHint.Font = Enum.Font.GothamBold
dragHint.Text = "⋮⋮ GMC! Assistant:"
dragHint.TextSize = 13
dragHint.TextColor3 = Color3.new(1, 1, 1)
dragHint.TextXAlignment = Enum.TextXAlignment.Left
dragHint.Parent = titleBar

-- Minimize Button (-)
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 28, 0, 28)
minimizeBtn.Position = UDim2.new(1, -62, 0, 4)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Text = "—"
minimizeBtn.TextSize = 14
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
minimizeBtn.AutoButtonColor = false
minimizeBtn.Parent = titleBar
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 5)

-- Close Button (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -32, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.BorderSizePixel = 0
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.AutoButtonColor = false
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)

-- Minimize/Restore
local isMinimized = false
local originalSize = frame.Size
local minimizedSize = UDim2.fromOffset(250, 35)

minimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        frame.Size = minimizedSize
        scroll.Visible = false
        minimizeBtn.Text = "+"
        minimizeBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
        stroke.Thickness = 1
    else
        frame.Size = originalSize
        scroll.Visible = true
        minimizeBtn.Text = "—"
        minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
        stroke.Thickness = 1
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local scroll = Instance.new("ScrollingFrame")
scroll.Position = UDim2.new(0, 8, 0, 42)
scroll.Size = UDim2.new(1, -16, 1, -48)
scroll.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.CanvasSize = UDim2.new(0, 0, 0, 500)
scroll.Parent = frame
Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 8)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 3)
UIListLayout.Parent = scroll

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -10, 0, 25)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.Gotham
statusLabel.Text = "Waiting for game..."
statusLabel.TextSize = 12
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.Parent = scroll

-- ============================================
-- IMPROVED DRAGGING - Works anywhere on screen
-- ============================================
local dragging = false
local dragStart = nil
local frameStart = nil

-- Start dragging
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        frameStart = frame.Position
        
        -- Highlight border when dragging
        stroke.Color = Color3.fromRGB(100, 200, 255)
        stroke.Thickness = 2
    end
end)

-- Stop dragging
titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
        dragStart = nil
        frameStart = nil
        
        -- Reset border
        stroke.Color = Color3.fromRGB(70, 70, 80)
        stroke.Thickness = 1
    end
end)

-- Also stop dragging if mouse released anywhere
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and dragging then
        dragging = false
        dragStart = nil
        frameStart = nil
        
        -- Reset border
        stroke.Color = Color3.fromRGB(70, 70, 80)
        stroke.Thickness = 1
    end
end)

-- Move frame while dragging
UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        local newX = frameStart.X.Offset + delta.X
        local newY = frameStart.Y.Offset + delta.Y
        
        -- Clamp to screen bounds (optional, remove if you want it to go offscreen)
        local screenSize = Workspace.CurrentCamera.ViewportSize
        newX = math.clamp(newX, -frame.Size.X.Offset + 20, screenSize.X - 20)
        newY = math.clamp(newY, 0, screenSize.Y - 35)
        
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
    label.Size = UDim2.new(1, -10, 0, 22)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextSize = 12
    if isMatch then
        label.TextColor3 = Color3.fromRGB(100, 255, 100)
        label.Font = Enum.Font.GothamBold
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

-- ============================================
-- MAIN LOOP
-- ============================================
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
                    for i = 1, math.min(12, #possible) do
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