local module = ... or D:module("sleeve_selector")

local PlayerMovement = module:hook_class("PlayerMovement")

local mesh_names = {
	["suit"] = { -- Suburbia shares the same values
		russian = "_dallas",
		american = "_hoxton",
		german = "",
		spanish = "_chains",
	},
	-- scrubs look identical to cat_suit, they also share the same values
	["cat_suit"] = {
		russian = "",
		american = "",
		german = "",
		spanish = "_chains",
	},
}

module:hook(50, PlayerMovement, "set_character_anim_variables", function(self)
	local preferred_character = D:conf("ss_selected_character") or "default"

	local character_name = preferred_character
	if preferred_character == "default" then
		character_name = managers.criminals:character_name_by_unit(self._unit)
	end

	local selected_suit = managers.player.selected_suit

	local selected_mesh = mesh_names[selected_suit] or mesh_names["suit"]
	local mesh_name = Idstring("g_fps_hand" .. selected_mesh[character_name])
	if not D:conf("ss_disable_sleeve_swap") and (selected_suit == "default" or selected_suit == "suit") then
		local suffix = managers.player._player_mesh_suffix
		if suffix == "_scubs" then
			mesh_name = Idstring("g_fps_hand" .. mesh_names["cat_suit"][character_name] .. suffix)
		end
	end

	local camera_unit = self._unit:camera():camera_unit()
	local mesh_obj = camera_unit:get_object(mesh_name)
	if mesh_obj then
		if self._plr_mesh_name then
			local old_mesh_obj = camera_unit:get_object(self._plr_mesh_name)
			if old_mesh_obj then
				old_mesh_obj:set_visibility(false)
			end
		end

		self._plr_mesh_name = mesh_name
		mesh_obj:set_visibility(true)
	end
end)
