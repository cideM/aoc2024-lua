G, TH, P1, P2 = {}, {}, 0, 0
for line in io.lines() do
	local row = {}
	for ch in line:gmatch(".") do
		table.insert(row, tonumber(ch))
		if ch == "0" then
			table.insert(TH, { #G + 1, #row })
		end
	end
	table.insert(G, row)
end

local function dfs(start, target)
	local q = { { point = start, path = { start } } }
	local seen = { start[1] .. "," .. start[2] }
	local found = {}

	while #q > 0 do
		local cur = table.remove(q, 1)
		local y, x = table.unpack(cur.point)
		local height = G[y][x]
		if height == target then
			table.insert(found, cur.path)
		end

		local neighbors = {}
		for _, dydx in ipairs { { -1, 0 }, { 0, 1 }, { 1, 0 }, { 0, -1 } } do
			local dy, dx = table.unpack(dydx)
			local y2, x2 = y + dy, x + dx
			local neighbor_height = (G[y2] or {})[x2] or math.maxinteger
			if height + 1 == neighbor_height and not seen[y2 .. "," .. x2] then
				table.insert(neighbors, { y2, x2 })
			end
		end

		for _, n in ipairs(neighbors) do
			local next_path = table.move(cur.path, 1, #cur.path, 1, {})
			table.insert(next_path, n)
			table.insert(q, { point = n, path = next_path })
		end
	end

	return found
end

for _, th in ipairs(TH) do
	local seen_last_points, count_unique_last_points = {}, 0
	local seen_paths, count_unique_paths = {}, 0

	local found = dfs(th, 9)

	for _, path in ipairs(found) do
		do
			local last_point = path[#path]
			local key = last_point[1] .. "," .. last_point[2]
			if not seen_last_points[key] then
				seen_last_points[key] = true
				count_unique_last_points = count_unique_last_points + 1
			end
		end

		do
			local buf = {}
			for _, p in ipairs(path) do
				table.insert(buf, p[1] .. "," .. p[2])
			end
			local s = table.concat(buf, "|")
			if not seen_paths[s] then
				seen_paths[s] = true
				count_unique_paths = count_unique_paths + 1
			end
		end
	end
	P1, P2 = P1 + count_unique_last_points, P2 + count_unique_paths
end
print(P1, P2)
