return DMod:new("spectator_camera_fov", {
	name = "Spectator camera fov",
	author = "_atom",
	version = "1.1",
	categories = { "gameplay", "QoL" },
	includes = {
		{ "mod_localization", { type = "localization" } },
		{ "mod_options", { type = "menu_options" } },
		{ "mod_hooks" },
	},
	hooks = {
		{
			"post_require",
			"lib/states/ingamewaitingforrespawn",
			function(module)
				local IngameWaitingForRespawnState = module:hook_class("IngameWaitingForRespawnState")
				module:post_hook(IngameWaitingForRespawnState, "_setup_camera", function(self)
					self._camera_object:set_fov(math.floor(D:conf("mod_spectator_camera_fov") or 75))
				end)
			end,
		},
	},
})
