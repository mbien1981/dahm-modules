local module = ... or D:module("mutator_test_place")
local CoreMissionScriptElement = core:import("CoreMissionScriptElement")
local ElementGiveWeapon = module:hook_class("ElementGiveWeapon", class, CoreMissionScriptElement.MissionScriptElement)

local ids_c45 = Idstring("units/weapons/c45/c45")
local ids_beretta92 = Idstring("units/weapons/beretta92/beretta92")
local ids_raging_bull = Idstring("units/weapons/raging_bull/raging_bull")
local ids_glock = Idstring("units/weapons/glock/glock")
local ids_m4_rifle = Idstring("units/weapons/m4_rifle/m4_rifle")
local ids_ak = Idstring("units/weapons/ak47/ak")
local ids_m14 = Idstring("units/weapons/m14/m14")
local ids_r870_shotgun = Idstring("units/weapons/r870_shotgun/r870_shotgun")
local ids_mossberg = Idstring("units/weapons/mossberg/mossberg")
local ids_mp5 = Idstring("units/weapons/mp5/mp5")
local ids_mac11 = Idstring("units/weapons/mac11/mac11")
local ids_hk21 = Idstring("units/weapons/hk21/hk21")
local ids_m79 = Idstring("units/weapons/m79/m79")

ElementGiveWeapon._index_to_weapon_list = {
	ids_c45,
	ids_beretta92,
	ids_raging_bull,
	ids_glock,
	ids_m4_rifle,
	ids_ak,
	ids_m14,
	ids_r870_shotgun,
	ids_mossberg,
	ids_mp5,
	ids_mac11,
	ids_hk21,
	ids_m79,
}
ElementGiveWeapon._weapon_name_to_id = {
	[ids_c45:key()] = "c45",
	[ids_beretta92:key()] = "beretta92",
	[ids_raging_bull:key()] = "raging_bull",
	[ids_glock:key()] = "glock",
	[ids_m4_rifle:key()] = "m4", -- test_raycast_weapon
	[ids_ak:key()] = "ak47",
	[ids_m14:key()] = "m14",
	[ids_r870_shotgun:key()] = "r870_shotgun",
	[ids_mossberg:key()] = "mossberg",
	[ids_mp5:key()] = "mp5",
	[ids_mac11:key()] = "mac11",
	[ids_hk21:key()] = "hk21",
	[ids_m79:key()] = "m79",
}

function ElementGiveWeapon:init(...)
	ElementGiveWeapon.super.init(self, ...)

	self._index = self._values.index or 0
end

function ElementGiveWeapon:increase_index()
	self._index = (self._index or 0) + 1
	if self._index > #self._index_to_weapon_list then
		self._index = 1
	end
end

function ElementGiveWeapon:get_weapon_name()
	return self._index_to_weapon_list[self._index]
end

function ElementGiveWeapon:give_weapon(unit)
	local state = unit:movement():current_state()
	if state:_is_reloading() or state:_changing_weapon() or state._melee_expire_t or state._use_item_expire_t then
		state._reload_enter_expire_t = nil
		state._reload_expire_t = nil
		state._reload_exit_expire_t = nil
	end

	self:add_unit_by_name(unit, self:get_weapon_name())

	managers.hud:_arrange_weapons()
	state._unit:camera():play_redirect(state.IDS_IDLE)
	managers.upgrades:setup_current_weapon()
end

function ElementGiveWeapon:add_unit_by_name(unit, name_id)
	for k, v in ipairs(unit:inventory()._available_selections) do
		if v.unit:name() == name_id then
			unit:inventory():equip_selection(k, true)
			return
		end
	end

	local remove_previous_weapon_icon = function(name_id) -- ghetto retarded fix
		local weapon_id = self._weapon_name_to_id[name_id:key()]
		local selection_index = tablex.get(tweak_data.weapon, weapon_id, "use_data", "selection_index")
		local weapon_data = tablex.get(managers.hud, "_hud", "weapons", selection_index)
		if selection_index and weapon_data then
			local animated_icon = weapon_data.b2
			if alive(animated_icon) then
				animated_icon:stop()
				animated_icon:hide()
				animated_icon:parent():remove(animated_icon)
				weapon_data.b2 = nil
			end

			if alive(weapon_data.magazine) then
				weapon_data.magazine:hide()
			end

			weapon_data.bitmap:hide()
			weapon_data.amount:hide()
		end
	end

	remove_previous_weapon_icon(name_id)
	unit:inventory():add_unit_by_name(name_id, true)
end

function ElementGiveWeapon:on_executed(instigator)
	if not self._values.enabled then
		return
	end

	if alive(instigator) and instigator == managers.player:player_unit() then
		if self:get_weapon_name() then
			self:give_weapon(instigator)
		end
	end

	ElementGiveWeapon.super.on_executed(self, instigator)
end

function ElementGiveWeapon:client_on_executed(...)
	self:on_executed(...)
end
