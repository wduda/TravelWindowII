import "Turbine.UI"

DragDropCapture = class(Turbine.UI.Window)
function DragDropCapture:Constructor()
    Turbine.UI.Window.Constructor(self)
    self:SetPosition(0, 0);
    self:SetMouseVisible(true)
    self:SetAllowDrop(true)
    self:SetZOrder(100000)
    self.watch = nil
    self.DragDropInternal = function(sender, args) end
    self.DragDropExternal = function(sender, args) end
    self.DragDrop = function(_, args)
        if self.watch then
            local wXPos, wYPos = self.watch:GetPosition()
            local wWidth, wHeight = self.watch:GetSize()
            local x, y = Turbine.UI.Display.GetMousePosition()
            if x > wXPos and x < wXPos + wWidth and
                    y > wYPos and y < wYPos + wHeight then
                self:DragDropInternal(args)
            else
                self:DragDropExternal(args)
            end
        end

        self:Reset()
    end
end

function DragDropCapture:Show(watch)
    if watch == nil then return end
    self:SetSize(Turbine.UI.Display.GetSize())
    self:SetVisible(true)
    self.watch = watch
end

function DragDropCapture:Reset()
    self:SetVisible(false)
    self.watch = nil
end
