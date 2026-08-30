-- cards_data.lua

local M = {}

M.cards = {
	["fire_sword"] = {
		id          = "fire_sword",
		name        = "Огненный меч",
		description = "Горячий клинок, наносящий урон огнём",
		image       = "/assets/cards/fire_sword.png",
		rarity      = "rare",
		attack      = 12,
		defense     = 3,
		cost        = 4,
		type        = "weapon",
	},

	["healing_potion"] = {
		id          = "healing_potion",
		name        = "Зелье лечения",
		description = "Восстанавливает 30 здоровья",
		image       = "/assets/cards/healing_potion.png",
		rarity      = "common",
		heal        = 30,
		cost        = 2,
		type        = "consumable",
	},

	["ice_shield"] = {
		id          = "ice_shield",
		name        = "Ледяной щит",
		description = "Блокирует 15 урона и замедляет врага",
		image       = "/assets/cards/ice_shield.png",
		rarity      = "epic",
		defense     = 15,
		cost        = 5,
		type        = "armor",
	},
}

function M.get(id)
	return M.cards[id]
end

function M.get_all()
	return M.cards
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