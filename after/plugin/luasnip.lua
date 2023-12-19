--require("luasnip.loaders.from_vscode").lazy_load()

require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})

print('LuaSnip loaded')
