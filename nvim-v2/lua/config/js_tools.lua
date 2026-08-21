local M = {}

M.markers = {
  biome = { "biome.json", "biome.jsonc" },
  eslint = {
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    "eslint.config.mts",
    "eslint.config.cts",
  },
  oxlint = { ".oxlintrc.json", ".oxlintrc.jsonc", "oxlint.config.ts" },
  oxfmt = { ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" },
}

local cache = {}

---@param target? number|string
---@return string
local function start_dir(target)
  local path
  if type(target) == "number" then
    path = vim.api.nvim_buf_get_name(target == 0 and vim.api.nvim_get_current_buf() or target)
  elseif type(target) == "string" then
    path = target
  else
    path = vim.api.nvim_buf_get_name(0)
  end

  if path == "" then
    return vim.uv.cwd()
  end

  local stat = vim.uv.fs_stat(path)
  return stat and stat.type == "directory" and path or vim.fs.dirname(path)
end

---@param dir string
---@return string?
local function search_stop(dir)
  local git_root = vim.fs.root(dir, ".git")
  return git_root and vim.fs.dirname(git_root) or nil
end

---@param path string
---@return table?
local function read_json(path)
  local file = io.open(path, "r")
  if not file then
    return nil
  end

  local contents = file:read("*a")
  file:close()
  local ok, decoded = pcall(vim.json.decode, contents)
  return ok and type(decoded) == "table" and decoded or nil
end

---@param data table
---@return boolean
local function package_uses_biome(data)
  if data.biome ~= nil then
    return true
  end

  for _, dependency_group in ipairs({ "dependencies", "devDependencies", "optionalDependencies", "peerDependencies" }) do
    local dependencies = data[dependency_group]
    if type(dependencies) == "table" and dependencies["@biomejs/biome"] then
      return true
    end
  end

  return false
end

---@param tool string
---@param dir string
---@return string?
local function find_package_config(tool, dir)
  if tool ~= "biome" and tool ~= "eslint" then
    return nil
  end

  local packages = vim.fs.find("package.json", {
    path = dir,
    upward = true,
    type = "file",
    limit = math.huge,
    stop = search_stop(dir),
  })

  for _, package in ipairs(packages) do
    local data = read_json(package)
    if data and ((tool == "biome" and package_uses_biome(data)) or (tool == "eslint" and data.eslintConfig ~= nil)) then
      return package
    end
  end
end

---@param tool "biome"|"eslint"|"oxlint"|"oxfmt"
---@param target? number|string
---@return string?
function M.config(tool, target)
  local dir = start_dir(target)
  local key = tool .. "\0" .. dir
  if cache[key] ~= nil then
    return cache[key] or nil
  end

  local config = vim.fs.find(M.markers[tool], {
    path = dir,
    upward = true,
    type = "file",
    limit = 1,
    stop = search_stop(dir),
  })[1] or find_package_config(tool, dir)

  cache[key] = config or false
  return config
end

---@param target? number|string
---@return "biome"|"oxlint"|"eslint"|nil, string?
function M.linter(target)
  for _, tool in ipairs({ "biome", "oxlint", "eslint" }) do
    local config = M.config(tool, target)
    if config then
      return tool, vim.fs.dirname(config)
    end
  end
end

---@param target? number|string
---@return "biome"|"oxfmt"|"prettier", string?
function M.formatter(target)
  for _, tool in ipairs({ "biome", "oxfmt" }) do
    local config = M.config(tool, target)
    if config then
      return tool, vim.fs.dirname(config)
    end
  end
  return "prettier"
end

function M.clear_cache()
  cache = {}
end

return M
