return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- Animation library for smooth animations
    animate = {
      enabled = true,
      duration = 20, -- ms per step
      fps = 60,
    },
    scroll = { enabled = false },
    dashboard = {
      preset = {
        header = [[
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⢀⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⢀⣀⠀⠀⠀⠀⢠⣿⠿⠛⠉⠉⠛⠻⣿⣿⣿⣿⣿⣿
⠸⠿⠿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠉⠙⠻⣿⣿⣿⣿⠴⠖⠛⠛⠛⠛⠉⠉⠉⠉⠉⠉⠀⠘⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣠⠏⠀⠀⠀⠀⠀⠀⠀⢉⡩⠔⠻⣯⡄⠀⠐⢦⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠛⠀⠀⠀⢰⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⣶⣾⣶⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⣀⣀⣄⣀⣀⣀⣀⣀⠀⠈⠁⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣰⠋⠀⠀⢀⣠⡶⠂⢻⢉⠁⠀⢃⣼⠋⠁⠈⠙⠒⠦⢤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣰⠃⠀⠀⠀⠞⠉⠁⢀⡎⠸⡀⠀⠸⡇⠀⠀⠀⠀⠀⠀⠀⠉⢹⢶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣸⠃⠀⠀⠴⠂⠀⠀⠀⠘⢄⡀⠁⠀⠀⠁⠀⠀⠘⠀⠀⠀⠈⠁⠈⠩⠭⠿⣆⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢰⠃⠀⡴⠀⣀⣤⣤⣄⡀⠀⠀⠇⠀⠀⠀⢀⡞⠁⣠⣶⣿⣷⣶⣦⣄⡀⠀⠂⠈⠙⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⡏⠀⠐⠇⠀⢰⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⢏⣽⣿⣿⣿⡿⠆⠀⢀⡀⠀⠻⡄⠐⣆⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢠⠃⠀⠀⠀⠀⢾⣿⣿⣿⠟⠀⠀⠀⡀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⠟⠀⠀⠀⠀⠑⢶⡄⢻⡄⠘⣆⠀⠀⠀⠀⠀⠀⠀
⠀⡼⠀⠀⠀⠀⠀⠀⠀⠈⠀⣖⠓⢒⣦⣤⠄⠀⠀⠀⠀⠀⠀⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠉⠺⢿⡄⢸⡄⠀⠀⠀⠀⠀⠀
⢠⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣦⡾⠏⠁⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠤⠤⠀⠀⠀⠀⠀⠘⣧⠀⡇⠀⣰⠀⠀⠀⠀
⢸⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠑⠂⠀⠀⠒⠂⠤⣄⣀⡀⠀⠀⠀⠀⡿⢀⡇⢠⡟⠀⠀⠀⠀
⠀⢳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠃⢠⡀⠀⠀⠀⠀⠈⠒⠒⠤⣀⠐⠂⠀⠀⠀⠀⠀⠀⠠⠀⢀⣰⡇⢸⢠⣾⠁⠀⠀⠀⠀
⠀⢀⣷⡀⠀⠠⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠒⠀⠀⠀⠀⠀⢄⢨⠳⢄⠠⡀⠀⠀⠀⠀⠀⠠⣼⠟⢀⣺⣿⡟⠀⠀⠀⠀⠀
⠀⣸⢶⣷⣄⠀⠑⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢣⠳⡀⠑⢌⡓⢤⣰⣄⡀⠀⢋⣀⣴⣿⣿⠃⠀⠀⠀⠀⠀
⠘⢁⡾⣧⣿⣿⡦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠹⡄⠂⡙⢦⣽⠟⠃⣠⣾⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀
⠀⢸⣴⣿⣿⡟⠀⠀⠉⠒⠲⠦⠤⠤⢤⣀⡀⠀⠀⠀⠀⠀⠀⠠⠂⠈⠂⠃⠀⠀⣀⣠⣴⣿⣿⣿⣿⠈⠻⣿⣿⡀⠀⠀⠀⠀
⠀⠈⠁⣼⣿⠇⠀⠀⠀⠀⠀⠀⠀⠐⠦⠤⠬⠝⠲⠦⢤⣀⡤⠶⠲⠶⠶⠶⣿⣍⣿⠿⠿⠿⠗⠉⣀⣴⠈⠀⠸⣇⠀⠀⠀⠀
⠀⠀⢠⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠓⠛⠷⠶⢶⣶⠖⠙⠋⠁⠀⠀⠀⠀⠈⠀⠀⠀⠀
⠀⠀⠀⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ]],
      },
      sections = {
        { section = "header" },
        -- {
        --   -- pane = 2,
        --   section = "terminal",
        --   cmd = "if command -v chafa >/dev/null 2>&1; then chafa ~/.dotfiles/nvim/pusheen.png --format symbols --symbols vhalf --size 60x25 --stretch; else convert ~/.dotfiles/nvim/pusheen.png -resize 60x25 -monochrome txt:- | grep -v '^#' | awk '{if($3 ~ /white/) print \" \"; else print \"█\"}' | tr -d '\\n' | fold -w 60; fi; sleep .1",
        --   height = 25,
        --   -- padding = 2,
        -- },
        { section = "keys", gap = 1, padding = 1 },
        -- { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        -- { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        -- {
        --   pane = 2,
        --   icon = " ",
        --   title = "Git Status",
        --   section = "terminal",
        --   enabled = vim.fn.isdirectory(".git") == 1,
        --   cmd = "hub status --short --branch --renames",
        --   height = 5,
        --   padding = 1,
        --   ttl = 5 * 60,
        --   indent = 3,
        -- },
        -- { section = "startup" },
      },
    },
    picker = {
      enabled = true,
      ui_select = true,
    },
    explorer = {
      enabled = true,
      -- Auto-open when starting with directory
      auto_open = false,
      layout = "right",
      -- Add explorer layout animations
      animate = true,
    },
    -- Enable other snacks features
    bigfile = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    dim = { enabled = false },
    -- Indent guides (no animation)
    indent = {
      enabled = true,
      char = "▏",
      only_scope = false,
      only_current = false,
    },
    -- Image support (limited in WezTerm)
    image = {
      enabled = true,
      formats = {
        "png",
        "jpg",
        "jpeg",
        "gif",
        "bmp",
        "webp",
        "tiff",
        "heic",
        "avif",
        "mp4",
        "mov",
        "avi",
        "mkv",
        "webm",
        "pdf",
      },
      doc = {
        enabled = true,
        inline = true,
        float = true,
        max_width = 80,
        max_height = 40,
      },
      img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
    },
  },
  keys = {
    -- Top Pickers & Explorer
    {
      "<leader><space>",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader>,",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>n",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Notification History",
    },
    {
      "<leader>e",
      function()
        Snacks.explorer({
          layout = {
            layout = {
              position = "right",
            },
          },
        })
      end,
      desc = "File Explorer",
    },
    -- find
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>fc",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find Config File",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Find Git Files",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Projects",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Recent",
    },
    -- git
    {
      "<leader>gb",
      function()
        Snacks.picker.git_branches()
      end,
      desc = "Git Branches",
    },
    {
      "<leader>gl",
      function()
        Snacks.picker.git_log()
      end,
      desc = "Git Log",
    },
    {
      "<leader>gL",
      function()
        Snacks.picker.git_log_line()
      end,
      desc = "Git Log Line",
    },
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Git Status",
    },
    {
      "<leader>gS",
      function()
        Snacks.picker.git_stash()
      end,
      desc = "Git Stash",
    },
    {
      "<leader>gd",
      function()
        Snacks.picker.git_diff()
      end,
      desc = "Git Diff (Hunks)",
    },
    {
      "<leader>gf",
      function()
        Snacks.picker.git_log_file()
      end,
      desc = "Git Log File",
    },
    -- Grep
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>sB",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Grep Open Buffers",
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Visual selection or word",
      mode = { "n", "x" },
    },
    -- search
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = "Registers",
    },
    {
      "<leader>s/",
      function()
        Snacks.picker.search_history()
      end,
      desc = "Search History",
    },
    {
      "<leader>sa",
      function()
        Snacks.picker.autocmds()
      end,
      desc = "Autocmds",
    },
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>sc",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>sC",
      function()
        Snacks.picker.commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>sd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>sD",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "Buffer Diagnostics",
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help Pages",
    },
    {
      "<leader>sH",
      function()
        Snacks.picker.highlights()
      end,
      desc = "Highlights",
    },
    {
      "<leader>si",
      function()
        Snacks.picker.icons()
      end,
      desc = "Icons",
    },
    {
      "<leader>sj",
      function()
        Snacks.picker.jumps()
      end,
      desc = "Jumps",
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Keymaps",
    },
    {
      "<leader>sl",
      function()
        Snacks.picker.loclist()
      end,
      desc = "Location List",
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.marks()
      end,
      desc = "Marks",
    },
    {
      "<leader>sM",
      function()
        Snacks.picker.man()
      end,
      desc = "Man Pages",
    },
    {
      "<leader>sp",
      function()
        Snacks.picker.lazy()
      end,
      desc = "Search for Plugin Spec",
    },
    {
      "<leader>sq",
      function()
        Snacks.picker.qflist()
      end,
      desc = "Quickfix List",
    },
    {
      "<leader>sR",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume",
    },
    {
      "<leader>su",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undo History",
    },
    {
      "<leader>uC",
      function()
        Snacks.picker.colorschemes()
      end,
      desc = "Colorschemes",
    },
    -- LSP
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "Goto Definition",
    },
    {
      "gD",
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = "Goto Declaration",
    },
    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = "References",
    },
    {
      "gI",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Goto Implementation",
    },
    {
      "gy",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Goto T[y]pe Definition",
    },
    {
      "<leader>ss",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "LSP Symbols",
    },
    {
      "<leader>sS",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = "LSP Workspace Symbols",
    },
  },

  init = function()
    -- Set up vim.ui.select replacement
    vim.ui.select = function(...)
      Snacks.picker.ui_select(...)
    end
  end,
}
