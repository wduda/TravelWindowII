--[[
    This is an extension of the Turbine Control class used to create
    a button composed of 3 images that can be used on a tab panel.
]] --
import "Turbine.UI"
import "Turbine.UI.Lotro"

DTabButton = class(Turbine.UI.Control)

function DTabButton:Constructor()
    Turbine.UI.Control.Constructor(self)

    self.selected = false
    self.mouseOver = false
    self.index = 0
    self.lastTime = 0
    self.imagePathsSet = false
    self.leftImage = nil
    self.centerImage = nil
    self.rightImage = nil
    self.leftHighlightImage = nil
    self.centerHighlightImage = nil
    self.rightHighlightImage = nil

    -- Create the 3 buttons that will be used to hold the images
    self.left = Turbine.UI.Button()
    self.left:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend)
    self.left:SetSize(12, 29)
    self.left:SetPosition(0, 0)
    self.left:SetParent(self)

    self.center = Turbine.UI.Button()
    self.center:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend)
    self.center:SetSize(self:GetWidth() - 28, 29)
    self.center:SetPosition(12, 0)
    self.center:SetParent(self)
    self.center:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)

    self.right = Turbine.UI.Button()
    self.right:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend)
    self.right:SetPosition(self:GetWidth() - 18, 0)
    self.right:SetSize(16, 29)
    self.right:SetParent(self)

    local MouseEnter = function(_, _)
        self.mouseOver = true
        self:UpdateVisual()
    end
    local MouseLeave = function(_, _)
        self.mouseOver = false
        self:UpdateVisual()
    end
    self.left.MouseEnter = MouseEnter
    self.center.MouseEnter = MouseEnter
    self.right.MouseEnter = MouseEnter

    self.left.MouseLeave = MouseLeave
    self.center.MouseLeave = MouseLeave
    self.right.MouseLeave = MouseLeave

    self.SizeChanged = function(_, _)
        self.center:SetSize(self:GetWidth() - 28, 29)
        self.right:SetPosition(self:GetWidth() - 18, 0)
    end
end

function DTabButton:SetMouseClickedEvent(event)
    self.left.MouseClick = event
    self.center.MouseClick = event
    self.right.MouseClick = event
end

function DTabButton:SetButtonBackground(a, b, c, d, e, f)
    self.imagePathsSet = false
    if not a or not b or not c or not d or not e or not f then return end
    self.leftImage = a
    self.centerImage = b
    self.rightImage = c
    self.leftHighlightImage = d
    self.centerHighlightImage = e
    self.rightHighlightImage = f
    self.imagePathsSet = true
    self:UpdateVisual()
end

function DTabButton:SetSelected(value)
    if type(value) ~= "boolean" then
        self.selected = nil
        error(
            string.format("Invalid input %q for DTabButton:SetSelected", value))
        return
    end

    self.selected = value
    self:UpdateVisual()
end

function DTabButton:IsSelected() return self.selected end

function DTabButton:SetIndex(value)
    if type(value) ~= "number" then
        self.index = 0
        error(string.format("Invalid input arg for DTabButton:SetIndex.  %q",
                            value))
        return
    end

    if value < 0 then
        self.index = 0
        error(string.format(
                  "Input for DTabButton:SetIndex should not be negative"))
        return
    end

    self.index = value
end

function DTabButton:GetIndex() return self.index end

function DTabButton:SetText(value)
    if type(value) ~= "string" then
        self.center:SetText("Error")
        error(string.format("Invalid arguement for DTabButton:SetText.  %q",
                            value))
        return
    end

    self.center:SetText(value)
end

function DTabButton:GetText() return self.center:GetText() end

function DTabButton:UpdateVisual()
    if not self.imagePathsSet then return end
    if self.selected or self.mouseOver then
        self.left:SetBackground(self.leftHighlightImage)
        self.center:SetBackground(self.centerHighlightImage)
        self.right:SetBackground(self.rightHighlightImage)
    else
        self.left:SetBackground(self.leftImage)
        self.center:SetBackground(self.centerImage)
        self.right:SetBackground(self.rightImage)
    end
end
