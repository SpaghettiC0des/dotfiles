return {
  {
    "folke/flash.nvim",
    optional = true,
    config = function(_, opts)
      local ffi = require("ffi")
      ffi.cdef("extern unsigned int search_match_lines;")
      local has_legacy_search_state = pcall(function()
        return tonumber(ffi.C.search_match_lines)
      end)

      if not has_legacy_search_state then
        -- Neovim 0.13 grouped these private globals into `Search`.
        -- Remove this shim once flash.nvim supports Neovim's SearchState.
        ffi.cdef([[
          typedef struct {
            bool hl_match;
            int32_t match_lines;
            int match_endcol;
            int32_t first_line;
            int32_t last_line;
            bool no_smartcase;
            int cmdlen;
            bool no_hlsearch;
          } FlashSearchState;
          extern FlashSearchState Search;
        ]])

        local Hacks = require("flash.hacks")
        local Pos = require("flash.search.pos")
        local incsearch_state = {}

        function Hacks.get_end_pos(from)
          local ret = Pos({
            from[1] + ffi.C.Search.match_lines,
            math.max(0, ffi.C.Search.match_endcol - 1),
          })
          local line = vim.api.nvim_buf_get_lines(0, ret[1] - 1, ret[1], false)[1]
          local char_idx = vim.fn.charidx(line, ret[2])
          ret[2] = vim.fn.byteidx(line, char_idx)
          return ret
        end

        function Hacks.save_incsearch_state()
          incsearch_state = {
            match_endcol = ffi.C.Search.match_endcol,
            match_lines = ffi.C.Search.match_lines,
          }
        end

        function Hacks.restore_incsearch_state()
          ffi.C.Search.match_endcol = incsearch_state.match_endcol
          ffi.C.Search.match_lines = incsearch_state.match_lines
        end
      end

      require("flash").setup(opts)
    end,
  },
}
