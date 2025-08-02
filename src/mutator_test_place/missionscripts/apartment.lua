local util = ...
local path_world = "levels/apartment/world/world"

local _mission_data = { bags = {}, enemies = {}, weapon = { unit = nil, index = 1 } }
local buttons = {
	enemy_spawner = 210701, -- units/world/props/apartment/apartment_key_dummy/apartment_key_dummy (7601731dfdabdf2c) @ Vector3(-905, 275, 1780)
	bag_spawner = 210702, -- units/world/props/apartment/apartment_key_dummy/apartment_key_dummy (7601731dfdabdf2c) @ Vector3(-732, 275, 1780)
	weapon_spawner = 210703, -- units/world/props/apartment/apartment_key_dummy/apartment_key_dummy (7601731dfdabdf2c) @ Vector3(-1065, 275, 1755)
	weapon_pickup = 210704, -- units/world/props/apartment/apartment_key_dummy/apartment_key_dummy (7601731dfdabdf2c) @ Vector3(-1025, 275, 1800)
	test_button = 210705, -- units/world/props/apartment/apartment_key_dummy/apartment_key_dummy (7601731dfdabdf2c) @ Vector3(-560, 275, 1780)
}

local spawn_point, spawn_rot = Vector3(-815, 30, 1675), Rotation()
local update_default = {
	script_path = path_world,

	-- change spawn point state and positions
	{ id = 100091, values = { state = "standard", position = spawn_point, rotation = spawn_rot } },
	{ id = 100092, values = { state = "standard", position = spawn_point, rotation = spawn_rot } },
	{ id = 100093, values = { state = "standard", position = spawn_point, rotation = spawn_rot } },
	{ id = 100094, values = { state = "standard", position = spawn_point, rotation = spawn_rot } },

	-- disable mission
	{ id = 100011, values = { enabled = false } }, -- dialog trigger area
	{ id = 100095, values = { enabled = false } }, -- initial objective sequence
	{ id = 100152, values = { enabled = false } }, -- hint area
	{ id = 100637, values = { enabled = false } }, -- stay back bro!
	{ id = 100330, values = { enabled = false } }, -- don't take another step
	{ id = 101871, values = { enabled = false } }, -- mask up event
	{ id = 100147, values = { enabled = false } }, -- debug trigger area
	{ id = 100325, values = { enabled = false } }, -- blow cover area 2
	{ id = 101759, values = { enabled = false } }, -- blow cover area 3
	{ id = 101394, values = { enabled = false } }, -- spawn chavez obj
	{ id = 104933, values = { enabled = false } }, -- deal knock
	{ id = 100300, values = { enabled = false } }, -- enemy spawn
	{ id = 101363, values = { enabled = false } }, -- begin deal
	{ id = 101851, values = { enabled = false } }, -- perform deal
	{ id = 100323, values = { enabled = false } }, -- perform deal2
	{ id = 100372, values = { enabled = false } }, -- panic room found
	{ id = 100404, values = { enabled = false } }, -- panic room entered
	{ id = 101464, values = { enabled = false } }, -- alley trigger area

	-- { id = 100058, values = { enabled = false } }, -- hide saw dummies
	-- { id = 100119, values = { enabled = false } }, -- hide c4 dummies
	-- { id = 100217, values = { enabled = false } }, -- hide helicopters
	-- { id = 100230, values = { enabled = false } }, -- flee point
	-- { id = 100446, values = { enabled = false } }, -- navlinks
	-- { id = 100472, values = { enabled = false } }, -- navlinks
	{ id = 100967, values = { enabled = false } }, -- civilian spawn
	-- { id = 101001, values = { enabled = false } }, -- hide bathroom door in room 1
	{ id = 101208, values = { enabled = false } }, -- comment (unused)
	{ id = 101395, values = { enabled = false } }, -- enemy spawn
	{ id = 101433, values = { enabled = false } }, -- enemy spawn
	{ id = 101437, values = { enabled = false } }, -- enemy spawn
	{ id = 101514, values = { enabled = false } }, -- civilian spawn
	{ id = 101515, values = { enabled = false } }, -- civilian spawn
	{ id = 101539, values = { enabled = false } }, -- enemy spawn
	{ id = 101540, values = { enabled = false } }, -- enemy spawn
	-- { id = 101594, values = { enabled = false } }, -- hide c4 bags
	{ id = 101612, values = { enabled = false } }, -- enemy spawn
	{ id = 101744, values = { enabled = false } }, -- enemy spawn
	{ id = 101802, values = { enabled = false } }, -- enemy spawn
	{ id = 101804, values = { enabled = false } }, -- enemy spawn
	{ id = 101867, values = { enabled = false } }, -- enemy spawn
	-- { id = 102222, values = { enabled = false } }, -- hide units
	-- { id = 102377, values = { enabled = false } }, -- navlink
	-- { id = 102399, values = { enabled = false } }, -- navlink
	-- { id = 102401, values = { enabled = false } }, -- navlink
	-- { id = 102453, values = { enabled = false } }, -- navlink
	-- { id = 102454, values = { enabled = false } }, -- navlink
	-- { id = 102455, values = { enabled = false } }, -- navlink
	-- { id = 102468, values = { enabled = false } }, -- navlink
	{ id = 102587, values = { enabled = false } }, -- enemy spawn
	{ id = 102593, values = { enabled = false } }, -- enemy spawn
	{ id = 102597, values = { enabled = false } }, -- enemy spawn
	{ id = 102604, values = { enabled = false } }, -- enemy spawn
	-- { id = 102703, values = { enabled = false } }, -- hide helicopter
	{ id = 102850, values = { enabled = false } }, -- chavez spawn
	-- { id = 103114, values = { enabled = false } }, -- hide crowbars
	-- { id = 103247, values = { enabled = false } }, -- navlinks
	-- { id = 103340, values = { enabled = false } }, -- roof navlinks
	{ id = 103380, values = { enabled = false } }, -- enemy spawn
	-- { id = 103402, values = { enabled = false } }, -- hide l4d aid kits
	-- { id = 104246, values = { enabled = false } }, -- hide money bundles
	{ id = 104793, values = { enabled = false } }, -- enemy spawn
}

