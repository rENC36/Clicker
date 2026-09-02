local M = {}

M.cards = {
	["Zero Two"] = {
		id = "Zero Two", 
		name = "Zero", 
		image = "Zero Two", 
		rarity = "common",
		reward = 10,
	},
	["Sakura"] = {
		id = "Sakura", 
		name = "Sakura", 
		image = "Sakura", 
		rarity = "common",
		reward = 15,
	},
	["MergedHero"] = {
		id = "MergedHero", 
		name = "MergedHero", 
		image = "MergedHero", 
		rarity = "rare",
		reward = 50,
	},
}

M.merges = {
	["Zero Two"] = {
		["Zero Two"] = "Sakura"
	},
	["Sakura"] = {
		["Sakura"] = "MergedHero"
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