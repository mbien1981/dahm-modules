local module = ... or D:module("mute_civilians")

module:add_config_option("mute_on_loud", true)
module:add_config_option("mute_male", false)
module:add_config_option("mute_female", true)
module:add_config_option("mute_bank_manager", false)
module:add_config_option("mute_escorts", false)

module:add_menu_option("mute_on_loud", {
	type = "boolean",
	text_id = "menu_mute_civilians_on_loud",
	help_id = "menu_mute_civilians_on_loud_help",
	localize = true,
})
module:add_menu_option("mute_divider", { type = "divider", size = 15 })
module:add_menu_option("mute_male", { type = "boolean", text_id = "menu_mute_male", localize = true })
module:add_menu_option("mute_female", { type = "boolean", text_id = "menu_mute_female", localize = true })
module:add_menu_option("mute_bank_manager", { type = "boolean", text_id = "menu_mute_bank_manager", localize = true })
module:add_menu_option("mute_escorts", { type = "boolean", text_id = "menu_mute_escorts", localize = true })
