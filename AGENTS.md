# Repository Guidelines

## Project Structure & Module Organization

This repository stores personal dotfiles and app configuration. Top-level shell and package files include `.zshrc`, `.zimrc`, `.gitconfig`, `Brewfile`, and `Brewfile.lock.json`. Application-specific directories are grouped by tool: `nvim/` and `nvim-v2/` contain LazyVim-based Neovim configs, `wezterm/` contains terminal configuration and session manager code, `aerospace/` contains window manager settings, and `lazygit/` contains Git UI configuration. Lua plugin specs live under `nvim*/lua/plugins/`; core Neovim setup lives under `nvim*/lua/config/`.

## Build, Test, and Development Commands

There is no central build system. Use targeted validation commands before committing:

- `brew bundle check`: verifies installed Homebrew dependencies match `Brewfile`.
- `brew bundle dump --force`: refreshes `Brewfile` after intentional package changes.
- `stylua nvim nvim-v2 wezterm`: formats Lua files using the repository StyLua settings.
- `nvim --headless "+Lazy! sync" +qa`: checks LazyVim plugin resolution for the active Neovim config.
- `wezterm cli list`: quick sanity check that WezTerm CLI integration is available.

## Coding Style & Naming Conventions

Use two-space indentation for Lua, matching `nvim-v2/stylua.toml`; keep lines at or below 120 columns when practical. Prefer small, focused Lua modules and plugin files named after the feature or plugin they configure, such as `lua/plugins/snacks.lua` or `lua/plugins/lsp/tsgo.lua`. Keep TOML and YAML keys grouped by feature, and avoid unrelated formatting churn in generated lock files.

## Testing Guidelines

This repository has no formal test suite. Validate changes by loading the target tool locally. For Neovim changes, run headless Lazy sync and open Neovim to confirm startup, keymaps, and plugin behavior. For shell changes, start a fresh `zsh` session and verify aliases, exports, and completion still load. For Homebrew changes, run `brew bundle check`.

## Commit & Pull Request Guidelines

Git history uses Conventional Commits with a scope, for example `feat(nvim-v2): add smart-splits keymaps`, `fix(nvim-v2): update mason.nvim repository`, and `perf(nvim): optimize snacks`. Follow `type(scope): summary`, using concise imperative summaries. Pull requests should describe the affected tool, list validation performed, and call out any required local setup, symlinks, or generated lockfile updates.

## Security & Configuration Tips

Do not commit machine-specific secrets, tokens, private paths, or local API keys. Review `.zshrc`, `.gitconfig`, and app configs for personal data before sharing changes.
