vim.cmd([[
augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost <buffer> :FormatWrite
augroup END
]])
