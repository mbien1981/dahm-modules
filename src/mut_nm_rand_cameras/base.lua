return DMod:new("nm_rand_cams", {
	name = "No Mercy Random Cameras",
	author = "_atom",
	dependencies = { "scriman", "ovk_193" },
	category = "mutator",
	hooks = {
		{
			"OnModuleLoading",
			"OnModuleLoading_SetupAsMutator",
			function(module)
				local availability = {
					overkill = { levels = { hospital = true } },
					overkill_145 = { levels = { hospital = true } },
					overkill_193 = { levels = { hospital = true } },
				}

				local mutator_key = module:id()
				if not MutatorHelper.setup_mutator(module, mutator_key, availability, nil, false, false) then
					return
				end

				local script_type = "mission"
				local path = "levels/l4d/mission/mission"
				DPackageManager:register_processor(module, mutator_key, script_type, path, function(_, _, data)
					local script_data = loadfile(module:path() .. "missionscripts/hospital.lua")()
					if type(script_data) ~= "table" then
						return
					end

					script_data.id = mutator_key

					DPackageManager:load_custom_script_data(mutator_key, data, script_type, script_data)
				end)
			end,
		},
	},
	localization = {
		["mutator_nm_rand_cams"] = "Random Cameras (4 Players)",
		["mutator_nm_rand_cams_help"] = {
			english = "Adds a chance for there to be 12 cameras if there is four human players.",
		},
		["mutator_nm_rand_cams_motd"] = {
			english = "This server is running a mutator which adds a chance for there to be 12 cameras when there is four players.",
		},
	},
})
