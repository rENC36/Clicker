---number_format.lua
local M = {}

local SUFFIXES = {
	{ value = 1000000000000, suffix = "T" },
	{ value = 1000000000, suffix = "B" },
	{ value = 1000000, suffix = "M" },
	{ value = 1000, suffix = "K" },
}

local function format_short_number(value)
	if value >= 100 then
		return string.format("%.0f", value)
	elseif value >= 10 then
		return string.format("%.1f", value)
	else
		return string.format("%.2f", value)
	end
end

local function remove_trailing_zeroes(value)
	value = value:gsub("(%..-)0+$", "%1")
	value = value:gsub("%.$", "")
	return value
end

function M.format(value)
	value = tonumber(value) or 0

	if value < 0 then
		return "-" .. M.format(-value)
	end

	if value < 1000 then
		return tostring(math.floor(value))
	end

	for index, item in ipairs(SUFFIXES) do
		if value >= item.value then
			local short_value = value / item.value

			-- Например, 999999 превращается в 1M,
			-- а не в 1000K
			if short_value >= 999.5 and index > 1 then
				local bigger_item = SUFFIXES[index - 1]
				short_value = value / bigger_item.value
				item = bigger_item
			end

			local result = format_short_number(short_value)
			result = remove_trailing_zeroes(result)

			return result .. item.suffix
		end
	end

	return tostring(math.floor(value))
end

return M