module:add_config_option("mod_spectator_camera_fov", 75)
module:add_config_option("mod_spectator_camera_enable_scroll", true)

local update_spectator_fov = function(_, value)
	if not Util:is_in_state("ingame_waiting_for_respawn") then
		return
	end

	local state = game_state_machine:current_state()
	if not state._camera_object then
		return
	end

	state._camera_object:set_fov(math.floor(value))
end

-- menu nodes
module:add_menu_option("mod_spectator_camera_enable_scroll", {
	type = "boolean",
	text_id = "mod_spectator_camera_enable_scroll",
	help_id = "mod_spectator_camera_enable_scroll_help",
	localize = true,
})

module:add_menu_option("mod_spectator_camera_fov", {
	type = "slider",
	text_id = "menu_spectator_camera_fov",
	min = 50,
	max = 120,
	step = 10,
	show_value = true,
	callback = update_spectator_fov,
})
