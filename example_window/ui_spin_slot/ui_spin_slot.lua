local component = require("druid.component")
local panthera = require("panthera.panthera")
local animation = require("example_window.ui_spin_slot.ui_spin_slot_panthera")

---@class ui_spin_slot: druid.base_component
local M = component.create("ui_spin_slot")

function M:init(template, nodes)
	self:set_template(template)
	self:set_nodes(nodes)
	self.druid = self:get_druid()
	self.root = self:get_node("root")

	self.animation = panthera.create_gui(animation, self:get_template(), nodes)
	self.animation_fx = panthera.create_gui(animation, self:get_template(), nodes)

	self.value_extra = math.random(1, 9)
	self.value_up = math.random(1, 9)
	self.value = math.random(1, 9)
	self.value_down = math.random(1, 9)

	self.text_value_extra = self:get_node("text_value_extra")
	self.text_value_up = self:get_node("text_value_up")
	self.text_value = self:get_node("text_value")
	self.text_value_down = self:get_node("text_value_down")

	gui.set_text(self.text_value_extra, tostring(self.value_extra))
	gui.set_text(self.text_value_up, tostring(self.value_up))
	gui.set_text(self.text_value, tostring(self.value))
	gui.set_text(self.text_value_down, tostring(self.value_down))
end


function M:set_spin_progress(progress)
	panthera.set_time(self.animation, "spin", progress)
	--panthera.play(self.animation, "spin")
end


function M:play_spin_animation()
	panthera.play(self.animation_fx, "on_start_spin", {
		callback_event = function(event_id, node, data, number)
			print("-" .. event_id, node, data, number)
		end
	})
end


function M:play_end_spin_animation()
	panthera.play(self.animation_fx, "on_end_spin")
end


function M:push_spot_value(value)
	self.value_down = self.value
	self.value = self.value_up
	self.value_up = self.value_extra
	self.value_extra = value

	gui.set_text(self.text_value_extra, tostring(self.value_extra))
	gui.set_text(self.text_value_up, tostring(self.value_up))
	gui.set_text(self.text_value, tostring(self.value))
	gui.set_text(self.text_value_down, tostring(self.value_down))
end


function M:set_numbers(value_extra, value_up, value, value_down)
	self.value_extra = value_extra
	self.value_up = value_up
	self.value = value
	self.value_down = value_down

	gui.set_text(self.text_value_extra, tostring(self.value_extra))
	gui.set_text(self.text_value_up, tostring(self.value_up))
	gui.set_text(self.text_value, tostring(self.value))
	gui.set_text(self.text_value_down, tostring(self.value_down))
end


return M
