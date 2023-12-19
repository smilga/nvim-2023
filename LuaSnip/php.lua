-- return {
--   -- A snippet that expands the trigger "hi" into the string "Hello, world!".
--   require("luasnip").snippet(
--     { trig = "bar" },
--     { t("Hello, php!") }
--   ),
--
--   require("luasnip").snippet(
--     { trig = "" },
--     { t("Hello, php!") }
--   ),
--
-- }

local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

local snippets, autosnippets = {}, {}

local pub = s("pub", fmt([[
public function {}({}): {} {{
    {}
}}
]], {
    i(1, ""),
    i(2, ""),
    i(3, ""),
    i(4, ""),
}))

local pro = s("pro", fmt([[
protected function {}({}): {} {{
    {}
}}
]], {
    i(1, ""),
    i(2, ""),
    i(3, ""),
    i(4, ""),
}))

local pri = s("pri", fmt([[
private function {}({}): {} {{
    {}
}}
]], {
    i(1, ""),
    i(2, ""),
    i(3, ""),
    i(4, ""),
}))

local pri = s("con", fmt([[
public function __construct({}) {{
}}
]], {
    i(1, ""),
}))

local class = s("class", fmt([[
<?php

declare(strict_types=1);

namespace App\{}s;

class {}
{{
    {}
}}
]], {
    i(1, ""),
    i(2, ""),
    i(3, ""),
}))

table.insert(snippets, pub)
table.insert(snippets, pro)
table.insert(snippets, pri)
-- table.insert(snippets, con)
table.insert(snippets, class)

return snippets, autosnippets
