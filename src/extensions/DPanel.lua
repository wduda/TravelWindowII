import "Turbine.Gameplay"
import "Turbine.UI"
import "Turbine.UI.Lotro"
import "TravelWindowII.src.extensions"

DPanel = class(Turbine.UI.Control)

function DPanel:Constructor()
    Turbine.UI.Control.Constructor(self)

    self.tabButtons = {}
    self.tabPages = {}
    self.pageCount = 0
    self.selectedPage = 0
    self.lastPage = 0
    self.showButtons = true
    self.imagePathsSet = false
    self.lastTime = 0
    self.UpdateLayout = nil
end

function DPanel:SetButtonBackground(l, c, r, lh, ch, rh)
    self.imagePathsSet = false
    if not l or not c or not r or not lh or not ch or not rh then return end
    self.left = l
    self.center = c
    self.right = r
    self.leftHighlight = lh
    self.centerHighlight = ch
    self.rightHighlight = rh
    self.imagePathsSet = true
end

function DPanel:SizeChanged(sender, args)
    if not self.selectedPage then return end
    local panel = self.tabPages[self.selectedPage]
    if panel and self.UpdateLayout then
        self:UpdateLayout(panel)
    end
    self:UpdateTabs()
end

function DPanel:SelectTab(value)
    self.selectedPage = value
    if self.lastPage ~= self.selectedPage then
        if self.pageCount > 0 then
            if self.lastPage > 0 then
                -- disable the last selected tab
                self.tabButtons[self.lastPage]:SetSelected(false)
                self.tabPages[self.lastPage]:SetVisible(false)
            end

            -- enable the selected tab
            self.tabButtons[self.selectedPage]:SetSelected(true)
            local panel = self.tabPages[self.selectedPage]
            panel:SetVisible(true)
            if self.UpdateLayout then
                self:UpdateLayout(panel)
            end
            if self.imagePathsSet then
                self:UpdateTabs()
            end

            self.lastPage = self.selectedPage
        end
    end
end

function DPanel:AddTab(Tab)
    if Tab == nil then return end
    self.pageCount = self.pageCount + 1

    Tab:SetVisible(true)
    Tab:SetParent(self)
    Tab:SetPosition(0, 25)
    Tab:SetSize(self:GetWidth(), self:GetHeight() - 25)

    local btn = TravelWindowII.src.extensions.DTabButton()
    btn:SetParent(self)
    btn:SetIndex(self.pageCount)
    btn:SetMouseClickedEvent(function(_, _)
        self:SelectTab(btn:GetIndex())
    end)
    if self.selectedPage == 0 then
        self.selectedPage = 1
        btn:SetSelected(true)
    end
    btn:SetButtonBackground(
        self.left, self.center, self.right,
        self.leftHighlight, self.centerHighlight, self.rightHighlight
    )

    table.insert(self.tabButtons, btn)
    table.insert(self.tabPages, Tab)

    self:UpdateTabs()
end

function DPanel:UpdateTabs()
    for i = 1, self.pageCount, 1 do
        if self.showButtons then
            self.tabPages[i]:SetSize(self:GetWidth(), self:GetHeight() - 25)
            self.tabPages[i]:SetPosition(0, 25)
            self.tabButtons[i]:SetPosition(
                (i - 1) * (self:GetWidth() / self.pageCount), 0)
            self.tabButtons[i]:SetWidth(self:GetWidth() / self.pageCount)
            self.tabButtons[i]:SetHeight(25)
            self.tabButtons[i]:SetVisible(true)
        else
            self.tabPages[i]:SetSize(self:GetSize())
            self.tabPages[i]:SetPosition(0, 0)
            self.tabButtons[i]:SetVisible(false)
        end

        self.tabButtons[i]:SetSelected(false)
        self.tabPages[i]:SetVisible(false)
    end

    if self.selectedPage ~= 0 then
        self.tabPages[self.selectedPage]:SetVisible(true)
        self.tabButtons[self.selectedPage]:SetSelected(true)
        self:SetVisible(false)
        self:SetVisible(true)
    end
end

function DPanel:SetButtonsVisible(value)
    self.showButtons = value
    self:UpdateTabs()
end

function DPanel:SetTabText(index, value)
    self.tabButtons[index]:SetText(value)
    self:UpdateTabs()
end
