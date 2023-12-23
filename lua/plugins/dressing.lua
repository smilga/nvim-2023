return {
    'stevearc/dressing.nvim',
    config = function()
        require('dressing').setup({
            input = {
                relative = "editor",
            },
            select = {
                get_config = function(opts)
                    if opts.kind == 'codeaction' then
                        return {
                            backend = 'telescope',
                            nui = {
                                relative = 'cursor',
                                max_width = 40,
                            }
                        }
                    end
                end
            }
        })
    end
}