local create_default = {
	script_path = path_world,
	{ -- clean up the roof
		id = 900000,
		class = "ElementDisableUnit",
		editor_name = "disable_units_001",
		values = {
			base_delay = 0,
			debug = false,
			enabled = true,
			execute_on_restart = false,
			execute_on_startup = true,
			position = Vector3(),
			rotation = Rotation(),
			trigger_times = 0,
			unit_ids = {
				100179, -- units/world/props/apartment/vent_tunnel/vent_tunnel_90_vert (bafd75f2a07fc78f) @ Vector3(-1373, 324, 1739),
				102793, -- units/world/props/desert/des_prop_roof/des_prop_roof_aircondition_big (094cc456e2cd8e89) @ Vector3(-1423, 326, 1675),
				100180, -- units/world/architecture/diamondheist/props/diamondheist_roof_gen_large_01 (08d22e6446c57af6) @ Vector3(-1597, 358, 1675),
				102268, -- units/world/architecture/diamondheist/props/diamondheist_roof_gen_large_02 (5097e7149f6013bd) @ Vector3(-1612, 246, 1675),
				100171, -- units/world/props/apartment/vent_tunnel/vent_tunnel_90_vert (bafd75f2a07fc78f) @ Vector3(-815, 402, 1736),
				100175, -- units/world/props/apartment/vent_tunnel/vent_tunnel_straight_x2 (53875988253cf3e2) @ Vector3(-469, 402, 1736),
				101874, -- units/world/props/street/roof_addons/roof_water_tower_04 (a7dd935e90fc4e6a) @ Vector3(-7, 275, 1675),
				100111, -- units/world/props/apartment/vent_tunnel/vent_tunnel_90_vert (bafd75f2a07fc78f) @ Vector3(-469, 402, 1736),
				101194, -- units/world/props/apartment/vent_tunnel/vent_tunnel_90_vert (bafd75f2a07fc78f) @ Vector3(-843, 1348, 1736),
				101195, -- units/world/props/apartment/vent_tunnel/vent_tunnel_90_vert (bafd75f2a07fc78f) @ Vector3(-640, 1348, 1736),
				100522, -- units/world/props/desert/des_prop_roof/des_prop_roof_aircondition_big (094cc456e2cd8e89) @ Vector3(-639, 1397, 1675),
				102794, -- units/world/props/desert/des_prop_roof/des_prop_roof_aircondition_big (094cc456e2cd8e89) @ Vector3(-851, 1397, 1675),
				102646, -- units/world/brushes/puddle/puddle_1 (91d47d65b3d5d5b4) @ Vector3(-500, 511, 1676),
				101319, -- units/world/props/apartment/vent_tunnel/vent_tunnel_90_vert (bafd75f2a07fc78f) @ Vector3(-192, 804, 1736),
				101318, -- units/world/props/apartment/vent_tunnel/vent_tunnel_straight (dbbc3446b6ca9ab9) @ Vector3(-192, 804, 1736),
				102267, -- units/world/architecture/diamondheist/props/diamondheist_roof_gen_large_01 (08d22e6446c57af6) @ Vector3(-320, 857, 1675),
			},
			on_executed = {},
		},
	},
	{ -- Open doors, disable weapon pickup
		id = 900001,
		class = "ElementUnitSequence",
		editor_name = "test_place_setup",
		values = {
			enabled = true,
			on_executed = {},
			debug = false,
			trigger_times = 0,
			base_delay = 0,
			position = Vector3(),
			rotation = Rotation(),
			execute_on_startup = true,
			trigger_list = {
				-- alley
				{
					name = "run_sequence",
					notify_unit_sequence = "close",
					notify_unit_id = 100246, -- units/world/props/street/plywood_fence/plywood_fence_door
					time = 0,
				},
				{
					name = "run_sequence",
					notify_unit_sequence = "open",
					notify_unit_id = 100100, -- units/world/props/street/plywood_fence/plywood_fence_door
					time = 0,
				},
				{
					name = "run_sequence",
					notify_unit_sequence = "open_out",
					notify_unit_id = 101384, -- units/world/architecture/apartment/door/apartment_door_03
					time = 0,
				},
				{
					name = "run_sequence",
					notify_unit_sequence = "open_out",
					notify_unit_id = 100306, -- units/world/architecture/apartment/door/apartment_door_03
					time = 0,
				},
				{ -- invisible wall in the fire escape stair
					name = "run_sequence",
					notify_unit_sequence = "disable_collision",
					notify_unit_id = 100162, -- units/dev_tools/level_tools/dev_collision_5m_netsync
					time = 0,
				},
				-- 1st floor
				{
					name = "run_sequence",
					notify_unit_sequence = "open_in",
					notify_unit_id = 102957, -- units/world/architecture/apartment/door/apartment_door_01_crowbar_interaction (29d7a6667c2e82a0) @ Vector3(-1230, 440, 375)
					time = 0,
				},
				{
					name = "run_sequence",
					notify_unit_sequence = "open_out",
					notify_unit_id = 102429, -- units/world/architecture/apartment/door/apartment_door_03
					time = 0,
				},
				{
					name = "run_sequence",
					notify_unit_sequence = "open_out",
					notify_unit_id = 100335, -- units/world/architecture/apartment/door/apartment_door_03
					time = 0,
				},
				{
					name = "run_sequence",
					notify_unit_sequence = "open_out",
					notify_unit_id = 101596, -- units/world/architecture/apartment/door/apartment_door_01
					time = 0,
				},
				{
					name = "run_sequence",
					notify_unit_sequence = "open_in",
					notify_unit_id = 100277, -- units/world/architecture/apartment/door/apartment_door_03
					time = 0,
				},
				{
					name = "run_sequence",
					notify_unit_sequence = "open_out",
					notify_unit_id = 100252, -- units/world/architecture/apartment/door/apartment_door_03
					time = 0,
				},
				-- 2nd floor
				{
					name = "run_sequence",
					notify_unit_sequence = "slam_out",
					notify_unit_id = 103184, -- units/world/architecture/apartment/door/apartment_door_01
					time = 0,
				},
				-- 3rd floor
				{
					name = "run_sequence",
					notify_unit_sequence = "hide_dummy",
					notify_unit_id = 100363, -- units/world/props/apartment/apartment_key_dummy/apartment_key_dummy
					time = 0,
				},
				{
					name = "run_sequence",
					notify_unit_sequence = "open_in",
					notify_unit_id = 101673, -- units/world/architecture/apartment/door/apartment_door_reinforced_01
					time = 0,
				},
				{
					name = "run_sequence",
					notify_unit_sequence = "open_in",
					notify_unit_id = 100056, -- units/world/architecture/apartment/door/apartment_door_01
					time = 0,
				},
				{
					name = "run_sequence",
					notify_unit_sequence = "slam_in",
					notify_unit_id = 101342, -- units/world/architecture/apartment/door/apartment_door_01
					time = 0,
				},
				{
					name = "run_sequence",
					notify_unit_sequence = "open_in",
					notify_unit_id = 100321, -- units/world/architecture/apartment/door/apartment_door_01
					time = 0,
				},
				-- {
				-- 	name = "run_sequence",
				-- 	notify_unit_sequence = "open_in",
				-- 	notify_unit_id = 100124, -- units/world/architecture/apartment/door/apartment_door_01 (dbb49579feb5ebc1) @ Vector3(60.0562, 439.474, 700)
				-- 	time = 0,
				-- },
				-- 5th floor
				{
					name = "run_sequence",
					notify_unit_sequence = "open_out",
					notify_unit_id = 101099, -- units/world/architecture/apartment/door/apartment_door_03
					time = 0,
				},
				{
					name = "run_sequence",
					notify_unit_sequence = "open_in",
					notify_unit_id = 103228, -- units/world/architecture/apartment/door/apartment_door_01 (dbb49579feb5ebc1) @ Vector3(-389.514, 694.464, 1350)
					time = 0,
				},
				-- roof
				{
					name = "run_sequence",
					notify_unit_sequence = "open_out",
					notify_unit_id = 100003, -- units/world/architecture/apartment/door/apartment_door_03
					time = 0,
				},
				{
					name = "run_sequence",
					notify_unit_sequence = "hide_dummy",
					notify_unit_id = buttons.weapon_pickup,
					time = 0,
				},
			},
		},
	},
	{ -- reset all buttons
		id = 900002,
		class = "ElementUnitSequence",
		editor_name = "reset_buttons",
		values = {
			enabled = true,
			on_executed = {
				{ id = 900003, delay = 0 },
				{ id = 900011, delay = 0 },
			},
			position = Vector3(),
			rotation = Rotation(),
			trigger_list = {
				{
					name = "run_sequence",
					notify_unit_sequence = "spawn_dummy",
					notify_unit_id = buttons.enemy_spawner,
					time = 0,
				},
				{
					name = "run_sequence",
					notify_unit_sequence = "spawn_dummy",
					notify_unit_id = buttons.bag_spawner,
					time = 0,
				},
				{
					name = "run_sequence",
					notify_unit_sequence = "spawn_dummy",
					notify_unit_id = buttons.weapon_spawner,
					time = 0,
				},
				{
					name = "run_sequence",
					notify_unit_sequence = "spawn_dummy",
					notify_unit_id = buttons.test_button,
					time = 0,
				},
			},
		},
	},
	{
		id = 900003,
		class = "ElementDebug",
		module = "CoreElementDebug",
		editor_name = "element_debug_01",
		values = {
			enabled = true,
			on_executed = {},
			debug = false,
			trigger_times = 0,
			base_delay = 0,
			position = Vector3(),
			rotation = Rotation(),
			debug_string = "All buttons reset",
		},
	},
	{
		id = 900004,
		class = "ElementUnitSequenceTrigger",
		module = "CoreElementUnitSequenceTrigger",
		editor_name = "check_enemy_spawner_press",
		values = {
			enabled = true,
			on_executed = {
				{ id = 900002, delay = 0 },
				{ id = 900005, delay = 0 },
			},
			position = Vector3(),
			rotation = Rotation(),
			sequence_list = {
				{
					unit_id = buttons.enemy_spawner,
					sequence = "interact",
				},
			},
		},
	},
	{
		id = 900005,
		class = "ElementDebug",
		module = "CoreElementDebug",
		editor_name = "spawn_enemies",
		values = {
			enabled = true,
			on_executed = {},
			position = Vector3(),
			rotation = Rotation(),
			debug_string = "Enemies Spawned",
			on_pre_executed = function()
				if Network:is_client() then
					return
				end

				local enemy_list = _mission_data.enemies
				if not tablex.empty(enemy_list) then
					for i, unit in ipairs(enemy_list) do
						if alive(unit) then
							if not unit:character_damage():dead() then
								unit:character_damage().drop_pickup = function() end
								unit:character_damage():die()
							end
							unit:base():pre_destroy(unit)
							unit:set_slot(0)
						end

						enemy_list[i] = nil
					end
				end

				for i, enemy in pairs({
					"swat",
					"swat2",
					"swat3",
					"cop",
					"cop2",
					"cop3",
					"tank",
					"shield",
					"spooc",
					"sniper",
					"taser",
					"gangster1",
					"gangster2",
					"gangster3",
					"gangster4",
					"gangster5",
					"gangster6",
					"dealer",
				}) do
					table.insert(enemy_list, util.spawn_enemy(enemy, Vector3(-520, 1200, 1677), Vector3(-75, 0, 0) * i))
				end
			end,
		},
	},
	{
		id = 900006,
		class = "ElementUnitSequenceTrigger",
		module = "CoreElementUnitSequenceTrigger",
		editor_name = "check_bag_spawner_press",
		values = {
			enabled = true,
			on_executed = {
				{ id = 900002, delay = 0 },
				{ id = 900007, delay = 0 },
			},
			position = Vector3(),
			rotation = Rotation(),
			sequence_list = {
				{
					unit_id = buttons.bag_spawner,
					sequence = "interact",
				},
			},
		},
	},
	{
		id = 900007,
		class = "ElementDebug",
		module = "CoreElementDebug",
		editor_name = "spawn_bags",
		values = {
			enabled = true,
			on_executed = {},
			position = Vector3(),
			rotation = Rotation(),
			debug_string = "Bags Spawned",
			on_pre_executed = function()
				if Network:is_client() then
					return
				end

				local bag_list = _mission_data.bags or {}
				if not tablex.empty(bag_list) then
					for i, unit in pairs(bag_list) do
						if alive(unit) then
							unit:base():_set_empty()
							bag_list[i] = nil
						end
					end
				end

				local doctor_bag = DoctorBagBase.spawn(Vector3(-780, 275, 1780), Rotation(90, 0, 0))
				doctor_bag:base()._server_information = { owner_peer_id = math.random(1, 4) }
				doctor_bag:base():sync_taken(0)

				local ammo_bag = AmmoBagBase.spawn(Vector3(-680, 275, 1780), Rotation(90, 0, 0))
				ammo_bag:base()._server_information = { owner_peer_id = math.random(1, 4) }
				ammo_bag:base():sync_ammo_taken(0)

				table.insert(bag_list, doctor_bag)
				table.insert(bag_list, ammo_bag)
			end,
		},
	},
	{
		id = 900008,
		class = "ElementUnitSequenceTrigger",
		module = "CoreElementUnitSequenceTrigger",
		editor_name = "check_weapon_spawner_press",
		values = {
			enabled = true,
			on_executed = {
				{ id = 900002, delay = 0 },
				{ id = 900009, delay = 0 },
				{ id = 900010, delay = 0 },
			},
			position = Vector3(),
			rotation = Rotation(),
			sequence_list = {
				{
					unit_id = buttons.weapon_spawner,
					sequence = "interact",
				},
			},
		},
	},
	{
		id = 900009,
		class = "ElementDebug",
		module = "CoreElementDebug",
		editor_name = "spawn_weapon_pickup",
		values = {
			enabled = true,
			on_executed = {},
			position = Vector3(),
			rotation = Rotation(),
			debug_string = "Weapon pickup spawned",
			on_pre_executed = function()
				if Network:is_client() then
					return
				end

				local weapon_data = _mission_data.weapon
				if alive(weapon_data.unit) then
					util.delete_unit(weapon_data.unit)
					weapon_data.unit = nil
				end

				local weapon_list = PlayerInventory._index_to_weapon_list
				local weapon_id = weapon_list[weapon_data.index]
				local pos, rot = Vector3(-1025, 275, 1800), Rotation()

				weapon_data.weapon_id = weapon_id
				weapon_data.unit = util.spawn_weapon(weapon_id, pos, rot)

				weapon_data.index = weapon_data.index + 1
				if weapon_data.index > (#weapon_list - 2) then -- last 2 weapons are enemy weapons and crash the game.
					weapon_data.index = 1
				end
			end,
		},
	},
	{
		id = 900010,
		class = "ElementToggle",
		module = "CoreElementToggle",
		editor_name = "element_toggle_weapon_pickup",
		values = {
			base_delay = 0,
			elements = { 900011, 900012 },
			enabled = true,
			position = Vector3(),
			rotation = Rotation(),
			toggle = "on",
			trigger_times = 1,
			on_executed = {
				{ id = 900002, delay = 0 },
			},
		},
	},
	{
		id = 900011,
		class = "ElementUnitSequence",
		editor_name = "reset_weapon_pickup",
		values = {
			enabled = false,
			on_executed = {},
			position = Vector3(),
			rotation = Rotation(),
			trigger_list = {
				{
					name = "run_sequence",
					notify_unit_sequence = "spawn_dummy",
					notify_unit_id = buttons.weapon_pickup,
					time = 0,
				},
			},
		},
	},
	{
		id = 900012,
		class = "ElementUnitSequenceTrigger",
		module = "CoreElementUnitSequenceTrigger",
		editor_name = "check_weapon_pickup_press",
		values = {
			enabled = false,
			on_executed = {
				{ id = 900002, delay = 0 },
				{ id = 900013, delay = 0 },
			},
			position = Vector3(),
			rotation = Rotation(),
			sequence_list = {
				{
					unit_id = buttons.weapon_pickup,
					sequence = "interact",
				},
			},
		},
	},
	{
		id = 900013,
		class = "ElementDebug",
		module = "CoreElementDebug",
		editor_name = "pickup_weapon",
		values = {
			enabled = true,
			on_executed = {},
			position = Vector3(),
			rotation = Rotation(),
			debug_string = "Pickup weapon",
			on_pre_executed = function()
				if Network:is_client() then
					return
				end

				local weapon_data = _mission_data.weapon
				local weapon_id = weapon_data.weapon_id
				util.give_weapon(weapon_id)
			end,
		},
	},
	{
		id = 900014,
		class = "ElementUnitSequenceTrigger",
		module = "CoreElementUnitSequenceTrigger",
		editor_name = "check_test_button_press",
		values = {
			enabled = true,
			on_executed = {
				{ id = 900002, delay = 0 },
				{ id = 900015, delay = 0 },
			},
			position = Vector3(),
			rotation = Rotation(),
			sequence_list = {
				{
					unit_id = buttons.test_button,
					sequence = "interact",
				},
			},
		},
	},
	{
		id = 900015,
		class = "ElementDebug",
		module = "CoreElementDebug",
		editor_name = "test_button",
		values = {
			enabled = true,
			on_executed = {},
			position = Vector3(),
			rotation = Rotation(),
			debug_string = "Running user script",
			on_pre_executed = function()
				if Network:is_client() then
					return
				end

				util.user_script()
			end,
		},
	},
}

return {
	mission = {
		update = {
			default = update_default,
		},
		create = {
			default = create_default,
		},
	},
}
