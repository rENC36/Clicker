-- save.lua

local constants = require("utility.constants")

local M = {}

local cache = {}

local function get_path(name)
	return sys.get_save_file(constants.APP_NAME, name)
end

function M.save(name, data)
	assert(type(name) == "string", "name must be a string")
	assert(type(data) == "table", "data must be a table")

	local path = get_path(name)
	local success = sys.save(path, data)

	if success then
		cache[name] = data
	else
		print("Save error:", name)
	end

	return success
end

function M.load(name, default)
	assert(type(name) == "string", "name must be a string")

	if cache[name] then
		return cache[name]
	end

	local path = get_path(name)
	local ok, data = pcall(sys.load, path)

	if not ok then
		print("Load error (corrupted?):", name, data)
		data = default or {}
	elseif not next(data) then
		data = default or {}
	end

	cache[name] = data
	return data
end

function M.delete(name)
	assert(type(name) == "string", "name must be a string")

	local path = get_path(name)
	cache[name] = nil

	local success, err = os.remove(path)
	if not success and err then
		return true
	end
	return success
end

function M.exists(name)
	local path = get_path(name)
	local f = io.open(path, "r")
	if f then
		f:close()
		return true
	end
	return false
end

function M.clear_cache()
	cache = {}
end

function M.get_path(name)
	return get_path(name)
end

return M