local constants = require("utility.constants")
local save = require("utility.save")

local M = {}

M.data = nil

function M.load()
	local loaded = save.load(
	constants.SAVE_NAME,
	constants.DEFAULT_PLAYER
)

for key, value in pairs(constants.DEFAULT_PLAYER) do
	if loaded[key] == nil then
		loaded[key] = value
	end
end

if type(loaded.field_cards) ~= "table" then
	loaded.field_cards = {}
end

if type(loaded.unlocked_cards) ~= "table" then
	loaded.unlocked_cards = {}
end

if type(loaded.unlocked_rainbow) ~= "table" then
	loaded.unlocked_rainbow = {}
end

if type(loaded.settings) ~= "table" then
	loaded.settings = {}
end

for key, value in pairs(constants.DEFAULT_PLAYER.settings) do
	if loaded.settings[key] == nil then
		loaded.settings[key] = value
	end
end

M.data = loaded
end

function M.save()
	if not M.data then return end
	save.save(constants.SAVE_NAME, M.data)
end

function M.get_money()
	return M.data.money
end

function M.set_money(value)
	M.data.money = value
	M.save()
end

function M.add_money(amount)
	M.data.money = M.data.money + amount
	M.save()
end

function M.get_shop_price()
	return M.data.shop_price
end

function M.set_shop_price(price)
	M.data.shop_price = price
	M.save()
end

function M.get_shop_rarity()
	return M.data.shop_rarity
end

function M.set_shop_rarity(rarity)
	M.data.shop_rarity = rarity
	M.save()
end

function M.get_rebirth()
	return M.data.rebirth
end

function M.add_rebirth(count)
	count = count or 1
	M.data.rebirth = M.data.rebirth + count
	M.save()
end

function M.get_rebirth_bonus()
	return M.data.rebirth_bonus
end

function M.set_rebirth_bonus(value)
	M.data.rebirth_bonus = value
	M.save()
end

function M.unlock_card(id)
	M.data.unlocked_cards[id] = true
	M.save()
end

function M.is_card_unlocked(id)
	return M.data.unlocked_cards[id] == true
end

function M.unlock_rainbow(id)
	M.data.unlocked_rainbow[id] = true
	M.save()
end

function M.is_rainbow_unlocked(id)
	return M.data.unlocked_rainbow[id] == true
end

function M.get_setting(key)
	return M.data.settings[key]
end

function M.set_setting(key, value)
	M.data.settings[key] = value
	M.save()
end

function M.get_ad_multiplier()
	return M.data.ad_multiplier
end

function M.set_ad_bonus(multiplier, duration)
	M.data.ad_multiplier = multiplier
	M.data.ad_timer = duration
	M.save()
end

function M.clear_ad_bonus()
	M.data.ad_multiplier = 1
	M.data.ad_timer = 0
	M.save()
end

function M.set_field_cards(list)
	M.data.field_cards = list
	M.save()
end

function M.get_field_cards()
	return M.data.field_cards or {}
end

return M