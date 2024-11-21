import "Turbine.Gameplay"
import "Turbine.UI"
import "Turbine.UI.Lotro"

-- FontMetric is copied from Garan's MoorMap
FontMetric = class( Turbine.UI.Label );
function FontMetric:Constructor()
	Turbine.UI.Control.Constructor( self );
	self.Text=Turbine.UI.Label();
	self.Text:SetParent(self);
	self.VScroll=Turbine.UI.Lotro.ScrollBar();
	self.VScroll:SetOrientation(Turbine.UI.Orientation.Vertical);
	self.VScroll:SetParent(self);
	self.Text:SetVerticalScrollBar(self.VScroll);
	self.HScroll=Turbine.UI.Lotro.ScrollBar();
	self.HScroll:SetOrientation(Turbine.UI.Orientation.Horizontal);
	self.HScroll:SetParent(self);
	self.Text:SetHorizontalScrollBar(self.HScroll);
	self.fontHeight=12;
	self.SetFont=function(sender,font)
		self.Text:SetFont(font);
		if Turbine.UI.Lotro.FontInfo[font]~=nil then
			self.fontHeight=Turbine.UI.Lotro.FontInfo[font].size
		else
			self.fontHeight=self:GetHeight()
		end
	end
	self.GetTextWidth=function(sender,text,height)
		if height==nil or height<self.fontHeight then height=self.fontHeight end
		local width=0
		if text~=nil and text~="" then
			self.Text:SetHeight(height);
			self.Text:SetMultiline(false);
			width=string.len(text);
			self.Text:SetText(text);
			self.Text:SetWidth(width);
			while self.HScroll:IsVisible() do
				width=width+1;
				self.Text:SetWidth(width);
			end
		end
		return width;
	end
	self.GetTextHeight=function(sender,text,width)
		if width~=nil then
			-- since we don't actually have a minimum width for a single character, use the point size as a good estimate - this is needed to prevent possible infinite loop issues
			if width<self.fontHeight then width=self.fontHeight end
			self.Text:SetWidth(width)
		end
		local height=self.fontHeight
		self.Text:SetMultiline(true);
		if text~=nil and text~="" then
			self.Text:SetText(text);
			self.Text:SetHeight(height);
			while self.HScroll:IsVisible() or self.VScroll:IsVisible() do
				height=height+1;
				self.Text:SetHeight(height);
			end
		end
		return height;
	end
end
