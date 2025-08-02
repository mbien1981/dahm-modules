return DMod:new("test_place_mutator", {
	author = "Dr_Newbie, _atom",
	version = "7.2",
	categories = { "gameplay", "mutator" },
	dependencies = { "ovk_193", "scriman" },
	localization = {
		{ "debug_interact_push_button", "Press $BTN_INTERACT; to push button" },
		--
		{ "mutator_test_place_mutator", "Test place" },
		{ "mutator_test_place_mutator_help", "" },
		{ "mutator_test_place_mutator_motd", "" },
	},
	hooks = {
		{
			"OnModuleLoading",
			"SetupMutator",
			function(module)
				local mutator_key = module:id()
				local availability = { all = { levels = { apartment = true } } }

				local patches = {}
				patches.setup = function()
					local type_mission = "mission"
					local path = "levels/apartment/world/world"
					DPackageManager:register_processor(module, mutator_key, type_mission, path, function(_, _, data)
						local script_data = loadfile(module:path() .. "missionscripts/apartment.lua")
						if type(script_data) ~= "function" then
							return
						end

						local util = loadfile(module:path() .. "util.lua")
						if type(util) ~= "function" then
							return
						end

						script_data = script_data(util())
						script_data.id = script_data.id or mutator_key

						DPackageManager:load_custom_script_data(mutator_key, data, type_mission, script_data)
					end)

					local id = "TPMissionObjects"
					local type_continent = "continent"
					DPackageManager:register_processor(module, id, type_continent, path, function(_, _, data)
						local name_id, units = "tp_unit_", {}
						local Vector3, Rotation = Vector3, Rotation

						local interaction_unit = "units/world/props/apartment/apartment_key_dummy/apartment_key_dummy"
						local lamp_unit = "units/world/props/apartment/apartment_hallway_lamp/apartment_hallway_lamp"
						local text_unit = "units/dev_tools/editable_text_long/editable_text_long"

						if Network:is_server() then
							for _, v in ipairs({
								{ interaction_unit, Vector3(-905, 275, 1780), Rotation(0, 180, 0) },
								{ interaction_unit, Vector3(-732, 275, 1780), Rotation(0, 180, 0) },
								{ interaction_unit, Vector3(-1065, 275, 1755), Rotation(-90, 225, 0) },
								{ interaction_unit, Vector3(-1025, 275, 1800), Rotation(0, 0, 0) },
								{ interaction_unit, Vector3(-560, 275, 1780), Rotation(0, 0, 0) },
							}) do
								table.insert(units, v)
							end
						end

						local color_white = Vector3(1, 1, 1)
						local get_text = function(text)
							return { text = text, font_color = color_white, font_size = "2" }
						end

						-- unsynced units
						for _, v in ipairs({
							-- enemy spawner
							{ text_unit, Vector3(-960, 210, 1735), Rotation(0, 90, 0), get_text("Enemies") },
							{ text_unit, Vector3(-965, 310, 1782.5), Rotation(0, -5, 0), get_text("Enemies") },
							{ text_unit, Vector3(-850, 340, 1735), Rotation(180, 90, 0), get_text("Enemies") },
							{ lamp_unit, Vector3(-905, 275, 1780), Rotation(0, 180, 0) },
							-- bag spawner
							{ text_unit, Vector3(-765, 210, 1735), Rotation(0, 90, 0), get_text("Bags") },
							{ text_unit, Vector3(-765, 310, 1782.5), Rotation(0, -5, 0), get_text("Bags") },
							{ text_unit, Vector3(-705, 340, 1735), Rotation(180, 90, 0), get_text("Bags") },
							{ lamp_unit, Vector3(-732, 275, 1780), Rotation(0, 180, 0) },
							-- weapon selector
							{ text_unit, Vector3(-1090, 310, 1705), Rotation(-90, 75, 0), get_text("Guns") },
							{ lamp_unit, Vector3(-1065, 275, 1755), Rotation(-90, 225, 0) },
							-- Test Button
							{ text_unit, Vector3(-595, 210, 1735), Rotation(0, 90, 0), get_text("Test") },
							{ text_unit, Vector3(-595, 310, 1782.5), Rotation(0, -5, 0), get_text("Test") },
							{ text_unit, Vector3(-530, 340, 1735), Rotation(180, 90, 0), get_text("Test") },
							{ lamp_unit, Vector3(-560, 275, 1780), Rotation(0, 180, 0) },
						}) do
							table.insert(units, v)
						end

						local lights_tbl, triggers_tbl = {}, {}
						local index_offset, unit_id_offset = #data.statics, 210660
						if Network:is_server() then
							name_id = name_id .. "s_"
							unit_id_offset = unit_id_offset + 40
						end

						for i = 1, #units do
							data.statics[index_offset + i] = {
								unit_data = {
									continent = "world",
									lights = lights_tbl,
									material_variation = "default",
									mesh_variation = "default",
									name = units[i][1],
									name_id = name_id .. i,
									position = units[i][2],
									rotation = units[i][3],
									editable_gui = units[i][4],
									triggers = triggers_tbl,
									unit_id = unit_id_offset + i,
								},
							}
						end
					end)
				end

				if not MutatorHelper.setup_mutator(module, mutator_key, availability, patches, true, true) then
					module.hooks_enabled = false
				end
			end,
		},
		{
			"lib/tweak_data/tweakdata",
			function(module)
				if module.hooks_enabled == false then
					return
				end

				local TweakData = module:hook_class("TweakData")
				module:post_hook(TweakData, "init", function(self)
					self.interaction.apartment_key = {}
					self.interaction.apartment_key.icon = "develop"
					self.interaction.apartment_key.text_id = "debug_interact_push_button"
					self.interaction.apartment_key.special_equipment = nil
					self.interaction.apartment_key.equipment_consume = false
					self.interaction.apartment_key.interact_distance = 150
				end)
			end,
		},
		{ "lib/managers/missionmanager", "elementgiveweapon" },
		{ "lib/managers/missionmanager", "elementincreaseindex" },
		{ "lib/managers/missionmanager", "elementspawnweapondummy" },
	},
	update = {
		id = "mutator_test_place",
		url = "https://raw.githubusercontent.com/mbien1981/dahm-modules/main/version.json",
	},
})
