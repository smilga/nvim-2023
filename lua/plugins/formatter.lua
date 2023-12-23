local eslintfix = function()
    vim.cmd(':EslintFixAll')

    -- local filepath = vim.api.nvim_buf_get_name(0):gsub("%[", "\\["):gsub("%]", "\\]")
    -- print(filepath)
    --
    -- return {
    --     exe = "eslint",
    --     args = { "--stdin-filename", filepath, "--fix", "--cache" },
    --     stdin = false
    -- }
end

return {
    'mhartington/formatter.nvim',
    setup = function()
        require("formatter").setup {
            logging = true,
            log_level = vim.log.levels.DEBUG,
            opts = function()
                vim.api.nvim_create_autocmd("BufWritePost", {
                    pattern = { "*" },
                    command = "FormatWrite",
                })
            end,
            filetype = {
                ["*"] = {
                    require("formatter.filetypes.any").remove_trailing_whitespace
                },
                go = {
                    function()
                        return {
                            exe = "goimports",
                            stdin = true,
                        }
                    end,
                },
                vue = {
                    eslintfix,
                    function()
                        return {
                            exe = "rustywind",
                            args = {
                                "--stdin",
                            },
                            stdin = true
                        }
                    end,
                },
                typescript = {
                    eslintfix
                },
                javascript = {
                    eslintfix
                }
            }
        }
    end,
}
