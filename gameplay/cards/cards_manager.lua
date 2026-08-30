-- cards_manager.lua

local cards_data = require("main.cards_data")

local M = {}

M.CARD_FACTORY = "/main/card_factory#factory"

function M.get(id)
	local card = cards_data.get(id)
	if not card then
		print("Card not found:", id)
	end
	return card
end

function M.get_all()
	return cards_data.get_all()
end

function M.get_by_rarity(rarity)
	return cards_data.get_by_filter(function(c) return c.rarity == rarity end)
end

function M.get_by_type(type)
	return cards_data.get_by_filter(function(c) return c.type == type end)
end

function M.create(id, position, parent)
	local data = M.get(id)
	if not data then
		return nil
	end

	position = position or vmath.vector3(0, 0, 0)

	local props = {
		card_id = id,
	}

	local card_id = factory.create(M.CARD_FACTORY, position, nil, props, 1.0)

	if parent then
		msg.post(card_id, "set_parent", { parent_id = parent })
	end

	msg.post(card_id, "setup_card", data)

	return card_id
end

function M.create_many(ids, start_pos, spacing)
	spacing = spacing or 180
	local created = {}

	for i, id in ipairs(ids) do
		local pos = start_pos + vmath.vector3((i - 1) * spacing, 0, 0)
		local card = M.create(id, pos)
		if card then
			table.insert(created, card)
		end
	end

	return created
end

function M.destroy(card_url)
	go.delete(card_url)
end

return M