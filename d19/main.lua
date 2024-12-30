TRIE = nil
DESIGNS = {}
P1 = 0
P2 = 0

-- ========= PREFIX TREE ==
local function tinsert(t, word)
	if not word or #word == 0 then
		t.terminal = true
		return t
	end
	local c = word:sub(1, 1)
	t.children = t.children or {}
	t.children[c] = t.children[c] or { terminal = false, children = nil }
	t.children[c] = tinsert(t.children[c], word:sub(2))
	return t
end

local function tprefixes(t, word)
	local result = {}
	local function collect(node, prefix, remaining)
		if node.terminal then table.insert(result, prefix) end
		if #remaining == 0 then return end
		local c = remaining:sub(1, 1)
		if node.children and node.children[c] then
			collect(node.children[c], prefix .. c, remaining:sub(2))
		end
	end
	collect(t, "", word)
	return result
end

for line in io.lines() do
	if not TRIE then
		TRIE = { terminal = false, children = {} }
		for pat in line:gmatch("%w+") do
			TRIE = tinsert(TRIE, pat)
		end
	elseif #line > 0 then
		table.insert(DESIGNS, line)
	end
end

-- BE CAREFUL WITH BOOLEAN VALUES IN YOUR CACHE!
-- If you do `if cache[s] then` this will SKIP THE CACHE if the stored value happens to be `false`
local cache = {}

local function match(design, trie)
	if cache[design] then return cache[design] end
	if design == "" then return 1 end
	local result = 0
	for _, pat in ipairs(tprefixes(trie, design)) do
		local s = design:gsub("^" .. pat, "", 1)
		result = result + match(s, trie)
	end
	cache[design] = result
	return result
end

for _, design in ipairs(DESIGNS) do
	local result = match(design, TRIE)
	if result > 0 then
		P1 = P1 + 1
		P2 = P2 + result
	end
end

print(P1, P2)
