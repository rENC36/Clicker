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

M.STARTER_CARDS = { "1_com" }
M.CARD_BUY_PRICE = 50 

M.MAX_FIELD_CARDS = 10

M.CARD_BASE_Z = 0
M.CARD_Z_STEP = 0.1

M.REWARD_POPUP_LOCAL_Z = 0.04
M.REWARD_POPUP_RISE = 80
M.REWARD_POPUP_DURATION = 0.5

M.DRAG_Z = 0.9

M.SAVE_NAME = "player_save"

M.FLASH_COLOR = vmath.vector4(1, 0.25, 0.25, 1)
M.FLASH_DURATION = 0.25

M.WARNING_COLOR = vmath.vector4(1, 0.05, 0.05, 1)
M.WARNING_MAX_ALPHA = 0.28
M.WARNING_FADE_IN = 0.12
M.WARNING_FADE_OUT = 0.35
M.HINT_TEXT = "Поле заполнено"
M.HINT_VISIBLE_TIME = 1.2
M.HINT_FADE_IN = 0.15
M.HINT_FADE_OUT = 0.25

M.DEFAULT_PLAYER = {
	money = 0,
	field_cards = {
		{ id = "1_com", x = 1250, y = 500, z = 0 },
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