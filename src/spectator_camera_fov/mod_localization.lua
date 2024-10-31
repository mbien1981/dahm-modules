local module = ... or D:module("spectator_camera_fov")

module:add_localization_string("mod_spectator_camera_enable_scroll", {
	english = "Enable mouse scrolling",
})

module:add_localization_string("mod_spectator_camera_enable_scroll_help", {
	english = "Allow changing the camera fov by using the scroll wheel",
})

module:add_localization_string("menu_spectator_camera_fov", {
	english = "Spectator camera FOV",
})

module:add_localization_string("menu_spectator_camera_fov_set", {
	english = "FOV set to: $FOV;",
})
