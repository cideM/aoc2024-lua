INPUT = {}
P1 = 0
P2 = 0

-- GRID = {}

-- for line in io.lines() do
-- 	local row = {}
-- 	for ch in line:gmatch(".") do
-- 		table.insert(row, ch)
-- 	end
-- 	table.insert(GRID, row)
-- end

-- local function skew_merge(h1, h2)
-- 	if not h1 then return h2 end
-- 	if not h2 then return h1 end
--
-- 	if h1.value > h2.value then
-- 		h1, h2 = h2, h1
-- 	end
--
-- 	h1.right, h1.left = h1.left, skew_merge(h2, h1.right)
--
-- 	return h1
-- end
--
-- local function skew_push(h, v) return skew_merge(h, { value = v, left = nil, right = nil }) end
--
-- local function skew_pop(h)
-- 	if not h then return nil, nil end
-- 	return h.value, skew_merge(h.left, h.right)
-- end

for line in io.lines() do
	print(line)
end

print(P1, P2)
