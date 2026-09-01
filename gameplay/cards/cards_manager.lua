local cards_data = require("gameplay.cards.cards_data")
local constants = require("utility.constants")
local player = require("utility.player")
local press = require("utility.press_animator")

local M = {}

M.active_cards = {}
M.dragging_key = nil

function M.get_money()
	return player.get_money()
end

function M.add_money(amount)
	player.add_money(amount)
	msg.post(constants.INTERACTION, "update_money_ui", { money = player.get_money() })
end

function M.is_dragging()
	return M.dragging_key ~= nil
end

function M.set_dragging(key)
	M.dragging_key = key
end

function M.clear_dragging()
	M.dragging_key = nil
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

function M.get_random_spawn_pos()
	local x = math.random(-350, 350)
	local y = math.random(-200, 150)
	return vmath.vector3(x, y, 0)
end

function M.buy_card(position)
	local price = player.get_shop_price()

	if player.get_money() < price then
		return false
	end

	local cards = constants.STARTER_CARDS
	local random_id = cards[math.random(1, #cards)]

	player.add_money(-price)
	msg.post(constants.MAIN_SCRIPT, "update_money_ui", { money = player.get_money() })

	position = position or M.get_random_spawn_pos()
	local card_url = M.create(random_id, position)

	if card_url then
		M.save_field()
		return true
	end

	player.add_money(price)
	msg.post(constants.MAIN_SCRIPT, "update_money_ui", { money = player.get_money() })
	return false
end

function M.try_merge(key1, key2)
	local card1 = M.active_cards[key1]
	local card2 = M.active_cards[key2]

	if not card1 or not card2 then
		return false
	end

	local result_id = cards_data.can_merge(card1.data.id, card2.data.id)

	if result_id then
		local pos1 = go.get_position(card1.url)
		local pos2 = go.get_position(card2.url)
		local mid_pos = (pos1 + pos2) * 0.5

		press.reset(card1.url)
		press.reset(card2.url)

		M.destroy(card1.url)
		M.destroy(card2.url)

		local new_card = M.create(result_id, mid_pos)
		if new_card then
			press.reset(new_card)
		end

		M.clear_dragging()
		M.save_field()     
		        
		print("Merge SUCCESS! Created:", result_id)
		return true
	end

	return false
end

function M.save_field()
	local list = {}
	for _, card_info in pairs(M.active_cards) do
		local pos = go.get_position(card_info.url)
		table.insert(list, {
			id = card_info.data.id,
			x = pos.x,
			y = pos.y,
			z = pos.z
		})
	end
	player.set_field_cards(list)
end

function M.load_field()
	local list = player.get_field_cards()
	for _, item in ipairs(list) do
		M.create(item.id, vmath.vector3(item.x, item.y, item.z or 0))
	end
end

return M