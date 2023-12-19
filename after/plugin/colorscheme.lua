require('kanagawa').setup({
    colors = {
        theme = {
            all = {
                ui = {
                    bg_gutter = "none"
                }
            }
        }
    }
})

require("kanagawa").load("wave")

require('lualine').setup {
  options = {
    theme = 'kanagawa',
  }
}
-- vim.cmd('colorscheme habamax')
