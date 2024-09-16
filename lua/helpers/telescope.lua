local telescope = require("telescope.builtin")
local telescope_state = require("telescope.state")

local LIVE_GREP = "Live Grep"

function telescope.search_with_cache()
	local last_search = nil

	return function()
		print(last_search)
		local cached_pickers = telescope_state.get_global_key("cached_pickers") or {}

		if cached_pickers[1] and cached_pickers[1].prompt_title == LIVE_GREP then
			last_search = vim.deepcopy(cached_pickers[1])
		else
			last_search = nil
		end

		if last_search == nil then
			telescope.live_grep()
		else
			telescope.resume({ picker = last_search })
		end
	end
end

return telescope
