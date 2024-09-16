return {
	{
		"neovim/nvim-lspconfig",
	},
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			local lspconfig = require("lspconfig")

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"intelephense",
					"phpactor",
					"volar",
					"emmet_ls",
					"eslint",
					"tailwindcss",
				},
				handlers = {
					function(server_name) -- default handler (optional) initializes servers
						local server_config = {}
						lspconfig[server_name].setup(server_config)
					end,
					["tailwindcss"] = function()
						lspconfig.tailwindcss.setup({
							filetypes = {
								"html",
								"css",
								"scss",
								"javascript",
								"javascriptreact",
								"typescript",
								"typescriptreact",
								"svelte",
								"vue",
								"gotmpl",
							},
						})
					end,
					["volar"] = function()
						lspconfig.volar.setup({
							hybrid = false,
							on_attach = function(client)
								client.server_capabilities.documentFormattingProvider = false
								client.server_capabilities.documentRangeFormattingProvider = false
							end,
						})
					end,
					["emmet_ls"] = function()
						lspconfig.emmet_ls.setup({
							filetypes = {
								"css",
								"html",
								"javascript",
								"less",
								"sass",
								"scss",
								"typescriptreact",
								"vue",
								"gotmpl",
							},
						})
					end,
					["eslint"] = function()
						lspconfig.eslint.setup({
							on_attach = function(client)
								client.server_capabilities.documentFormattingProvider = true
								client.server_capabilities.documentRangeFormattingProvider = true
							end,
							filetypes = {
								"typescript",
								"javascript",
								"javascriptreact",
								"typescriptreact",
								"vue",
							},
						})
					end,
					["psalm"] = function()
						lspconfig.psalm.setup({
							cmd = {
								"docker-compose",
								"exec",
								"nwapp",
								"vendor/bin/psalm",
								"--language-server",
							},
							on_attach = function(client)
								client.server_capabilities.hoverProvider = false
								client.server_capabilities.implementationProvider = false
								client.server_capabilities.referencesProvider = false
								client.server_capabilities.definitionProvider = false
							end,
						})
					end,
					["phpactor"] = function()
						lspconfig.phpactor.setup({
							on_attach = function(client)
								client.server_capabilities.hoverProvider = true
								client.server_capabilities.implementationProvider = false
								client.server_capabilities.referencesProvider = false
								client.server_capabilities.definitionProvider = false
								client.server_capabilities.definitionProvider = true
								-- vim.print(client.server_capabilities)
							end,
						})
					end,
					["intelephense"] = function()
						require("lspconfig").intelephense.setup({
							on_attach = function(client)
								client.server_capabilities.hoverProvider = false
								client.server_capabilities.implementationProvider = true
								client.server_capabilities.referencesProvider = true
								client.server_capabilities.definitionProvider = false
								-- client.server_capabilities.documentFormattingProvider = true
								-- client.server_capabilities.documentRangeFormattingProvider = true
							end,
							init_options = {
								licenceKey = "/Users/smilga/.config/intelephense_licence.txt",
							},
							settings = {
								intelephense = {
									files = {
										maxSize = 3000000,
									},
									completion = {
										insertUseDeclaration = true, -- Automatically add use declarations
									},
								},
							},
						})
					end,
				},
			})
		end,
	},
}
