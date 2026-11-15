# Neovim configuration

This is the active LazyVim configuration (`~/.config/nvim` points here).
The sibling `nvim/` directory is the legacy configuration, retained for reference.

## Where to change things

- `lazyvim.json`: enabled extras; manage with `:LazyExtras`.
- `lua/config/lazy.lua`: plugin-manager bootstrap and imports.
- `lua/config/options.lua`: editor preferences and language-server choices.
- `lua/config/keymaps.lua`: general mappings; plugin mappings live in their plugin specs.
- `lua/config/js_tools.lua`: cached project tool detection and formatter/linter selection.
- `lua/config/autocmds.lua`: invalidates tool detection when configuration changes.
- `lua/plugins/`: small overrides, grouped by plugin; `web.lua` connects tool selection to LSP and Conform.
- `lua/plugins/mason.lua`: additional tools only; extras install their own servers and tools.

## Formatting and diagnostics

Conform owns web formatting. For each buffer, use the first configured tool supporting its filetype:
Biome → Oxfmt → Prettier. Biome is restricted to JS/TS, JSON, CSS, and GraphQL;
framework files use Oxfmt or Prettier. Prettier framework parsers may require project plugins.
Markdown keeps LazyVim's conditional lint fixes and TOC updates after the selected formatter.
No configured formatter means no primary web formatter is selected.

Linting prefers Biome, then Oxlint, then ESLint. TypeScript diagnostics are preserved.
To run ESLint alongside Oxlint, first enable compatible rules in the project's ESLint config,
then explicitly set `vim.g.js_tools_eslint_with_oxlint = true` for that Neovim session.
Installing `eslint-plugin-oxlint` alone does not enable dual linting.
ESLint fixes remain manual.

## Loading and shortcuts

- Smart-splits starts immediately so WezTerm can read its `IS_NVIM` signal.
- `<C-h/j/k/l>` moves between splits; `<A-h/j/k/l>` resizes them; `<C-\>` returns to the previous split.
- `<leader>ww` loads the window picker.
- `<leader>cP` loads package-info and checks package versions on demand in `package.json`.
- Markdown uses LazyVim's render-markdown plugin; `<leader>cp` opens the separate browser preview.

The Flash compatibility shim is retained for source-built Neovim 0.13; `init.lua` also
repairs missing runtime paths only for source-build executables. Packaged Neovim skips that repair.

## Validation

```sh
nvim --headless -u NONE -l nvim-v2/tests/js_tools_spec.lua
nvim --headless -u nvim-v2/init.lua -l nvim-v2/tests/config_spec.lua
```

Run from the dotfiles root. The second check uses the installed, locked plugins and active configuration.
Use `:Lazy profile` for interactive startup timing. Keep plugin versions fixed when comparing changes.
