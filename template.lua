INPUT = {}
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
	print(line)
end

print(P1, P2)
