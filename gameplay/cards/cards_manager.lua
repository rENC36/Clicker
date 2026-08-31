local cards_data = require("gameplay.cards.cards_data")
local constants = require("utility.constants")
local save = require("utility.save")

local M = {}

M.active_cards = {}
M.money = 0

function M.load_money()
	local data = save.load("player_save", { money = 0 })
	M.money = data.money or 0
end

function M.save_money()
	save.save("player_save", { money = M.money })
end

function M.add_money(amount)
	M.money = M.money + amount
	M.save_money()
	msg.post(constants.MAIN_SCRIPT, "update_money_ui", { money = M.money })
end

function M.get_money()
	return M.money
end

function M.get(id)
	local card = cards_data.get(id)
	if not card then print("Card not found:", id) end
	return card
end

function M.get_all() return cards_data.get_all() end
function M.get_by_rarity(rarity) return cards_data.get_by_filter(function(c) return c.rarity == rarity end) end
function M.get_by_type(type) return cards_data.get_by_filter(function(c) return c.type == type end) end

function M.create(id, position, parent)
	local data = M.get(id)
	if not data then 
		print("ERROR: No data for card id:", id)
		return nil 
	end

	position = position or vmath.vector3(0, 0, 0)
	local card_url = factory.create(constants.CARD_FACTORY, position)

	if not card_url then
		print("ERROR: factory.create failed!")
		return nil
	end

	local card_key = tostring(card_url)
	M.active_cards[card_key] = { url = card_url, data = data }

	if parent then
		msg.post(card_url, "set_parent", { parent_id = parent })
	end

	msg.post(card_url, "setup_card", data)
	return card_url
end

function M.destroy(card_url)
	if not card_url then return end
	local card_key = tostring(card_url)
	M.active_cards[card_key] = nil
	go.delete(card_url)
end

function M.get_active_cards()
	return M.active_cards
end

function M.try_merge(key1, key2)
	local card1 = M.active_cards[key1]
	local card2 = M.active_cards[key2]

	if not card1 or not card2 then
		print("Merge failed: card not found")
		return false
	end

	local result_id = cards_data.can_merge(card1.data.id, card2.data.id)

	if result_id then
		local pos1 = go.get_position(card1.url)
		local pos2 = go.get_position(card2.url)
		local mid_pos = (pos1 + pos2) * 0.5

		M.destroy(card1.url)
		M.destroy(card2.url)
		M.create(result_id, mid_pos)

		print("Merge SUCCESS! Created:", result_id)
		return true
	end

	return false
end

return M