local module = ... or D:module("mutator_test_place")
local CoreMissionScriptElement = core:import("CoreMissionScriptElement")
local ElementSpawnWeaponDummy =
	module:hook_class("ElementSpawnWeaponDummy", class, CoreMissionScriptElement.MissionScriptElement)

function ElementSpawnWeaponDummy:init(...)
	ElementSpawnWeaponDummy.super.init(self, ...)

	self._target_element = self._values.target_element or self._id
	self._unit_name = self._values.unit and Idstring(self._values.unit) or Idstring("units/dummy_unit_1/dummy_unit_1")
end

function ElementSpawnWeaponDummy:produce()
	local unit = self:_spawn_unit(self._unit_name, self._values.position, self._values.rotation)
	if unit then
		self._dummy_unit = unit

		unit:base():setup({
			user_unit = managers.player:player_unit(),
			ignore_units = { managers.player:player_unit(), unit },
		})
	end

	return unit
end

function ElementSpawnWeaponDummy:delete_previous_dummy()
	local unit = self._dummy_unit
	if unit then
		unit:set_slot(0)
		World:delete_unit(unit)
	end
end

function ElementSpawnWeaponDummy:_spawn_unit(name, pos, rot)
	return safe_spawn_unit(name, pos, rot)
end

function ElementSpawnWeaponDummy:on_executed(instigator)
	if not self._values.enabled then
		return
	end

	self:update_unit_name()
	self:delete_previous_dummy()
	self:produce()

	ElementSpawnWeaponDummy.super.on_executed(self, instigator)
end

function ElementSpawnWeaponDummy:update_unit_name()
	local element = self:get_mission_element(self._target_element)
	if element and element.get_weapon_name then
		self._unit_name = element:get_weapon_name()
	end
end

function ElementSpawnWeaponDummy:client_on_executed(...)
	self:on_executed(...)
end
