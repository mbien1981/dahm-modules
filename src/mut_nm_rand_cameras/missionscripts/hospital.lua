local default_create = {
	{
		id = 900000,
		class = "ElementFilter",
		editor_name = "4Players",
		values = {
			enabled = true,
			execute_on_startup = false,
			execute_on_restart = false,
			on_executed = {
				{ id = 900001, delay = 0 }, -- Randomly choose amount of cameras
			},
			player_1 = false,
			player_2 = false,
			player_3 = false,
			player_4 = true,
			platform_win32 = true,
			difficulty_easy = false,
			difficulty_hard = false,
			difficulty_normal = false,
			difficulty_overkill = true,
			difficulty_overkill_145 = true,
			difficulty_overkill_193 = true,
			mode_control = true,
			mode_assault = true,
		},
	},
	{
		id = 900001,
		class = "ElementRandom",
		module = "CoreElementRandom",
		editor_name = "initial_roll_for_twelve_cameras",
		values = {
			enabled = true,
			execute_on_startup = false,
			execute_on_restart = false,
			on_executed = {
				{ id = 900002, delay = 0 },
				{ id = 900008, delay = 0 },
			},
			amount = 1,
		},
	},
	{
		id = 900002,
		class = "MissionScriptElement",
		editor_name = "logic_link_bain_has_intel_on_twelve_cameras",
		values = {
			enabled = true,
			on_executed = {
				{ id = 900003, delay = 0 }, -- remove cameras
				{ id = 900004, delay = 0 }, -- toggle logic operator
				{ id = 900006, delay = 0 }, -- toggle dialogue
			},
		},
	},
	{
		id = 900003,
		class = "ElementRandom",
		module = "CoreElementRandom",
		editor_name = "set_camera_count_to_twelve",
		values = {
			enabled = true,
			on_executed = {
				{ id = 700118, delay = 0 },
				{ id = 700132, delay = 0 },
				{ id = 700144, delay = 0 },
				{ id = 700130, delay = 0 },
				{ id = 700120, delay = 0 },
				{ id = 700143, delay = 0 },
				{ id = 700145, delay = 0 },
				{ id = 700134, delay = 0 },
				{ id = 700146, delay = 0 },
				{ id = 700147, delay = 0 },
				{ id = 700123, delay = 0 },
				{ id = 700148, delay = 0 },
				{ id = 700149, delay = 0 },
				{ id = 700150, delay = 0 },
				{ id = 700151, delay = 0 },
				{ id = 700139, delay = 0 },
				{ id = 700128, delay = 0 },
				{ id = 700153, delay = 0 },
				{ id = 700129, delay = 0 },
				{ id = 700136, delay = 0 },
			},
			amount = 8,
		},
	},
	{
		id = 900004,
		class = "ElementToggle",
		module = "CoreElementToggle",
		editor_name = "toggle_counter_for_twelve_cameras",
		values = {
			enabled = true,
			on_executed = {},
			elements = { 900005 },
		},
	},
	{
		id = 900005,
		class = "ElementCounter",
		editor_name = "logic_counter_for_twelve_cameras",
		values = {
			enabled = false,
			on_executed = {
				{ id = 700165, delay = 0 },
				{ id = 700308, delay = 0 },
			},
			counter_target = 12,
		},
	},
	{
		id = 900006,
		class = "ElementToggle",
		module = "CoreElementToggle",
		editor_name = "toggle_bain_comment_on_twelve_cameras",
		values = {
			enabled = true,
			on_executed = {},
			elements = { 900007 },
		},
	},
	{
		id = 900007,
		class = "ElementDialogue",
		editor_name = "hos_ban_131d",
		values = {
			enabled = false,
			on_executed = {
				{ id = 701626, delay = 4 },
			},
			dialogue = "hos_ban_131d",
		},
	},
	{
		id = 900008,
		class = "MissionScriptElement",
		editor_name = "logic_link_bain_has_no_intel_on_the_amount_of_cameras",
		values = {
			enabled = true,
			on_executed = {
				{ id = 900009, delay = 0 }, -- remove cameras
				{ id = 900012, delay = 0 }, -- toggle dialogue
			},
		},
	},
	{
		id = 900009,
		class = "ElementRandom",
		module = "CoreElementRandom",
		editor_name = "second_roll_for_twelve_cameras",
		values = {
			enabled = true,
			execute_on_startup = false,
			execute_on_restart = false,
			on_executed = {
				{ id = 900010, delay = 0 }, -- twelve
				{ id = 900011, delay = 0 }, -- nine
			},
			amount = 1,
		},
	},
	{
		id = 900010,
		class = "MissionScriptElement",
		editor_name = "set_twelve_cameras_with_no_intel",
		values = {
			enabled = true,
			on_executed = {
				{ id = 900003, delay = 0 }, -- remove cameras
				{ id = 900004, delay = 0 }, -- toggle logic operator
			},
		},
	},
	{
		id = 900011,
		class = "MissionScriptElement",
		editor_name = "set_nine_cameras_with_no_intel",
		values = {
			enabled = true,
			on_executed = {
				{ id = 700156, delay = 0 }, -- remove cameras
				{ id = 700174, delay = 0 }, -- toggle logic operator
			},
		},
	},
	{
		id = 900012,
		class = "ElementToggle",
		module = "CoreElementToggle",
		editor_name = "toggle_bain_announces_having_no_intel_on_cameras",
		values = {
			enabled = true,
			on_executed = {},
			elements = { 900013 },
		},
	},
	{
		id = 900013,
		class = "ElementDialogue",
		editor_name = "hos_ban_131e",
		values = {
			enabled = false,
			on_executed = {
				{ id = 701626, delay = 4 },
			},
			dialogue = "hos_ban_131e",
		},
	},
}

local default_update = {
	{
		id = 700114,
		values = {
			on_executed = {
				merge_type = "patch",
				insert = { { id = 900000, delay = 0 } },
			},
		},
	},
	-- { id = 700115, values = { enabled = false } },
	-- { id = 700116, values = { enabled = false } },
	{ -- '3and4Players'
		id = 700117,
		editor_name = "3Players", -- rename element
		values = {
			player_4 = false, -- disable when player count is 4
		},
	},
	{ -- 'func_sequence_trigger_001'
		id = 700164,
		values = {
			on_executed = {
				merge_type = "patch",
				insert = { { id = 900005, delay = 0 } },
			},
		},
	},
	{ -- 'func_sequence_trigger_002'
		id = 700166,
		values = {
			on_executed = {
				merge_type = "patch",
				insert = { { id = 900005, delay = 0 } },
			},
		},
	},
	{ -- 'func_sequence_trigger_003'
		id = 700167,
		values = {
			on_executed = {
				merge_type = "patch",
				insert = { { id = 900005, delay = 0 } },
			},
		},
	},
	{ -- 'func_sequence_trigger_004'
		id = 700168,
		values = {
			on_executed = {
				merge_type = "patch",
				insert = { { id = 900005, delay = 0 } },
			},
		},
	},
	{ -- 'hos_ban_02'
		id = 701625,
		values = {
			on_executed = {
				merge_type = "patch",
				insert = {
					{ id = 900007, delay = 8 },
					{ id = 900013, delay = 8 },
				},
			},
		},
	},
}

return {
	mission = {
		create = {
			default = default_create,
		},
		update = {
			default = default_update,
		},
	},
}
