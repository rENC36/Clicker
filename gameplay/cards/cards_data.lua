---cards_data.lua
local M = {}

local chain = {
	-- Common
	{
		id = "1_com",
		name = "Blossom",
		rarity = "common",
		reward = 10,
	},
	{
		id = "2_com",
		name = "The Boss",
		rarity = "common",
		reward = 15,
	},
	{
		id = "3_com",
		name = "Fashionista",
		rarity = "common",
		reward = 25,
	},
	{
		id = "4_com",
		name = "Darling",
		rarity = "common",
		reward = 40,
	},
	{
		id = "5_com",
		name = "Cosplayer",
		rarity = "common",
		reward = 60,
	},
	{
		id = "6_com",
		name = "Butterfly",
		rarity = "common",
		reward = 90,
	},

	-- Rare
	{
		id = "1_rare",
		name = "Goddess",
		rarity = "rare",
		reward = 130,
	},
	{
		id = "2_rare",
		name = "Frieren",
		rarity = "rare",
		reward = 180,
	},
	{
		id = "3_rare",
		name = "Momo",
		rarity = "rare",
		reward = 250,
	},
	{
		id = "4_rare",
		name = "Ram",
		rarity = "rare",
		reward = 350,
	},
	{
		id = "5_rare",
		name = "Hinata",
		rarity = "rare",
		reward = 500,
	},
	{
		id = "6_rare",
		name = "Chica",
		rarity = "rare",
		reward = 700,
	},

	-- Epic
	{
		id = "1_epic",
		name = "Reze",
		rarity = "epic",
		reward = 1000,
	},
	{
		id = "2_epic",
		name = "Violett",
		rarity = "epic",
		reward = 1400,
	},
	{
		id = "3_epic",
		name = "Hoshino",
		rarity = "epic",
		reward = 2000,
	},
	{
		id = "4_epic",
		name = "Ochaco",
		rarity = "epic",
		reward = 2800,
	},
	{
		id = "5_epic",
		name = "Mai",
		rarity = "epic",
		reward = 4000,
	},
	{
		id = "6_epic",
		name = "Fubuki",
		rarity = "epic",
		reward = 5500,
	},

	-- Legendary
	{
		id = "1_leg",
		name = "Mikasa",
		rarity = "legendary",
		reward = 7500,
	},
	{
		id = "2_leg",
		name = "Rin",
		rarity = "legendary",
		reward = 10000,
	},
	{
		id = "3_leg",
		name = "Kaori",
		rarity = "legendary",
		reward = 14000,
	},
	{
		id = "4_leg",
		name = "Monika",
		rarity = "legendary",
		reward = 20000,
	},
	{
		id = "5_leg",
		name = "Asuna",
		rarity = "legendary",
		reward = 28000,
	},
	{
		id = "6_leg",
		name = "Misato",
		rarity = "legendary",
		reward = 40000,
	},
}

M.cards = {}

for _, card in ipairs(chain) do
	M.cards[card.id] = {
		id = card.id,
		name = card.name,

		-- Название анимации в character.atlas
		image = card.id,

		rarity = card.rarity,
		reward = card.reward,
	}
end

M.merges = {}

for index = 1, #chain - 1 do
	local current_id = chain[index].id
	local next_id = chain[index + 1].id

	M.merges[current_id] = {
		[current_id] = next_id
	}
end

function M.get(id)
	return M.cards[id]
end

function M.get_all()
	return M.cards
end

function M.can_merge(id1, id2)
	if M.merges[id1] and M.merges[id1][id2] then
		return M.merges[id1][id2]
	end

	return nil
end

function M.get_by_filter(filter_func)
	local result = {}

	for id, card in pairs(M.cards) do
		if filter_func(card) then
			table.insert(result, card)
		end
	end

	return result
end

return M