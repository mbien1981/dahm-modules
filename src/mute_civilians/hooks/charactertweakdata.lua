local module = ... or D:module("mute_civilians")

local CharacterTweakData = module:hook_class("CharacterTweakData")
module:post_hook(CharacterTweakData, "init", function(self)
	local D = D

	self.civilian.speech_disabled = D:conf("mute_male")
	self.civilian_female.speech_disabled = D:conf("mute_female")
	self.bank_manager.speech_disabled = D:conf("mute_bank_manager")

	self.escort.speech_disabled = D:conf("mute_escorts")
	self.escort_suitcase.speech_disabled = D:conf("mute_escorts")
	self.escort_prisoner.speech_disabled = D:conf("mute_escorts")
	self.escort_ralph.speech_disabled = D:conf("mute_escorts")
	self.escort_cfo.speech_disabled = D:conf("mute_escorts")
	self.escort_undercover.speech_disabled = D:conf("mute_escorts")
end)
