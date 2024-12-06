local module = ... or D:module("mute_civilians")

local strings = {
	["menu_mute_male"] = { english = "Mute male civilians" },
	["menu_mute_female"] = { english = "Mute female civilians" },
	["menu_mute_bank_manager"] = { english = "Mute bank manager" },
	["menu_mute_escorts"] = { english = "Mute escorts" },
	["menu_mute_civilians_on_loud"] = { english = "Only mute on loud" },
	["menu_mute_civilians_on_loud_help"] = { english = "Will only apply mute settings if the heist goes loud." },
}

for key, translations in pairs(strings) do
	module:add_localization_string(key, translations)
end
