return DMod:new("smart_weapon_switch", {
	name = "Smart Weapon Switch",
	description = "Improves weapon switching logic: queue switches while reloading, change queued selection mid-switch, and double-tap to override instantly.",
	author = "_atom",
	version = "1.0",
	categories = { "QoL", "gameplay" },
	hooks = {
		["lib/units/beings/player/states/playerstandard"] = function(module)
			local PlayerStandard = module:hook_class("PlayerStandard")

			local WEAPON_EQUIPPED = "equipped"
			local WEAPON_UNEQUIPPED = "unequipped"

			module:hook(PlayerStandard, "_check_action_equip", function(self, t, input)
				local new_action

				local input_index = input.btn_primary_choice
				local pending_index = self._wanted_index
				local queued_index = self._queued_reload_switch_index

				local selection_wanted = input_index or pending_index or queued_index
				if not selection_wanted or not self._ext_inventory:is_selection_available(selection_wanted) then
					return new_action
				end

				local is_reloading = self:_is_reloading()
				local is_equipped = self._ext_inventory:is_equipped(selection_wanted)

				if not is_reloading and queued_index then
					self._selection_wanted = true
					self._wanted_index = queued_index
					self._queued_reload_switch_index = nil
					self._queued_reload_switch_t = nil
				end

				if is_reloading and input_index and not is_equipped then
					local last_index = self._queued_reload_switch_index
					local last_time = self._queued_reload_switch_t or 0
					local delay = t - last_time

					if last_index == input_index and delay < 0.35 then
						self:_start_action_unequip_weapon(t, { selection_wanted = input_index })
						self._selection_wanted = false
						self._wanted_index = nil
						self._queued_reload_switch_index = nil
						self._queued_reload_switch_t = nil
						new_action = true
						return new_action
					else
						self._queued_reload_switch_index = input_index
						self._queued_reload_switch_t = t
					end
				end

				local action_forbidden = self:chk_action_forbidden("equip")
					or self._melee_expire_t
					or self._use_item_expire_t
					or self._equip_weapon_expire_t
					or self:_interacting()
					or (is_reloading and not pending_index)

				if not action_forbidden then
					new_action = not is_equipped
					if new_action then
						self:_start_action_unequip_weapon(t, { selection_wanted = selection_wanted })
						self._selection_wanted = false
						self._wanted_index = nil
						self._queued_reload_switch_index = nil
						self._queued_reload_switch_t = nil
					end
				end

				return new_action
			end)

			function PlayerStandard:_queue_weapon_switch_during_reload(index)
				self._selection_wanted = true
				self._wanted_index = index
			end

			module:hook(PlayerStandard, "_start_action_unequip_weapon", function(self, t, data)
				self._equipped_unit:base():tweak_data_anim_play("unequip")

				local tweak_data = self._equipped_unit:base():weapon_tweak_data()
				self._change_weapon_data = data

				self:_interupt_action_running(t)

				if not self._weapon_state or self._weapon_state == WEAPON_EQUIPPED then
					self._unequip_weapon_expire_t = t + (tweak_data.timers.unequip or 0.5)
					self._weapon_state = WEAPON_UNEQUIPPED
					self._unit:camera():play_redirect(self.IDS_UNEQUIP)
				end

				self:_interupt_action_reload(t)
				self:_interupt_action_steelsight(t)
			end)

			module:post_hook(PlayerStandard, "_start_action_equip_weapon", function(self, t)
				self._weapon_state = WEAPON_EQUIPPED
			end)
		end,
	},
})
