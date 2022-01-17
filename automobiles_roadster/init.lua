--
-- constants
--
roadster={}
roadster.LONGIT_DRAG_FACTOR = 0.16*0.16
roadster.LATER_DRAG_FACTOR = 30.0
roadster.gravity = automobiles.gravity
roadster.max_speed = 15
roadster.max_acc_factor = 5
roadster.max_fuel = 10

roadster.front_wheel_xpos = 10.26
roadster.rear_wheel_xpos = 10.26

dofile(minetest.get_modpath("automobiles") .. DIR_DELIM .. "custom_physics.lua")
dofile(minetest.get_modpath("automobiles") .. DIR_DELIM .. "control.lua")
dofile(minetest.get_modpath("automobiles") .. DIR_DELIM .. "fuel_management.lua")
dofile(minetest.get_modpath("automobiles") .. DIR_DELIM .. "ground_detection.lua")
dofile(minetest.get_modpath("automobiles_roadster") .. DIR_DELIM .. "roadster_utilities.lua")
dofile(minetest.get_modpath("automobiles_roadster") .. DIR_DELIM .. "roadster_entities.lua")
dofile(minetest.get_modpath("automobiles_roadster") .. DIR_DELIM .. "roadster_forms.lua")


--    --minetest.add_entity(e_pos, "automobiles_roadster:target")
minetest.register_node("automobiles_roadster:display_target", {
	tiles = {"automobiles_red.png"},
	use_texture_alpha = true,
	walkable = false,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-.05,-.05,-.05, .05,.05,.05},
		},
	},
	selection_box = {
		type = "regular",
	},
	paramtype = "light",
	groups = {dig_immediate = 3, not_in_creative_inventory = 1},
	drop = "",
})

minetest.register_entity("automobiles_roadster:target", {
	physical = false,
	collisionbox = {0, 0, 0, 0, 0, 0},
	visual = "wielditem",
	-- wielditem seems to be scaled to 1.5 times original node size
	visual_size = {x = 0.67, y = 0.67},
	textures = {"automobiles_roadster:display_target"},
	timer = 0,
	glow = 10,

	on_step = function(self, dtime)

		self.timer = self.timer + dtime

		-- remove after set number of seconds
		if self.timer > 1 then
			self.object:remove()
		end
	end,
})