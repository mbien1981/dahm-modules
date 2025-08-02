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
		-- unit:character_damage().drop_pickup = function() end
		unit:character_damage()._spawn_head_gadget = function() end

		if type(func) == "function" then
			func(unit)
		end

		return unit
	end,
	user_script = function ()
		dlog("Hello, World!")
	end
}
