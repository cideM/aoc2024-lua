G, S, E = {}, {}, {}
for line in io.lines() do
	local row = {}
	for s in line:gmatch(".") do
		table.insert(row, s)
		if s == "S" then
			S = { #G + 1, #row }
		end
		if s == "E" then
			E = { #G + 1, #row }
		end
	end
	table.insert(G, row)
end

local function dirkey(pos, dir)
	local y, x = table.unpack(pos)
	return string.format("%d;%d;%s", y, x, dir)
end

local function key(pos)
	local y, x = table.unpack(pos)
	return string.format("%d;%d", y, x)
end

local costs = {
	[">"] = { ["v"] = 1001, ["^"] = 1001, ["<"] = 2001, [">"] = 1 },
	["<"] = { ["v"] = 1001, ["^"] = 1001, ["<"] = 1, [">"] = 2001 },
	["v"] = { ["v"] = 1, ["^"] = 2001, ["<"] = 1001, [">"] = 1001 },
	["^"] = { ["v"] = 2001, ["^"] = 1, ["<"] = 1001, [">"] = 1001 },
}

local vectors = {
	[">"] = { 0, 1 },
	["<"] = { 0, -1 },
	["v"] = { 1, 0 },
	["^"] = { -1, 0 },
}

local function getneighbor(grid, pos, dir)
	local dy, dx = table.unpack(vectors[dir])
	local y, x = table.unpack(pos)
	return { y + dy, x + dx }, (grid[y + dy] or {})[x + dx]
end

local function dijkstra(grid, start, startdir)
	local dists, seen, previous, queue = {}, {}, {}, { { start, startdir } }

	for y, row in ipairs(grid) do
		for x in ipairs(row) do
			for _, dir in ipairs { ">", "<", "^", "v" } do
				dists[dirkey({ y, x }, dir)] = math.huge
			end
		end
	end

	seen[dirkey(start, startdir)] = true
	dists[dirkey(start, startdir)] = 0

	while #queue > 0 do
		table.sort(queue, function(a, b)
			return dists[dirkey(a[1], a[2])] < dists[dirkey(b[1], b[2])]
		end)

		local cur = table.remove(queue, 1)
		local curpos, curdir = cur[1], cur[2]
		local curkey = key(curpos)
		local curdirkey = dirkey(curpos, curdir)

		if dists[curkey] == math.huge then
			error("something went wrong")
		end

		for _, dir in ipairs { ">", "<", "^", "v" } do
			local cost = costs[curdir][dir]
			local neighbor, cell = getneighbor(grid, curpos, dir)
			local neighbordirkey = dirkey(neighbor, dir)
			if cell ~= "#" then
				local cur_route_cost = dists[curdirkey] + cost

				if cur_route_cost < dists[neighbordirkey] then
					dists[neighbordirkey] = cur_route_cost
					previous[neighbordirkey] = curdirkey
				end

				if not seen[neighbordirkey] then
					seen[neighbordirkey] = true
					table.insert(queue, { neighbor, dir })
				end
			end
		end
	end

	return dists, previous
end

local d, p = dijkstra(G, S, ">")
local best_cost = math.huge
for _, dir in ipairs { ">", "<", "^", "v" } do
	local cost = d[dirkey(E, dir)]
	if cost <= best_cost then
		best_cost = cost
	end
end

print(best_cost)
