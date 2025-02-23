local module = ... or D:module("sleeve_selector")

local PlayerCamera = module:hook_class("PlayerCamera")
module:hook(50, PlayerCamera, "spawn_camera_unit", function(self)
	local unit_folder = managers.player.selected_suit or "suit"

	local level_id = tablex.get(Global, "level_data", "level_id")
	if unit_folder == "suit" and level_id == "hospital" then
		unit_folder = "default"
	end

	if unit_folder == "default" then
		unit_folder = tablex.get(tweak_data.levels, level_id, "unit_suit") or "suit"
	end

	self._camera_unit = World:spawn_unit(
		Idstring("units/characters/fps/" .. unit_folder .. "/fps_hand"),
		self._m_cam_pos,
		self._m_cam_rot
	)

	self._machine = self._camera_unit:anim_state_machine()
	self._unit:link(self._camera_unit)
	self._camera_unit:base():set_parent_unit(self._unit)
	self._camera_unit:base():reset_properties()
	self._camera_unit:base():set_stance_instant("standard")
end)
