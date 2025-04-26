return DMod:new("custom_mask_selector", {
	name = "Custom Mask Selector Interface",
	author = "_atom",
	version = "2.2",
	categories = { "qol" },
	dependencies = { "[drop_in_menu]", "[character_n_mask_in_loadout]" },
	hooks = {
		{ "post_require", "lib/setups/setup", "mask_selector" },
		{ "post_require", "lib/states/ingamewaitingforplayers", "mask_selector" },
		{ "post_require", "lib/managers/menumanager", "mask_selector" },
	},
	update = {
		id = "mask_selector",
		url = "https://raw.githubusercontent.com/mbien1981/dahm-modules/main/version.json",
	},
})
