-- modules/constants.lua

local M = {}

M.APP_NAME = "Clicker"
M.CARD_FACTORY = "/factories#card_factory"
M.CARD_SPACING = 180
M.MAIN_SCRIPT = "/main#main"
M.INTERACTION = "/main#interaction"

M.half_w = 145
M.half_h = 215
M.merge_radius = 100 

M.STARTER_CARDS = { "Zero Two" }
M.CARD_BUY_PRICE = 50 

M.MAX_FIELD_CARDS = 10

M.CARD_IMAGE_LOCAL_Z = 0.02

M.REWARD_POPUP_LOCAL_Z = 0.03
M.REWARD_POPUP_RISE = 80
M.REWARD_POPUP_DURATION = 0.5

M.DRAG_Z = 0.5

M.SAVE_NAME = "player_save"

M.DEFAULT_PLAYER = {
	money = 0,
	field_cards = {
		{ id = "Zero Two", x = 1250, y = 500, z = 0 },
	},
	shop_rarity = "common",
	shop_price = 50,
	unlocked_cards = {},
	unlocked_rainbow = {},
	rebirth = 0,
	rebirth_bonus = 1,
	settings = {
		sound = true,
		music = true,
		language = "ru"
	},
	ad_multiplier = 1,
	ad_timer = 0,
}

return M