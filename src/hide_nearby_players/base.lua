return DMod:new("hide_nearby_players", {
	abbr = "HNP",
	name = "Hide Nearby Players",
	description = "Hides players that are very close to you, especially Jalopy's ass.",
	version = "1",
	categories = { "gameplay", "qol" },
	hooks = {
		{
			"lib/network/extensions/player/huskplayermovement",
			function(module)
				local HuskPlayerMovement = module:hook_class("HuskPlayerMovement")
				module:post_hook(HuskPlayerMovement, "update", function(self)
					if not alive(self._unit) then
						return
					end

					local punit = managers.player:player_unit()
					local inventory_ext = self._unit:inventory()
					local equipped_unit = inventory_ext and inventory_ext:equipped_unit()
					if not alive(punit) then
						if not self._unit:visible() then
							self._unit:set_visible(true)
						end

						if
							inventory_ext
							and inventory_ext._mask_visibility
							and alive(inventory_ext._mask_unit)
							and not inventory_ext._mask_unit:visible()
						then
							inventory_ext._mask_unit:set_visible(true)
						end

						if alive(equipped_unit) and not equipped_unit:visible() then
							equipped_unit:set_visible(true)
						end

						return
					end

					local is_downed = self:current_state_name() ~= "standard"
					local visibility = is_downed or mvector3.distance(punit:position(), self._unit:position()) > 200

					self._unit:set_visible(visibility)

					if inventory_ext and inventory_ext._mask_visibility and alive(inventory_ext._mask_unit) then
						inventory_ext._mask_unit:set_visible(visibility)
					end

					if alive(equipped_unit) then
						equipped_unit:set_visible(visibility)
					end
				end)
			end,
		},
	},
	update = { id = "hnp", url = "https://raw.githubusercontent.com/mbien1981/dahm-modules/main/version.json" },
})
