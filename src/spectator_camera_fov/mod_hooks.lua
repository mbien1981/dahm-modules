local change_fov_value = function(value)
	if not D:conf("mod_spectator_camera_enable_scroll") then
		return
	end

	local current_fov = math.floor(D:conf("mod_spectator_camera_fov"))
	local new_fov = math.max(math.min(current_fov + value, 120), 50)

	D:set_config_option("mod_spectator_camera_fov", new_fov, true)
	module:update_persist_setting("mod_spectator_camera_fov", new_fov, true)

	managers.hud:show_hint({
		text = managers.localization:text("menu_spectator_camera_fov_set", {
			FOV = new_fov,
		}),
		time = 2.5,
	})

	local state = game_state_machine:current_state()
	if state._camera_object then
		state._camera_object:set_fov(new_fov)
	end
end

module:hook("OnKeyPressed", "increase_fov", "mouse wheel down", "GAME", "PRESSED", function()
	if not Util:is_in_state("ingame_waiting_for_respawn") then
		return
	end

	change_fov_value(5)
end)

module:hook("OnKeyPressed", "decrease_fov", "mouse wheel up", "GAME", "PRESSED", function()
	if not Util:is_in_state("ingame_waiting_for_respawn") then
		return
	end

	change_fov_value(-5)
end)
