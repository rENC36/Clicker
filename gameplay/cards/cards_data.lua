local M = {}

M.cards = {
	["1_com"] = {
		id = "1_com", 
		name = "Blossom", 
		image = "1_com", 
		rarity = "common",
		reward = 10,
	},
	["2_com"] = {
		id = "2_com", 
		name = "The Boss", 
		image = "2_com", 
		rarity = "common",
		reward = 15,
	},
	["3_com"] = {
		id = "3_com", 
		name = "Fashionista", 
		image = "3_com", 
		rarity = "common",
		reward = 50,
	},
}

M.merges = {
	["1_com"] = {
		["1_com"] = "2_com"
	},
	["2_com"] = {
		["2_com"] = "3_com"
	}
}

function M.get(id) return M.cards[id] end
function M.get_all() return M.cards end

function M.can_merge(id1, id2)
	if M.merges[id1] and M.merges[id1][id2] then
		return M.merges[id1][id2]
	end
	return nil
end

function M.get_by_filter(filter_func)
	local result = {}
	for id, card in pairs(M.cards) do
		if filter_func(card) then table.insert(result, card) end
	end
	return result
end

return M