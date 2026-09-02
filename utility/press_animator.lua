-- utility/press_animator.lua

local M = {}

local DEFAULTS = {
	pressed_scale     = 0.92,
	normal_scale      = 1.0,
	press_duration    = 0.08,
	release_duration  = 0.15,
	press_easing      = go.EASING_OUTQUAD,
	release_easing    = go.EASING_OUTBACK,
}

function M.down(target, opts)
	opts = opts or {}
	local scale    = opts.scale    or DEFAULTS.pressed_scale
	local duration = opts.duration or DEFAULTS.press_duration
	local easing   = opts.easing   or DEFAULTS.press_easing

	go.cancel_animations(target, "scale")
	go.animate(target, "scale", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(scale), easing, duration)
end

function M.up(target, opts)
	opts = opts or {}
	local scale    = opts.scale    or DEFAULTS.normal_scale
	local duration = opts.duration or DEFAULTS.release_duration
	local easing   = opts.easing   or DEFAULTS.release_easing

	go.cancel_animations(target, "scale")
	go.animate(target, "scale", go.PLAYBACK_ONCE_FORWARD, vmath.vector3(scale), easing, duration)
end

function M.reset(target, scale)
	go.cancel_animations(target, "scale")
	go.set_scale(vmath.vector3(scale or DEFAULTS.normal_scale), target)
end

function M.gui_down(node, opts)
	opts = opts or {}

	local scale = opts.scale or DEFAULTS.pressed_scale
	local duration = opts.duration or DEFAULTS.press_duration
	local easing = opts.easing or DEFAULTS.press_easing

	gui.cancel_animations(node, gui.PROP_SCALE)

	gui.animate(
	node,
	gui.PROP_SCALE,
	vmath.vector3(scale),
	easing,
	duration
)
end

function M.gui_up(node, opts)
opts = opts or {}

local scale = opts.scale or DEFAULTS.normal_scale
local duration = opts.duration or DEFAULTS.release_duration
local easing = opts.easing or DEFAULTS.release_easing

gui.cancel_animations(node, gui.PROP_SCALE)

gui.animate(
node,
gui.PROP_SCALE,
vmath.vector3(scale),
easing,
duration
)
end

function M.gui_reset(node, scale)
gui.cancel_animations(node, gui.PROP_SCALE)
gui.set_scale(node, vmath.vector3(scale or DEFAULTS.normal_scale))
end

return M