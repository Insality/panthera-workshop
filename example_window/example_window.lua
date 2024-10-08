local component = require("druid.component")
local panthera = require("panthera.panthera")
local tweener = require("tweener.tweener")

local ui_spin_slot = require("example_window.ui_spin_slot.ui_spin_slot")

---@class example_window: druid.base_component
---@field druid druid_instance
---@field button_spin druid.button
---@field spins ui_spin_slot[]
local M = component.create("example_window")


function M:init(template, nodes)
	self:set_template(template)
	self:set_nodes(nodes)
	self.druid = self:get_druid()

	self.button_spin = self.druid:new_button("button_spin/root", self.on_press_spin)

	self.spins = {
		self.druid:new(ui_spin_slot, "spin_slot_1"),
		self.druid:new(ui_spin_slot, "spin_slot_2"),
		self.druid:new(ui_spin_slot, "spin_slot_3"),
	}

	self.spins[1]:set_numbers(1 + 3, 1 + 2, 1 + 1, 1)
	self.spins[2]:set_numbers(1 + 3, 1 + 2, 1 + 1, 1)
	self.spins[3]:set_numbers(1 + 3, 1 + 2, 1 + 1, 1)
end


function M:on_press_spin()
	self:spin_slot(self.spins[1], 0)
	self:spin_slot(self.spins[2], 0.1)
	self:spin_slot(self.spins[3], 0.3)
end

---@param slot ui_spin_slot
function M:spin_slot(slot, delay)
	timer.delay(delay, false, function()
		slot:play_spin_animation()

		tweener.tween(gui.EASING_OUTBACK, 0, 12, 3, function(value, is_final)
			local progress = value % 1
			slot:set_spin_progress(progress)

			local index = math.floor(value) + 1
			slot:set_numbers(index + 3, index + 2, index + 1, index)

			if is_final then
				slot:play_end_spin_animation()
			end
		end)
	end)
end


function M:start_spin_animation()
	local spins = 16 + math.random(-4, 4)
	local spin_time = 4 + (math.random() * 4 - 2)
	local max_time = 0.45 + spin_time
end


---@param spin_slot ui_spin_slot
function M:spin(spin_slot, numbers, spin_time, spin_amount, delay)
	delay = delay or 0
	timer.delay(delay, false, function()
		spin_slot:play_spin_animation()

		tweener.tween(gui.EASING_OUTBACK, 0, spin_amount, spin_time, function(value, is_final)
			local spin_value = value % 1
			local index = math.floor(value) + 1
			spin_slot:set_numbers(numbers[index + 3], numbers[index + 2], numbers[index + 1], numbers[index])
			spin_slot:set_spin_progress(spin_value)

			if is_final then
				spin_slot:play_end_spin_animation()
			end
		end)
	end)
end


return M
