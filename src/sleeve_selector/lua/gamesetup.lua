local module = ... or D:module("sleeve_selector")

local GameSetup = module:hook_class("GameSetup")

local mesh_to_level_translation = {
	bank = "suit",
	heat_street = "suit",
	apartment = "suit",
	bridge = "raincoat",
	diamond_heist = "cat_suit",
	slaughter_house = "cat_suit",
	suburbia = "suburbia",
	secret_stash = "cat_suit",
	hospital = "suit", -- "scrubs" }
}

local packages = {
	suit = "packages/level_bank",
	cat_suit = "packages/level_slaughterhouse",
	suburbia = "packages/level_suburbia",
	raincoat = "packages/level_bridge",
}

module:post_hook(GameSetup, "init_finalize", function(self)
	local level_id = tablex.get(Global.game_settings, "level_id")
	if not level_id then
		return
	end

	local selected_suit = managers.player.selected_suit or "default"
	if selected_suit == "default" or selected_suit == mesh_to_level_translation[level_id] then
		return
	end

	local selected_package = packages[selected_suit]
	if not selected_package then
		return
	end

	if not PackageManager:loaded(selected_package) then
		PackageManager:load(selected_package)
	end
end)

module:post_hook(50, GameSetup, "unload_packages", function(self)
	for _, package in pairs({
		"packages/level_bank",
		"packages/level_slaughterhouse",
		"packages/level_suburbia",
		"packages/level_bridge",
	}) do
		if PackageManager:loaded(package) then
			PackageManager:unload(package)
		end
	end
end)
