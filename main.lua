local Library = {}

local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local SettingsShield = RobloxGui:WaitForChild("SettingsShield"):WaitForChild("SettingsShield")
local MenuContainer = SettingsShield:WaitForChild("MenuContainer")
local HubBar = MenuContainer:WaitForChild("HubBar")
local PageViewClipper = MenuContainer:WaitForChild("PageViewClipper")
local PageView = PageViewClipper:WaitForChild("PageView")
local PageViewInnerFrame = PageView:WaitForChild("PageViewInnerFrame")

local getcustomasset = getsynasset or getcustomasset

local Sections = {
    ["Record"] = {"Record", "RecordTab"}, 
    ["Help"] = {"Help", "HelpTab"}, 
    ["Report"] = {"ReportAbusePage", "ReportAbuseTab"}
}

function Library.Section(Sectione)
    local Section = {}

    local SectionTab = HubBar:FindFirstChild(Sections[Sectione][2])

    local Frame = Instance.new("Frame", PageViewInnerFrame)
    Frame.Visible = false
    Frame.Name = "CustomTab"
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.new(1, 0, 0, 319)

    local UIListLayout = Instance.new("UIListLayout", Frame)
    UIListLayout.Padding = UDim.new(0, 3)
    UIListLayout.SortOrder = "LayoutOrder"
    UIListLayout.VerticalAlignment = "Top"
    UIListLayout.HorizontalAlignment = "Center"
    UIListLayout.FillDirection = "Vertical"

    RunService.Heartbeat:Connect(function()
        local SectionView = PageViewInnerFrame:FindFirstChild(Sections[Sectione][1])

        if SectionView then
            for _, v in pairs(SectionView:GetChildren()) do
                if v ~= Frame then
                    pcall(function()
                        v.Visible = false
                    end)
                end
            end

            Frame.Parent = SectionView
            Frame.Visible = SectionView.Visible
        end
    end)

    Section.Title = function(Title)
        SectionTab.Icon.Title.Text = Title
    end

    Section.Icon = function(Url)
        local FileName = HttpService:GenerateGUID(false) .. ".png"

        writefile(FileName, game:HttpGet(Url))

        SectionTab.Icon.Image = getcustomasset(FileName)

        spawn(function()
            wait(3)
            delfile(FileName)
        end)
    end

    Section.Button = function(Text, Callback)
        local Button = Instance.new("ImageButton", Frame)
        Button.Name = "Button"
        Button.LayoutOrder = #Frame:GetChildren()
        Button.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
        Button.BorderColor3 = Color3.fromRGB(27, 42, 53)
        Button.BorderSizePixel = 1
        Button.BackgroundTransparency = 1
        Button.AnchorPoint = Vector2.new(0.5,0.5)
        Button.Position = UDim2.new(0.5, 0, 0.5, 0)
        Button.Size = UDim2.new(0, 182, 0, 46)
        Button.ScaleType = "Slice"
        Button.SliceCenter = Rect.new(8, 6, 46, 44)
        Button.SliceScale = 1
        Button.TileSize = UDim2.new(1, 0, 1, 0)
        Button.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
        Button.HoverImage = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
        Button.PressedImage = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"

        local TextLabel = Instance.new("TextLabel", Button)
        TextLabel.Text = Text
        TextLabel.Font = Enum.Font.SourceSansBold
        TextLabel.TextWrapped = true
        TextLabel.TextSize = 24
        TextLabel.BackgroundTransparency = 1
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.Position = UDim2.new(0, 0, 0, 1)
        TextLabel.Size = UDim2.new(1, 0, 1, -8)
        TextLabel.Visible = true
    
        Button.MouseButton1Down:Connect(Callback)
    end

    Section.Switch = function(Text, Default, Callback)
        local SwitchFrame = Instance.new("ImageButton", Frame)
        SwitchFrame.Name = "Switch"
        SwitchFrame.LayoutOrder = #Frame:GetChildren()
        SwitchFrame.Active = false
        SwitchFrame.BackgroundTransparency = 1.000
        SwitchFrame.BorderSizePixel = 0
        SwitchFrame.Selectable = false
        SwitchFrame.Size = UDim2.new(1, 0, 0, 50)
        SwitchFrame.ZIndex = 2
        SwitchFrame.AutoButtonColor = false
        SwitchFrame.Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png"
        SwitchFrame.ImageColor3 = Color3.fromRGB(163, 162, 165)
        SwitchFrame.ImageTransparency = 1.000
        SwitchFrame.ScaleType = Enum.ScaleType.Slice
        SwitchFrame.SliceCenter = Rect.new(2, 2, 18, 18)

        SwitchFrame.MouseEnter:Connect(function()
            SwitchFrame.ImageTransparency = 0.5
        end)

        SwitchFrame.MouseLeave:Connect(function()
            SwitchFrame.ImageTransparency = 1
        end)

        local SwitchLabel = Instance.new("TextLabel", SwitchFrame)
        SwitchLabel.Name = "SwitchLabel"
        SwitchLabel.BackgroundTransparency = 1.000
        SwitchLabel.Position = UDim2.new(0, 10, 0, 0)
        SwitchLabel.Size = UDim2.new(0, 200, 1, 0)
        SwitchLabel.ZIndex = 2
        SwitchLabel.Font = Enum.Font.SourceSansBold
        SwitchLabel.Text = Text
        SwitchLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        SwitchLabel.TextSize = 24.000
        SwitchLabel.TextXAlignment = Enum.TextXAlignment.Left

        local Selector = Instance.new("ImageButton", SwitchFrame)
        Selector.Name = "Selector"
        Selector.AnchorPoint = Vector2.new(1, 0.5)
        Selector.BackgroundTransparency = 1.000
        Selector.Position = UDim2.new(1, 0, 0.5, 0)
        Selector.Size = UDim2.new(0.600000024, 0, 0, 50)
        Selector.ZIndex = 2
        Selector.AutoButtonColor = false

        local LeftButton = Instance.new("ImageButton", Selector)
        LeftButton.Name = "LeftButton"
        LeftButton.AnchorPoint = Vector2.new(0, 0.5)
        LeftButton.BackgroundTransparency = 1.000
        LeftButton.Position = UDim2.new(0, 0, 0.5, 0)
        LeftButton.Selectable = false
        LeftButton.Size = UDim2.new(0, 50, 0, 50)
        LeftButton.ZIndex = 3

        local LeftButtonIcon = Instance.new("ImageLabel", LeftButton)
        LeftButtonIcon.Name = "LeftButton"
        LeftButtonIcon.AnchorPoint = Vector2.new(0.5, 0.5)
        LeftButtonIcon.BackgroundTransparency = 1.000
        LeftButtonIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
        LeftButtonIcon.Size = UDim2.new(0, 18, 0, 30)
        LeftButtonIcon.ZIndex = 4
        LeftButtonIcon.Image = "rbxasset://textures/ui/Settings/Slider/Left.png"
        LeftButtonIcon.ImageColor3 = Color3.fromRGB(204, 204, 204)

        LeftButtonIcon.MouseEnter:Connect(function()
            LeftButtonIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
        end)

        LeftButtonIcon.MouseLeave:Connect(function()
            LeftButtonIcon.ImageColor3 = Color3.fromRGB(204, 204, 204)
        end)

        local RightButton = Instance.new("ImageButton", Selector)
        RightButton.Name = "RightButton"
        RightButton.AnchorPoint = Vector2.new(1, 0.5)
        RightButton.BackgroundTransparency = 1.000
        RightButton.Position = UDim2.new(1, 0, 0.5, 0)
        RightButton.Selectable = false
        RightButton.Size = UDim2.new(0, 50, 0, 50)
        RightButton.ZIndex = 3

        local RightButtonIcon = Instance.new("ImageLabel", RightButton)
        RightButtonIcon.Name = "RightButton"
        RightButtonIcon.AnchorPoint = Vector2.new(0.5, 0.5)
        RightButtonIcon.BackgroundTransparency = 1.000
        RightButtonIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
        RightButtonIcon.Size = UDim2.new(0, 18, 0, 30)
        RightButtonIcon.ZIndex = 4
        RightButtonIcon.Image = "rbxasset://textures/ui/Settings/Slider/Right.png"
        RightButtonIcon.ImageColor3 = Color3.fromRGB(204, 204, 204)

        RightButtonIcon.MouseEnter:Connect(function()
            RightButtonIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
        end)

        RightButtonIcon.MouseLeave:Connect(function()
            RightButtonIcon.ImageColor3 = Color3.fromRGB(204, 204, 204)
        end)

        local AutoSelectButton = Instance.new("ImageButton", Selector)
        AutoSelectButton.Name = "AutoSelectButton"
        AutoSelectButton.BackgroundTransparency = 1.000
        AutoSelectButton.Position = UDim2.new(0, 50, 0, 0)
        AutoSelectButton.Selectable = false
        AutoSelectButton.Size = UDim2.new(1, -100, 1, 0)
        AutoSelectButton.ZIndex = 2

        local Selection1 = Instance.new("TextLabel", Selector)
        Selection1.Name = "Selection"
        Selection1.BackgroundTransparency = 1.000
        Selection1.BorderSizePixel = 0
        Selection1.Position = UDim2.new(0, 50, 0, 0)
        Selection1.Size = UDim2.new(1, -100, 1, 0)
        Selection1.ZIndex = 2
        Selection1.Font = Enum.Font.SourceSans
        Selection1.Text = "On"
        Selection1.TextColor3 = Color3.fromRGB(255, 255, 255)
        Selection1.TextSize = 24.000
        Selection1.TextTransparency = 0.500

        local Selection2 = Instance.new("TextLabel", Selector)
        Selection2.Name = "Selection"
        Selection2.BackgroundTransparency = 1.000
        Selection2.BorderSizePixel = 0
        Selection2.Position = UDim2.new(0, -54, 0, 0)
        Selection2.Size = UDim2.new(1, -100, 1, 0)
        Selection2.ZIndex = 2
        Selection2.Font = Enum.Font.SourceSans
        Selection2.Text = "Off"
        Selection2.TextColor3 = Color3.fromRGB(255, 255, 255)
        Selection2.TextSize = 24.000
        Selection2.TextTransparency = 1.000

        Selection1.Visible = Default
        Selection2.Visible = not Default

        SwitchFrame.MouseEnter:Connect(function()
            Selection1.TextTransparency = 0
            Selection2.TextTransparency = 0
        end)
        
        SwitchFrame.MouseLeave:Connect(function()
            Selection1.TextTransparency = 0.500
            Selection2.TextTransparency = 0.500
        end)

        if Default then
            Callback(true)
            Selection1.Visible = true
            Selection2.Visible = false
        else
            Callback(false)
            Selection1.Visible = false
            Selection2.Visible = true
            Selection2.Position = UDim2.new(0.1, 0, 0, 0)
            Selection2.TextTransparency = 0.5
            Selection1.Position = UDim2.new(0.5, 0, 0, 0)
            Selection1.TextTransparency = 1
        end

        local Debounce = 0
        RightButton.MouseButton1Down:Connect(function()
            if Debounce + 0.1 > os.clock() then return end
            Default = not Default

            local Visible, Hidden
            if Default then
                Visible = Selection1
                Hidden = Selection2
            else
                Visible = Selection2
                Hidden = Selection1
            end

            Hidden:TweenPosition(UDim2.new(0.25, 0, 0, 0), "Out", "Sine", 0.2)

            game:GetService("TweenService"):Create(Hidden, TweenInfo.new(0.2), {
                TextTransparency = 1
            }):Play()

            Callback(Default)

            Visible.Position = UDim2.new(-0.05, 0, 0, 0)
            Visible.Visible = true

            game:GetService("TweenService"):Create(Visible, TweenInfo.new(0.2), {
                TextTransparency = 0
            }):Play()

            Visible:TweenPosition(UDim2.new(0.1, 0, 0, 0), "Out", "Sine", 0.2)

            wait(0.1)

            Hidden.Visible = false
            Debounce = os.clock()
        end)

        LeftButton.MouseButton1Down:Connect(function()
            if Debounce + 0.1 > os.clock() then return end
            Default = not Default

            local Visible, Hidden
            if Default then
                Visible = Selection1
                Hidden = Selection2
            else
                Visible = Selection2
                Hidden = Selection1
            end

            Hidden:TweenPosition(UDim2.new(-0.05, 0, 0, 0), "Out", "Sine", 0.2)

            game:GetService("TweenService"):Create(Hidden, TweenInfo.new(0.2), {
                TextTransparency = 1
            }):Play()

            Callback(Default)

            Visible.Position = UDim2.new(0.25, 0, 0, 0)
            Visible.Visible = true

            game:GetService("TweenService"):Create(Visible, TweenInfo.new(0.2), {
                TextTransparency = 0
            }):Play()

            Visible:TweenPosition(UDim2.new(0.1, 0, 0, 0), "Out", "Sine", 0.2)

            wait(0.1)

            Hidden.Visible = false
            Debounce = os.clock()
        end)
    end

    Section.Slider = function(Text, Default, Minimum, Maximum, Callback)
        local Default = Default or 1
        local Minimum = Minimum or 0
        local Maximum = Maximum or 10

        local function lerp(a, b, t)
            return a + (b - a) * t
        end
        
        local LeftButton = Instance.new("ImageButton")
        local LeftButton_2 = Instance.new("ImageLabel")
        local RightButton = Instance.new("ImageButton")
        local RightButton_2 = Instance.new("ImageLabel")

        local SliderFrame = Instance.new("ImageButton", Frame)
        SliderFrame.Name = "Slide"
        SliderFrame.LayoutOrder = #Frame:GetChildren()
        SliderFrame.Active = false
        SliderFrame.BackgroundTransparency = 1.000
        SliderFrame.BorderSizePixel = 0
        SliderFrame.Position = UDim2.new(0, 0, 0, 250)
        SliderFrame.Selectable = falsew
        SliderFrame.Size = UDim2.new(1, 0, 0, 50)
        SliderFrame.ZIndex = 2
        SliderFrame.AutoButtonColor = false
        SliderFrame.Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png"
        SliderFrame.ImageColor3 = Color3.fromRGB(163, 162, 165)
        SliderFrame.ImageTransparency = 1.000
        SliderFrame.ScaleType = Enum.ScaleType.Slice
        SliderFrame.SliceCenter = Rect.new(2, 2, 18, 18)

        local SliderLabel = Instance.new("TextLabel", SliderFrame)
        SliderLabel.Name = "Label"
        SliderLabel.BackgroundTransparency = 1.000
        SliderLabel.Position = UDim2.new(0, 10, 0, 0)
        SliderLabel.Size = UDim2.new(0, 200, 1, 0)
        SliderLabel.ZIndex = 2
        SliderLabel.Font = Enum.Font.SourceSansBold
        SliderLabel.Text = Text
        SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        SliderLabel.TextSize = 24.000
        SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

        local Slider = Instance.new("ImageButton", SliderFrame)
        Slider.Name = "Slider"
        Slider.AnchorPoint = Vector2.new(1, 0.5)
        Slider.BackgroundTransparency = 1.000
        Slider.Position = UDim2.new(1, 0, 0.5, 0)
        Slider.Size = UDim2.new(0.600000024, 0, 0, 50)
        Slider.ZIndex = 2
        Slider.AutoButtonColor = false

        SliderFrame.MouseEnter:Connect(function()
            SliderFrame.ImageTransparency = 0.5
        end)

        SliderFrame.MouseLeave:Connect(function()
            SliderFrame.ImageTransparency = 1
        end)

        local StepsContainer = Instance.new("Frame", Slider)
        StepsContainer.Name = "StepsContainer"
        StepsContainer.AnchorPoint = Vector2.new(0.5, 0.5)
        StepsContainer.BackgroundTransparency = 1.000
        StepsContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
        StepsContainer.Size = UDim2.new(1, -100, 1, 0)

        local Steps = {}

        for i = 1, 10 do
            local Step = Instance.new("ImageButton", StepsContainer)
            Step.Name = string.format("Step%d", i)
            Step.Active = false
            Step.AnchorPoint = Vector2.new(0, 0.5)
            Step.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
            Step.BackgroundTransparency = 0.36
            Step.BorderSizePixel = 0
            Step.Position = UDim2.new(0.1 * (i - 1), 2, 0.5, 0)
            Step.Size = UDim2.new(0.1, -4, 0.47999, 0)
            Step.ZIndex = 3
            Step.AutoButtonColor = false
            Step.ImageTransparency = 0.36

            Step.MouseButton1Down:Connect(function()
                Default = i
                Callback(lerp(Minimum, Maximum, Default / 10))

                for v = 1, 10 do
                    if v > Default then
                        Steps[v].BackgroundColor3 = Color3.fromRGB(78, 84, 96)
                    else
                        Steps[v].BackgroundColor3 = Color3.fromRGB(0, 162, 255)
                    end
                end
            end)

            table.insert(Steps, Step)
        end

        for v = 1, 10 do
            if v > 1 / (Maximum / Default) * 10 then
                Steps[v].BackgroundColor3 = Color3.fromRGB(78, 84, 96)
            else
                Steps[v].BackgroundColor3 = Color3.fromRGB(0, 162, 255)
            end
        end

        LeftButton.Name = "LeftButton"
        LeftButton.Parent = Slider
        LeftButton.AnchorPoint = Vector2.new(0, 0.5)
        LeftButton.BackgroundTransparency = 1.000
        LeftButton.Position = UDim2.new(0, 0, 0.5, 0)
        LeftButton.Selectable = false
        LeftButton.Size = UDim2.new(0, 50, 0, 50)
        LeftButton.ZIndex = 3

        LeftButton_2.Name = "LeftButton"
        LeftButton_2.Parent = LeftButton
        LeftButton_2.AnchorPoint = Vector2.new(0.5, 0.5)
        LeftButton_2.BackgroundTransparency = 1.000
        LeftButton_2.Position = UDim2.new(0.5, 0, 0.5, 0)
        LeftButton_2.Size = UDim2.new(0, 30, 0, 30)
        LeftButton_2.ZIndex = 4
        LeftButton_2.Image = "rbxasset://textures/ui/Settings/Slider/Less.png"
        LeftButton_2.ImageColor3 = Color3.fromRGB(204, 204, 204)

        RightButton.Name = "RightButton"
        RightButton.Parent = Slider
        RightButton.AnchorPoint = Vector2.new(1, 0.5)
        RightButton.BackgroundTransparency = 1.000
        RightButton.Position = UDim2.new(1, 0, 0.5, 0)
        RightButton.Selectable = false
        RightButton.Size = UDim2.new(0, 50, 0, 50)
        RightButton.ZIndex = 3

        RightButton_2.Name = "RightButton"
        RightButton_2.Parent = RightButton
        RightButton_2.AnchorPoint = Vector2.new(0.5, 0.5)
        RightButton_2.BackgroundTransparency = 1.000
        RightButton_2.Position = UDim2.new(0.5, 0, 0.5, 0)
        RightButton_2.Size = UDim2.new(0, 30, 0, 30)
        RightButton_2.ZIndex = 4
        RightButton_2.Image = "rbxasset://textures/ui/Settings/Slider/More.png"
        RightButton_2.ImageColor3 = Color3.fromRGB(204, 204, 204)

        RightButton_2.MouseEnter:Connect(function()
            RightButton_2.ImageColor3 = Color3.fromRGB(255, 255, 255)
        end)
        
        RightButton_2.MouseLeave:Connect(function()
            RightButton_2.ImageColor3 = Color3.fromRGB(204, 204, 204)
        end)

        LeftButton_2.MouseEnter:Connect(function()
            LeftButton_2.ImageColor3 = Color3.fromRGB(255, 255, 255)
        end)
        
        LeftButton_2.MouseLeave:Connect(function()
            LeftButton_2.ImageColor3 = Color3.fromRGB(204, 204, 204)
        end)

        LeftButton.MouseButton1Down:Connect(function()
            if Default - 1 < 0 then return end
            
            Default = Default - 1
            Callback(lerp(Minimum, Maximum, Default / 10))

            for v = 1, 10 do
                if v > Default then
                    Steps[v].BackgroundColor3 = Color3.fromRGB(78, 84, 96)
                else
                    Steps[v].BackgroundColor3 = Color3.fromRGB(0, 162, 255)
                end
            end
        end)

        RightButton.MouseButton1Down:Connect(function()
            if Default + 1 > 10 then return end

            Default = Default + 1
            Callback(lerp(Minimum, Maximum, Default / 10))

            for v = 1, 10 do
                if v > Default then
                    Steps[v].BackgroundColor3 = Color3.fromRGB(78, 84, 96)
                else
                    Steps[v].BackgroundColor3 = Color3.fromRGB(0, 162, 255)
                end
            end
        end)
    end

    Section.Divider = function(Text, Description)
        local TitleContainer = Instance.new("Frame", Frame)
        TitleContainer.Name = "SectionTitle"
        TitleContainer.BackgroundTransparency = 1
        TitleContainer.LayoutOrder = #Frame:GetChildren()
        TitleContainer.Size = UDim2.new(1, 0, 0, 36)
        TitleContainer.ZIndex = 2

        local Title = Instance.new("TextLabel", TitleContainer)
        Title.Name = "Title"
        Title.Font = Enum.Font.SourceSansBold
        Title.Text = Text
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextSize = 36
        Title.TextWrapped = true
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.TextYAlignment = Enum.TextYAlignment.Top
        Title.BackgroundTransparency = 1
        Title.Position = UDim2.fromOffset(10, 0)
        Title.Size = UDim2.new(1, -10, 1, 0)
        Title.ZIndex = 2

        if Description then
            local Body = Instance.new("TextLabel", Frame)
            Body.LayoutOrder = #Frame:GetChildren()
            Body.AutomaticSize = Enum.AutomaticSize.Y
            Body.Name = "Body"
            Body.Font = Enum.Font.SourceSans
            Body.Text = "\t\t" .. string.gsub(Description, "\n", "\n\t\t")
            Body.TextColor3 = Color3.fromRGB(255, 255, 255)
            Body.TextSize = 24
            Body.TextWrapped = true
            Body.TextXAlignment = Enum.TextXAlignment.Left
            Body.TextYAlignment = Enum.TextYAlignment.Top
            Body.BackgroundTransparency = 1
            Body.Position = UDim2.fromOffset(10, 0)
            Body.Size = UDim2.new(1, -10, 0, 0)
            Body.ZIndex = 2
        end
    end

    return Section
end

return Library
