return {
	delete_unit = function(unit)
		if alive(unit) then
			if unit.interaction and unit:interaction() then
				unit:interaction():set_active(false)
			end

			unit:set_slot(0)
			World:delete_unit(unit)
		end
	end,
	spawn_enemy = function(enemy, position, offset, rotation, func)
		local path = string.format("units/characters/enemies/%s/%s", tostring(enemy), tostring(enemy))

		local unit = safe_spawn_unit(Idstring(path), position + offset, rotation or Rotation(180, 0, 0))
		if not alive(unit) then
			return
		end

		local action_data = {
			type = "act",
			variant = "clean",
			body_part = 1,
			align_sync = true,
		}
		local spawn_ai = {
			init_state = "inactive",
			objective = {
				type = "act",
				action = action_data,
				interrupt_on = "none",
			},
		}

		-- if alive(unit:inventory()._shield_unit) then
		-- 	unit:inventory()._shield_unit:unlink()
		-- 	unit:inventory()._shield_unit:set_slot(0)
		-- end

		unit:brain():set_spawn_ai(spawn_ai)
		unit:movement():set_allow_fire(false)

		unit:brain().set_logic = function() end
		unit:movement()._upd_actions = function() end
		unit:movement().set_allow_fire = function() end
		-- unit:inventory().drop_shield = function() end
		unit:character_damage().drop_pickup = function() end
		unit:character_damage()._spawn_head_gadget = function() end

		if type(func) == "function" then
			func(unit)
		end

		return unit
	end,
	spawn_weapon = function(unit_id, position, rotation)
		local weapon_unit = safe_spawn_unit(unit_id, position, rotation)
		if not alive(weapon_unit) then
			return nil
		end

		weapon_unit:base():setup({
			user_unit = managers.player:player_unit(),
			ignore_units = {
				managers.player:player_unit(),
				weapon_unit,
			},
		})

		return weapon_unit
	end,
	give_weapon = function(weapon_id)
		local add_unit_by_name = function(player, name_id)
			for k, v in ipairs(player:inventory()._available_selections) do
				if v.unit:name() == name_id then
					player:inventory():equip_selection(k, true)
					return
				end
			end

			player:inventory():add_unit_by_name(name_id, true)
		end

		local player = managers.player:player_unit()
		if not alive(player) then
			return
		end

		local state = player:movement():current_state()
		if state:_is_reloading() or state:_changing_weapon() or state._melee_expire_t or state._use_item_expire_t then
			state._reload_enter_expire_t = nil
			state._reload_expire_t = nil
			state._reload_exit_expire_t = nil
		end

		add_unit_by_name(player, weapon_id)

		managers.hud:_arrange_weapons()
		state._unit:camera():play_redirect(state.IDS_IDLE)
		managers.upgrades:setup_current_weapon()
	end,
	user_script = function ()
		dlog("Hello, World!")
	end
}
