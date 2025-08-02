local module = ... or D:module("mutator_test_place")
local CoreMissionScriptElement = core:import("CoreMissionScriptElement")
local ElementIncreaseIndex =
	module:hook_class("ElementIncreaseIndex", class, CoreMissionScriptElement.MissionScriptElement)

function ElementIncreaseIndex:init(...)
	ElementIncreaseIndex.super.init(self, ...)
end

function ElementIncreaseIndex:on_executed(instigator)
	if not self._values.enabled then
		return
	end

	for _, id in ipairs(self._values.elements) do
		local element = self:get_mission_element(id)
		if element and element.increase_index then
			element:increase_index()
		end
	end

	ElementIncreaseIndex.super.on_executed(self, instigator)
end

function ElementIncreaseIndex:client_on_executed(...)
	self:on_executed(...)
end
