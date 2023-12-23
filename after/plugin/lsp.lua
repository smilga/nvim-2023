local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
--
-- vim.diagnostic.config({
--     virtual_text = false,
--     signs = true,
--     underline = {
--         severity = { min = vim.diagnostic.severity.WARN },
--     },
--     update_in_insert = false,
--     severity_sort = false,
--     float = {
--         show_header = true,
--         source = 'always',
--         border = 'rounded',
--         focusable = false,
--     },
-- })
-- vim.o.updatetime = 250
