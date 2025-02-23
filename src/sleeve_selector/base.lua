return DMod:new("sleeve_selector", {
	name = "Sleeve selector",
	author = "_atom",
	version = "1.4",
	includes = {
		{ "mod_localization", { type = "localization" } },
		{ "mod_options", { type = "menu_options" } },
	},
	hooks = {
		{ "lib/setups/gamesetup", "lua/gamesetup" },
		{ "lib/managers/playermanager", "lua/playermanager" },
		{ "lib/units/beings/player/playercamera", "lua/playercamera" },
		{ "lib/units/beings/player/playermovement", "lua/playermovement" },
	},
	update = { id = "sleeve_selector", url = "https://raw.githubusercontent.com/mbien1981/dahm-modules/main/version.json" },
})
