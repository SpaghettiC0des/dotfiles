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
  oxlint = { ".oxlintrc.json", ".oxlintrc.jsonc", "oxlint.config.ts", "oxlint.config.mts" },
  oxfmt = { ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts", "oxfmt.config.mts" },
  prettier = {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.json5",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.mjs",
    ".prettierrc.toml",
    ".prettierrc.yaml",
    ".prettierrc.yml",
    "prettier.config.js",
    "prettier.config.cjs",
    "prettier.config.mjs",
    "prettier.config.ts",
    "prettier.config.mts",
    "prettier.config.cts",
  },
}

local package_dependencies = {
  biome = "@biomejs/biome",
  eslint = "eslint",
  oxlint = "oxlint",
  oxfmt = "oxfmt",
  prettier = "prettier",
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
---@param dependency string
---@return boolean
local function has_dependency(data, dependency)
  for _, group in ipairs({ "dependencies", "devDependencies", "optionalDependencies", "peerDependencies" }) do
    if type(data[group]) == "table" and data[group][dependency] then
      return true
    end
  end
  return false
end

---@param data table
---@param tool string
---@return boolean
local function package_uses_tool(data, tool)
  if tool == "biome" and data.biome ~= nil then
    return true
  end
  if tool == "eslint" and data.eslintConfig ~= nil then
    return true
  end
  if tool == "eslint" then
    return false
  end
  if tool == "prettier" and data.prettier ~= nil then
    return true
  end
  return has_dependency(data, package_dependencies[tool])
end

---@param dir string
---@return string[]
local function package_files(dir)
  return vim.fs.find("package.json", {
    path = dir,
    upward = true,
    type = "file",
    limit = math.huge,
    stop = search_stop(dir),
  })
end

---@param tool string
---@param dir string
---@return string?
local function find_package_config(tool, dir)
  for _, package in ipairs(package_files(dir)) do
    local data = read_json(package)
    if data and package_uses_tool(data, tool) then
      return package
    end
  end
end

---@param dependency string
---@param target? number|string
---@return boolean
function M.has_package_dependency(dependency, target)
  local dir = start_dir(target)
  local key = "dependency\0" .. dependency .. "\0" .. dir
  if cache[key] ~= nil then
    return cache[key]
  end

  for _, package in ipairs(package_files(dir)) do
    local data = read_json(package)
    if data and has_dependency(data, dependency) then
      cache[key] = true
      return true
    end
  end

  cache[key] = false
  return false
end

---@param tool "biome"|"eslint"|"oxlint"|"oxfmt"|"prettier"
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

---@param tool "biome"|"oxlint"|"eslint"
---@param target? number|string
---@return string?
function M.linter_root(tool, target)
  local biome = M.config("biome", target)
  if biome then
    return tool == "biome" and vim.fs.dirname(biome) or nil
  end

  local oxlint = M.config("oxlint", target)
  if tool == "oxlint" then
    return oxlint and vim.fs.dirname(oxlint) or nil
  end

  if tool == "eslint" then
    local eslint = M.config("eslint", target)
    if not eslint then
      return nil
    end

    -- Running both servers is safe only when the project explicitly installs
    -- the compatibility preset that disables ESLint rules owned by Oxlint.
    if oxlint and not M.has_package_dependency("eslint-plugin-oxlint", target) then
      return nil
    end
    return vim.fs.dirname(eslint)
  end
end

---@param target? number|string
---@return string[]
function M.linters(target)
  local selected = {}
  for _, tool in ipairs({ "biome", "oxlint", "eslint" }) do
    if M.linter_root(tool, target) then
      selected[#selected + 1] = tool
    end
  end
  return selected
end

---@param target? number|string
---@return boolean
function M.has_linter(target)
  return #M.linters(target) > 0
end

---@param target? number|string
---@return "biome"|"oxfmt"|"prettier"|nil, string?
function M.formatter(target)
  for _, tool in ipairs({ "biome", "oxfmt", "prettier" }) do
    local config = M.config(tool, target)
    if config then
      return tool, vim.fs.dirname(config)
    end
  end
end

function M.clear_cache()
  cache = {}
end

return M
