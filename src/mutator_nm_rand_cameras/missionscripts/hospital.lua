local element_offset = 50246 * 100 -- unique element id offset: mws mod id * 100
local current_id = 0

local function new_id()
	local id = element_offset + current_id
	current_id = current_id + 1
	return id
end

local append_elements = function(script, elements)
	for i = 1, #elements do
		script[#script + 1] = elements[i]
	end
end

local debug_log = function(message)
	return function(element)
		local text = string.format("<debug>    [%d] %s", element._id, tostring(message))
		managers.mission:add_fading_debug_output(text)
	end
end

-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------
local update_default = {}
local create_default = {}

-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------
local killAlarm = 700165 -- kill alarm after all cameras are broken
local camerasTakenOut = 700308 -- trigger objective after taking out cameras

local hos_ban_03 = 701626 -- Bain's instruction loop

local func_disable_unit_001 = 700118 -- despawn camera
local func_disable_unit_003 = 700120 -- despawn camera
local func_disable_unit_006 = 700123 -- despawn camera
local func_disable_unit_011 = 700128 -- despawn camera
local func_disable_unit_012 = 700129 -- despawn camera
local func_disable_unit_022 = 700139 -- despawn camera
local func_disable_unit_019 = 700136 -- despawn camera
local func_disable_unit_017 = 700134 -- despawn camera
local func_disable_unit_013 = 700130 -- despawn camera
local func_disable_unit_015 = 700132 -- despawn camera
local func_disable_unit_027 = 700144 -- despawn camera
local func_disable_unit_026 = 700143 -- despawn camera
local func_disable_unit_028 = 700145 -- despawn camera
local func_disable_unit_029 = 700146 -- despawn camera
local func_disable_unit_030 = 700147 -- despawn camera
local func_disable_unit_031 = 700148 -- despawn camera
local func_disable_unit_032 = 700149 -- despawn camera
local func_disable_unit_033 = 700150 -- despawn camera
local func_disable_unit_034 = 700151 -- despawn camera
local func_disable_unit_036 = 700153 -- despawn camera

-------------------------------------------------------
--- logic 12 cameras
---
local despawn_eight_cameras = new_id()
local toggle_logic_counter_for_twelve_cameras = new_id()
local counter_for_twelve_cameras = new_id()
local twelve_camera_dialogue = new_id()
local toggle_twelve_camera_dialogue = new_id()
local setup_twelve_cameras = new_id()

local twelve_camera_script = {
	{
		id = despawn_eight_cameras,
		class = "ElementRandom",
		module = "CoreElementRandom",
		editor_name = "mod-logic_random_001",
		values = {
			enabled = true,
			on_executed = {
				{ id = func_disable_unit_001, delay = 0 },
				{ id = func_disable_unit_003, delay = 0 },
				{ id = func_disable_unit_006, delay = 0 },
				{ id = func_disable_unit_011, delay = 0 },
				{ id = func_disable_unit_012, delay = 0 },
				{ id = func_disable_unit_022, delay = 0 },
				{ id = func_disable_unit_019, delay = 0 },
				{ id = func_disable_unit_017, delay = 0 },
				{ id = func_disable_unit_013, delay = 0 },
				{ id = func_disable_unit_015, delay = 0 },
				{ id = func_disable_unit_027, delay = 0 },
				{ id = func_disable_unit_026, delay = 0 },
				{ id = func_disable_unit_028, delay = 0 },
				{ id = func_disable_unit_029, delay = 0 },
				{ id = func_disable_unit_030, delay = 0 },
				{ id = func_disable_unit_031, delay = 0 },
				{ id = func_disable_unit_032, delay = 0 },
				{ id = func_disable_unit_033, delay = 0 },
				{ id = func_disable_unit_034, delay = 0 },
				{ id = func_disable_unit_036, delay = 0 },
			},
			amount = 8,
		},
	},
	{
		id = counter_for_twelve_cameras,
		class = "ElementCounter",
		module = "CoreElementCounter",
		editor_name = "mod-logic_counter_001",
		values = {
			enabled = false,
			on_executed = {
				{ id = killAlarm, delay = 0 },
				{ id = camerasTakenOut, delay = 0 },
			},
			counter_target = 12,
		},
	},
	{
		id = toggle_logic_counter_for_twelve_cameras,
		class = "ElementToggle",
		module = "CoreElementToggle",
		editor_name = "mod-logic_toggle_001",
		values = {
			enabled = true,
			on_executed = {},
			elements = { counter_for_twelve_cameras },
		},
	},
	{
		id = twelve_camera_dialogue,
		class = "ElementDialogue",
		editor_name = "hos_ban_131d",
		values = {
			enabled = false,
			on_executed = { { id = hos_ban_03, delay = 4 } },
			dialogue = "hos_ban_131d",
		},
	},
	{
		id = toggle_twelve_camera_dialogue,
		class = "ElementToggle",
		module = "CoreElementToggle",
		editor_name = "mod-logic_toggle_002",
		values = {
			enabled = true,
			on_executed = {},
			elements = { twelve_camera_dialogue },
		},
	},
	{
		id = setup_twelve_cameras,
		class = "MissionScriptElement",
		editor_name = "mod-logic_link_001",
		values = {
			enabled = true,
			on_executed = {
				{ id = despawn_eight_cameras, delay = 0 },
				{ id = toggle_logic_counter_for_twelve_cameras, delay = 0 },
				callback = debug_log("despawn 8 cameras"),
			},
		},
	},
}

append_elements(create_default, twelve_camera_script)

-------------------------------------------------------
--- logic 9 cameras
---
local randomCamerasOverkill = 700156 -- despawn 11 cameras
local logic_toggle_004 = 700174 -- enable 9 camera counter

local setup_nine_cameras = new_id()

local nine_camera_script = {
	{
		id = setup_nine_cameras,
		class = "MissionScriptElement",
		editor_name = "mod-logic_link_002",
		values = {
			enabled = true,
			on_executed = {
				{ id = randomCamerasOverkill, delay = 0 },
				{ id = logic_toggle_004, delay = 0 },
				callback = debug_log("despawn 11 cameras"),
			},
		},
	},
}

append_elements(create_default, nine_camera_script)

-------------------------------------------------------
--- randomly decide camera amount
---
local unknown_cameras_dialogue = new_id()
local toggle_unknown_cameras_dialogue = new_id()

local roll_camera_amount = new_id()
local decide_twelve_cameras = new_id()
local roll_twelve_or_nine = new_id()
local decide_twelve_or_nine_cameras = new_id()

local random_camera_script = {
	{
		id = unknown_cameras_dialogue,
		class = "ElementDialogue",
		editor_name = "hos_ban_131e",
		values = {
			enabled = false,
			on_executed = { { id = hos_ban_03, delay = 4 } },
			dialogue = "hos_ban_131e",
		},
	},
	{
		id = toggle_unknown_cameras_dialogue,
		class = "ElementToggle",
		module = "CoreElementToggle",
		editor_name = "mod-logic_toggle_003",
		values = {
			enabled = true,
			on_executed = {},
			elements = { unknown_cameras_dialogue },
		},
	},
	{
		id = decide_twelve_cameras,
		class = "MissionScriptElement",
		editor_name = "mod-logic_link_002",
		values = {
			enabled = true,
			on_executed = {
				{ id = setup_twelve_cameras, delay = 0 },
				{ id = toggle_twelve_camera_dialogue, delay = 0 },
				callback = debug_log("rolled for 12 cameras"),
			},
		},
	},
	{
		id = roll_twelve_or_nine,
		class = "ElementRandom",
		module = "CoreElementRandom",
		editor_name = "mod-logic_random_002",
		values = {
			enabled = true,
			on_executed = {
				{ id = setup_twelve_cameras, delay = 0 },
				{ id = setup_nine_cameras, delay = 0 },
			},
			amount = 1,
		},
	},
	{
		id = decide_twelve_or_nine_cameras,
		class = "MissionScriptElement",
		editor_name = "mod-logic_link_003",
		values = {
			enabled = true,
			on_executed = {
				{ id = roll_twelve_or_nine, delay = 0 },
				{ id = toggle_unknown_cameras_dialogue, delay = 0 },
				callback = debug_log("rolled for random cameras"),
			},
		},
	},
	{
		id = roll_camera_amount,
		class = "ElementRandom",
		module = "CoreElementRandom",
		editor_name = "mod-logic_random_003",
		values = {
			enabled = true,
			on_executed = {
				{ id = decide_twelve_cameras, delay = 0 },
				{ id = decide_twelve_or_nine_cameras, delay = 0 },
			},
			amount = 1,
		},
	},
}

append_elements(create_default, random_camera_script)

-------------------------------------------------------
--- setup
---
local filter_four_players = new_id()

local setup_script = {
	{
		id = filter_four_players,
		class = "ElementFilter",
		editor_name = "4Players",
		values = {
			enabled = true,
			execute_on_startup = false,
			execute_on_restart = false,
			on_executed = {
				{ id = roll_camera_amount, delay = 0 },
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
}

append_elements(create_default, setup_script)

-------------------------------------------------------
--- patch mission logic
---
local spawnSecurityCameras = 700114 -- decide amount of cameras

-- local singleplayer = 700115 -- spawn camera logic for 1 player
local three_and_four_players = 700117 -- original name: '3and4Players', spawn camera logic for 3 and 4 players

local func_sequence_trigger_001 = 700164 -- broken camera checker
local func_sequence_trigger_002 = 700166 -- broken camera checker
local func_sequence_trigger_003 = 700167 -- broken camera checker
local func_sequence_trigger_004 = 700168 -- broken camera checker

local hos_ban_02 = 701625 -- Bain briefing the objective

local setup_event = {
	{
		id = spawnSecurityCameras,
		values = {
			on_executed = {
				merge_type = "patch",
				insert = { { id = filter_four_players, delay = 0 } }, -- insert custom logic for 4 players
			},
		},
	},

	-- { id = singleplayer, values = { enabled = false } }, -- for testing
	{ id = three_and_four_players, editor_name = "3Players", values = { player_4 = false } }, -- rename element, disable for 4 players

	-- allow counting broken cameras to our custom logic
	{
		id = func_sequence_trigger_001,
		values = {
			on_executed = {
				merge_type = "patch",
				insert = { { id = counter_for_twelve_cameras, delay = 0 } },
			},
		},
	},
	{
		id = func_sequence_trigger_002,
		values = {
			on_executed = {
				merge_type = "patch",
				insert = { { id = counter_for_twelve_cameras, delay = 0 } },
			},
		},
	},
	{
		id = func_sequence_trigger_003,
		values = {
			on_executed = {
				merge_type = "patch",
				insert = { { id = counter_for_twelve_cameras, delay = 0 } },
			},
		},
	},
	{
		id = func_sequence_trigger_004,
		values = {
			on_executed = {
				merge_type = "patch",
				insert = { { id = counter_for_twelve_cameras, delay = 0 } },
			},
		},
	},

	-- allow bain to say 'there are twelve cameras'
	{
		id = hos_ban_02,
		values = {
			on_executed = {
				merge_type = "patch",
				insert = {
					{ id = twelve_camera_dialogue, delay = 8 },
					{ id = unknown_cameras_dialogue, delay = 8 },
				},
			},
		},
	},
}

append_elements(update_default, setup_event)

-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------

return {
	mission = {
		update = { default = update_default },
		create = { default = create_default },
	},
}
