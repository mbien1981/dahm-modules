local bank_manager_path = "units/characters/bank_manager/bank_manager2"
local nurse_path = "units/characters/civilians/hospital_female_nurse2/hospital_female_nurse2"

-- list of civilians we want to be able to speak during stealth phase
local whisper_list = {
	[Idstring(bank_manager_path):key()] = true,
	[Idstring(nurse_path):key()] = true,
}

local module = ... or D:module("mute_civilians")
local CopSound = module:hook_class("CopSound")
module:post_hook(CopSound, "init", function(self, unit)
	local tweak_table = unit:base()._tweak_table
	self._speech_disabled = tweak_data.character[tweak_table].speech_disabled or false

	self._allow_during_whisper = whisper_list[unit:name():key()]
end)

module:hook(CopSound, "speech_allowed", function(self)
	if not self._speech_disabled then
		return true
	end

	local is_stealth = managers.groupai:state():whisper_mode()
	if is_stealth and self._allow_during_whisper then
		return true
	end

	if D:conf("mute_on_loud") then
		return is_stealth
	end

	return false
end)

module:hook(CopSound, "_play", function(self, sound_name, source_name)
	if not self:speech_allowed() then
		return nil
	end

	local source = source_name and Idstring(source_name)
	return self._unit:sound_source(source):post_event(sound_name)
end)
