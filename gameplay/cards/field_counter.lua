-- gameplay/cards/field_counter.lua

local constants = require("utility.constants")

local M = {}

-- @param active_cards
function M.get_count(active_cards)
	local count = 0
	for _ in pairs(active_cards) do
		count = count + 1
	end
	return count
end

function M.get_max()
	return constants.MAX_FIELD_CARDS
end

function M.is_full(active_cards)
	return M.get_count(active_cards) >= constants.MAX_FIELD_CARDS
end

function M.format(active_cards)
	return M.get_count(active_cards) .. "/" .. M.get_max()
end

return M