-- return {
--     'shaunsingh/nord.nvim',
--     lazy = false,
--     priority = 1000,
--     config = function()
--         vim.g.nord_contrast = true
--         vim.g.nord_borders = false
--         vim.g.nord_disable_background = false
--         vim.g.nord_italic = false
--         vim.g.nord_uniform_diff_background = true
--         vim.g.nord_bold = false
--
--         require('nord').set()
--     end
-- }

-- kanagawa theme
-- https://github.com/rebelot/kanagawa.nvim?tab=readme-ov-file
return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    -- Default options:
    require('kanagawa').setup {
      compile = false, -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = true, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = { -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors) -- add/modify highlights
        return {}
      end,
      theme = 'dragon', -- wave / dragon / lotus
      background = { -- map the value of 'background' option to a theme
        dark = 'dragon', -- try "dragon" !
        light = 'lotus',
      },
    }

    -- setup must be called before loading
    vim.cmd 'colorscheme kanagawa'
  end,
}

-- return {
--   'andreasvc/vim-256noir',
-- }
