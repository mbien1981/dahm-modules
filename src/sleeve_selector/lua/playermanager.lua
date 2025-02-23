local module = ... or D:module("sleeve_selector")

local PlayerManager = module:hook_class("PlayerManager")
module:post_hook(50, PlayerManager, "init", function(self)
	local level = Global.level_data and Global.level_data.level_id or "bank"

	self.selected_suit = D:conf("sleeve_selector_" .. level) or "default"
end)
