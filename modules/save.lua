-- save.lua

local M = {}

M.APP_NAME = "my_game"

local cache = {}

local function get_path(name)
	return sys.get_save_file(M.APP_NAME, name)
end

-- @param name string  Имя файла (без расширения)
-- @param data table   Данные для сохранения
-- @return boolean     true если успешно
function M.save(name, data)
	assert(type(name) == "string", "name must be a string")
	assert(type(data) == "table", "data must be a table")

	local path = get_path(name)
	local success = sys.save(path, data)

	if success then
		cache[name] = data   -- обновляем кэш
	else
		print("Save error:", name)
	end

	return success
end

-- @param name string
-- @param default table|nil  Что вернуть, если файла нет (по умолчанию {})
-- @return table
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

-- @param name string
-- @return boolean  true если файл удалён (или его не было)
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