local web_filetypes = {
  "astro",
  "css",
  "graphql",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "less",
  "markdown",
  "markdown.mdx",
  "mdx",
  "scss",
  "svelte",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
}

local duplicate_ts_diagnostics = {
  [6133] = true, -- declared but never read
  [6138] = true, -- property declared but never read
  [6192] = true, -- all imports are unused
  [6196] = true, -- declared but never used
  [6198] = true, -- all destructured elements are unused
}

---@param server "biome"|"oxlint"|"eslint"
---@return fun(bufnr: number, on_dir: fun(root_dir: string))
local function linter_root(server)
  return function(bufnr, on_dir)
    local root = require("config.js_tools").linter_root(server, bufnr)
    if root then
      on_dir(root)
    end
  end
end

local function typescript_diagnostics(err, result, ctx, config)
  if result and result.uri and require("config.js_tools").has_linter(vim.uri_to_bufnr(result.uri)) then
    result = vim.deepcopy(result)
    result.diagnostics = vim.tbl_filter(function(diagnostic)
      local code = type(diagnostic.code) == "table" and diagnostic.code.value or diagnostic.code
      return not duplicate_ts_diagnostics[tonumber(code)]
    end, result.diagnostics or {})
  end

  return vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
end

---@param server table
local function disable_lsp_formatting(server)
  local on_attach = server.on_attach
  server.on_attach = function(client, bufnr)
    if on_attach then
      on_attach(client, bufnr)
    end
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      for _, server in ipairs({ "biome", "oxlint", "eslint" }) do
        opts.servers[server] = opts.servers[server] or {}
        opts.servers[server].root_dir = linter_root(server)
      end

      opts.servers.eslint.settings = opts.servers.eslint.settings or {}
      opts.servers.eslint.settings.format = false
      disable_lsp_formatting(opts.servers.biome)

      -- Conform is the single formatting owner, including for Oxfmt.
      opts.servers.oxfmt = opts.servers.oxfmt or {}
      opts.servers.oxfmt.enabled = false

      for _, server in ipairs({ "vtsls" }) do
        opts.servers[server] = opts.servers[server] or {}
        opts.servers[server].handlers = opts.servers[server].handlers or {}
        opts.servers[server].handlers["textDocument/publishDiagnostics"] = typescript_diagnostics
        disable_lsp_formatting(opts.servers[server])
      end

      opts.servers.graphql = opts.servers.graphql or {}
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters = opts.formatters or {}

      for _, ft in ipairs(web_filetypes) do
        opts.formatters_by_ft[ft] = function(bufnr)
          local formatter = require("config.js_tools").formatter(bufnr)
          return formatter and { formatter } or {}
        end
      end

      opts.formatters_by_ft.sh = { "shfmt" }
      opts.formatters_by_ft.sql = { "sqlfluff", "pg_format", stop_after_first = true }

      local from_node_modules = require("conform.util").from_node_modules
      for _, formatter in ipairs({ "biome", "oxfmt", "prettier" }) do
        opts.formatters[formatter] = opts.formatters[formatter] or {}
        opts.formatters[formatter].command = from_node_modules(formatter == "biome" and "biome" or formatter)
      end
    end,
  },
}
