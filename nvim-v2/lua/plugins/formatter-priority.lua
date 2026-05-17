-- Configure formatter priority and auto-detection
return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      
      -- Ensure Biome has higher priority than Prettier for supported file types
      local biome_supported = {
        "javascript", "javascriptreact", "typescript", "typescriptreact", 
        "json", "jsonc", "css", "astro", "svelte", "vue"
      }
      
      for _, ft in ipairs(biome_supported) do
        if opts.formatters_by_ft[ft] then
          -- Remove prettier and biome, then add them in priority order
          opts.formatters_by_ft[ft] = vim.tbl_filter(function(formatter)
            return formatter ~= "prettier" and formatter ~= "biome"
          end, opts.formatters_by_ft[ft])
          
          -- Add biome first (higher priority), then prettier
          table.insert(opts.formatters_by_ft[ft], 1, "biome")
          table.insert(opts.formatters_by_ft[ft], "prettier")
        end
      end
      
      -- Configure formatters
      opts.formatters = opts.formatters or {}
      
      -- Biome: only run when biome.json exists
      opts.formatters.biome = {
        require_cwd = true,
        condition = function(self, ctx)
          return vim.fs.find({ "biome.json", "biome.jsonc" }, {
            path = ctx.filename,
            upward = true,
          })[1] ~= nil
        end,
      }
      
      -- Prettier: don't run when biome.json exists
      if opts.formatters.prettier then
        local original_condition = opts.formatters.prettier.condition
        opts.formatters.prettier.condition = function(self, ctx)
          -- Check if biome.json exists
          local has_biome = vim.fs.find({ "biome.json", "biome.jsonc" }, {
            path = ctx.filename,
            upward = true,
          })[1] ~= nil
          
          -- If biome exists, don't use prettier
          if has_biome then
            return false
          end
          
          -- Otherwise, use original condition if it exists
          if original_condition then
            return original_condition(self, ctx)
          end
          
          return true
        end
      end
      
      return opts
    end,
  },
}