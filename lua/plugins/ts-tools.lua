return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {},
	enable = false,
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		require("typescript-tools").setup({
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",

				"vue",
			},
			settings = {
				publish_diagnostic_on = "change",
				complete_function_calls = true,
				capabilities = capabilities,
				expose_as_code_action = {
					"fix_all",
					"add_missing_imports",
					"remove_unused",
					"remove_unused_imports",
					"organize_imports",
				},
				tsserver_plugins = {
					"@vue/typescript-plugin",
				},
			},
		})
	end,
}
