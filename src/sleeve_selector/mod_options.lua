local module = ... or D:module("sleeve_selector")

module:add_config_option("ss_selected_character", "default")

local levels = {
	"bank",
	"heat_street",
	"apartment",
	"bridge",
	"diamond_heist",
	"slaughter_house",
	"suburbia",
	"secret_stash",
	"hospital",
}

-- menu nodes
module:add_menu_option("ss_selected_character", {
	type = "multi_choice",
	text_id = "ss_loc_default_character",
	choices = {
		{ "default", "ss_loc_selected_character" },
		{ "russian", "debug_russian" },
		{ "american", "debug_american" },
		{ "german", "debug_german" },
		{ "spanish", "debug_spanish" },
	},
	default_value = "default",
})

module:add_menu_option("ss_divider", { type = "divider", size = 15 })

for _, level in pairs(levels) do
	module:add_config_option("sleeve_selector_" .. level, "default")

	module:add_menu_option("sleeve_selector_" .. level, {
		type = "multi_choice",
		text_id = "debug_" .. level:gsub("heat_", ""),
		choices = {
			{ "default", "ss_loc_default_sleeves" },
			{ "suit", "ss_loc_suit" },
			{ "raincoat", "ss_loc_raincoat" },
			{ "cat_suit", "ss_loc_cat_suit" },
			{ "suburbia", "ss_loc_suburbia" },
		},
		default_value = "default",
	})
end

module:add_menu_option("ss_disable_sleeve_swap", {
	type = "boolean",
	text_id = "ss_loc_disable_sleeve_swap",
	default_value = false,
})