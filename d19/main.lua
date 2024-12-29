TRIE = nil
DESIGNS = {}
P1 = 0
P2 = 0


-- ========= GRID =========
-- G = {}
--
-- for line in io.lines() do
-- 	local row = {}
-- 	for ch in line:gmatch(".") do
-- 		table.insert(row, ch)
-- 	end
-- 	table.insert(G, row)
-- end
--
-- for y, row in ipairs(G) do
-- 	for x, cell in ipairs(row) do
-- 		print(cell)
-- 	end
-- end

-- ========= PRIORITY Q =========
-- local function qmerge(h1, h2)
-- 	if not h1 then return h2 end
-- 	if not h2 then return h1 end
-- 	if h1.value > h2.value then
-- 		h1, h2 = h2, h1
-- 	end
-- 	h1.right, h1.left = h1.left, qmerge(h2, h1.right)
-- 	return h1
-- end
--
-- local function qpush(h, v) return qmerge(h, { value = v, left = nil, right = nil }) end
--
-- local function qpop(h) return h and h.value, qmerge(h.left, h.right) or nil, nil end

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
