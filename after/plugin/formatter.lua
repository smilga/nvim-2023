local eslintfix = function()
    local filepath = vim.api.nvim_buf_get_name(0)
    return {
        exe = "eslint",
        args = { "--stdin-filename", filepath, "--fix", "--cache" },
        stdin = false
    }
end

require("formatter").setup {
    logging = true,
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
            function()
                return {
                    exe = "rustywind",
                    args = {
                        "--stdin",
                    },
                    stdin = true
                }
            end,
            eslintfix
        },
        typescript = {
            eslintfix
        },
        javascript = {
            eslintfix
        }
    }
}
