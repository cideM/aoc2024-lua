INPUT = {}
P1 = 0
P2 = 0

for line in io.lines() do
	print(line)
end

print(P1, P2)













-- ===== GRID =========
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

-- == PRIORITY QUEUE ==
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

-- ==== PREFIX TREE ===
-- local function tinsert(t, word)
-- 	if not word or #word == 0 then
-- 		t.terminal = true
-- 		return t
-- 	end
-- 	local c = word:sub(1, 1)
-- 	t.children = t.children or {}
-- 	t.children[c] = t.children[c] or { terminal = false, children = nil }
-- 	t.children[c] = tinsert(t.children[c], word:sub(2))
-- 	return t
-- end
--
-- local function tprefixes(t, word)
-- 	local result = {}
-- 	local function collect(node, prefix, remaining)
-- 		if node.terminal then table.insert(result, prefix) end
-- 		if #remaining == 0 then return end
-- 		local c = remaining:sub(1, 1)
-- 		if node.children and node.children[c] then
-- 			collect(node.children[c], prefix .. c, remaining:sub(2))
-- 		end
-- 	end
-- 	collect(t, "", word)
-- 	return result
-- end
