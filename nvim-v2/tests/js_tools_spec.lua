local config_root = vim.fs.dirname(vim.fs.dirname(debug.getinfo(1, "S").source:sub(2)))
vim.opt.runtimepath:prepend(config_root)

local tools = require("config.js_tools")
local test_root = vim.fn.tempname()

local function write(path, lines)
  vim.fn.mkdir(vim.fs.dirname(path), "p")
  vim.fn.writefile(lines, path)
end

local function assert_equal(expected, actual, message)
  if not vim.deep_equal(expected, actual) then
    error((message or "values differ") .. ": expected " .. vim.inspect(expected) .. ", got " .. vim.inspect(actual))
  end
end

local function project(name, package_json)
  local root = vim.fs.joinpath(test_root, name)
  vim.fn.mkdir(vim.fs.joinpath(root, ".git"), "p")
  write(vim.fs.joinpath(root, "package.json"), { vim.json.encode(package_json) })
  return root
end

local ok, err = xpcall(function()
  local biome = project("biome", {
    devDependencies = {
      ["@biomejs/biome"] = "1.0.0",
      eslint = "9.0.0",
      prettier = "3.0.0",
    },
  })
  write(vim.fs.joinpath(biome, "biome.json"), { "{}" })
  write(vim.fs.joinpath(biome, "eslint.config.js"), { "export default []" })
  assert_equal({ "biome" }, tools.linters(vim.fs.joinpath(biome, "src/index.ts")), "Biome must own linting")
  assert_equal("biome", tools.formatter(vim.fs.joinpath(biome, "src/index.ts")))

  local oxc = project("oxc-eslint", {
    devDependencies = {
      eslint = "9.0.0",
      ["eslint-plugin-oxlint"] = "1.0.0",
      oxfmt = "1.0.0",
      oxlint = "1.0.0",
      prettier = "3.0.0",
    },
  })
  write(vim.fs.joinpath(oxc, ".oxlintrc.json"), { "{}" })
  write(vim.fs.joinpath(oxc, ".oxfmtrc.json"), { "{}" })
  write(vim.fs.joinpath(oxc, "apps/web/eslint.config.js"), { "export default []" })
  assert_equal(
    { "oxlint" },
    tools.linters(vim.fs.joinpath(oxc, "apps/web/index.ts")),
    "An installed compatibility package must not enable a second linter"
  )
  vim.g.js_tools_eslint_with_oxlint = true
  assert_equal(
    { "oxlint", "eslint" },
    tools.linters(vim.fs.joinpath(oxc, "apps/web/index.ts")),
    "Explicit opt-in must allow complementary linters"
  )
  vim.g.js_tools_eslint_with_oxlint = nil
  assert_equal("oxfmt", tools.formatter(vim.fs.joinpath(oxc, "apps/web/index.ts")))

  local unsafe_dual = project("unsafe-dual", {
    devDependencies = { eslint = "9.0.0", oxlint = "1.0.0" },
  })
  write(vim.fs.joinpath(unsafe_dual, ".oxlintrc.json"), { "{}" })
  write(vim.fs.joinpath(unsafe_dual, "eslint.config.js"), { "export default []" })
  assert_equal(
    { "oxlint" },
    tools.linters(vim.fs.joinpath(unsafe_dual, "index.ts")),
    "Unsafe dual-linter projects must not duplicate diagnostics"
  )

  local legacy = project("eslint-prettier", {
    devDependencies = { eslint = "9.0.0", prettier = "3.0.0" },
  })
  write(vim.fs.joinpath(legacy, "eslint.config.js"), { "export default []" })
  assert_equal({ "eslint" }, tools.linters(vim.fs.joinpath(legacy, "index.ts")))
  assert_equal("prettier", tools.formatter(vim.fs.joinpath(legacy, "index.ts")))

  assert_equal("prettier", tools.formatter(vim.fs.joinpath(biome, "README.md"), "markdown"))
  assert_equal("prettier", tools.formatter(vim.fs.joinpath(biome, "config.yaml"), "yaml"))
  assert_equal("prettier", tools.formatter(vim.fs.joinpath(biome, "styles.scss"), "scss"))
  assert_equal("oxfmt", tools.formatter(vim.fs.joinpath(oxc, "README.md"), "markdown"))
  assert_equal(nil, tools.formatter(vim.fs.joinpath(biome, "main.lua"), "lua"))

  local biome_only = project("biome-only", { devDependencies = { ["@biomejs/biome"] = "1.0.0" } })
  assert_equal(nil, tools.formatter(vim.fs.joinpath(biome_only, "README.md"), "markdown"))
  assert_equal("biome", tools.formatter(vim.fs.joinpath(biome_only, "data.json"), "json"))
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, vim.fs.joinpath(biome, "page.mdx"))
  vim.bo[buf].filetype = "markdown.mdx"
  assert_equal("prettier", tools.formatter(buf))
  vim.api.nvim_buf_delete(buf, { force = true })

  -- A sibling repository must not inherit the parent's tool configuration.
  local nested = vim.fs.joinpath(biome, "nested-repo")
  vim.fn.mkdir(vim.fs.joinpath(nested, ".git"), "p")
  assert_equal(nil, tools.formatter(vim.fs.joinpath(nested, "index.ts")))

  -- Editing configuration becomes visible after cache invalidation.
  write(vim.fs.joinpath(biome_only, ".prettierrc"), { "{}" })
  tools.clear_cache()
  assert_equal("prettier", tools.formatter(vim.fs.joinpath(biome_only, "README.md"), "markdown"))

  local plain = project("plain", { devDependencies = { eslint = "9.0.0" } })
  assert_equal({}, tools.linters(vim.fs.joinpath(plain, "index.ts")))
  assert_equal(nil, tools.formatter(vim.fs.joinpath(plain, "index.ts")))
end, debug.traceback)

vim.fn.delete(test_root, "rf")
if not ok then
  error(err)
end

print("js_tools: all project-selection checks passed")
