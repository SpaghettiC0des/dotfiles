local js_filetypes = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
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
    local selected, root = require("config.js_tools").linter(bufnr)
    if selected == server and root then
      on_dir(root)
    end
  end
end

local function oxfmt_root(bufnr, on_dir)
  local selected, root = require("config.js_tools").formatter(bufnr)
  if selected == "oxfmt" and root then
    on_dir(root)
  end
end

local function tsgo_diagnostics(err, result, ctx, config)
  if result and result.uri and require("config.js_tools").linter(vim.uri_to_bufnr(result.uri)) then
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

      -- Conform owns formatting for these servers. This also prevents tsgo from
      -- formatting alongside oxfmt when Conform falls back to LSP formatting.
      disable_lsp_formatting(opts.servers.biome)

      -- LazyVim's Oxc extra disables this because it normally uses the oxfmt CLI.
      opts.servers.oxfmt = opts.servers.oxfmt or {}
      opts.servers.oxfmt.enabled = true
      opts.servers.oxfmt.root_dir = oxfmt_root

      opts.servers.tsgo = opts.servers.tsgo or {}
      opts.servers.tsgo.handlers = opts.servers.tsgo.handlers or {}
      opts.servers.tsgo.handlers["textDocument/publishDiagnostics"] = tsgo_diagnostics
      disable_lsp_formatting(opts.servers.tsgo)

      opts.servers.graphql = opts.servers.graphql or {}
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters = opts.formatters or {}

      -- oxfmt stays in memory as an LSP. Remove the CLI added by LazyVim's Oxc extra.
      for ft, formatters in pairs(opts.formatters_by_ft) do
        if type(formatters) == "table" then
          opts.formatters_by_ft[ft] = vim.tbl_filter(function(formatter)
            return formatter ~= "oxfmt"
          end, formatters)
        end
      end

      for _, ft in ipairs(js_filetypes) do
        opts.formatters_by_ft[ft] = function(bufnr)
          local formatter = require("config.js_tools").formatter(bufnr)
          if formatter == "biome" then
            return { "biome" }
          end
          if formatter == "oxfmt" then
            return {}
          end
          return { "prettier" }
        end
      end

      opts.formatters_by_ft.sh = { "shfmt" }
      opts.formatters_by_ft.sql = { "sqlfluff", "pg_format" }
      opts.formatters_by_ft.graphql = { "prettier" }

      opts.formatters.prettier = opts.formatters.prettier or {}
      opts.formatters.prettier.command = require("conform.util").from_node_modules("prettier")
    end,
  },
}
