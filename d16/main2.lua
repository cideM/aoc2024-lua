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

local function key(pos, dir)
	local y, x = table.unpack(pos)
	return string.format("%d;%d;%s", y, x, dir)
end

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

local function all_paths(grid, start, goal)
	local q = {
		{ pos = start, dir = ">", path = {start}, cost = 0 },
	}

	local found, visited = {}, {}

	while #q > 0 do
		local cur = table.remove(q, 1)
		local curkey = key(cur.pos, cur.dir)

		if cur.pos[1] == goal[1] and cur.pos[2] == goal[2] then
			table.insert(found, {
				path = cur.path,
				cost = cur.cost,
				dir = cur.dir,
			})
			goto continue
		end

		if visited[curkey] and visited[curkey] < cur.cost then
			goto continue
		end
		visited[curkey] = cur.cost

		for _, dir in ipairs { ">", "<", "^", "v" } do
			local dy, dx = table.unpack(vectors[dir])
			local y, x = cur.pos[1] + dy, cur.pos[2] + dx
			local pos = { y, x }
			if (grid[y] or {})[x] ~= "#" then
				local path = table.move(cur.path, 1, #cur.path, 1, {})
				table.insert(path, pos)
				table.insert(q, {
					pos = pos,
					path = path,
					dir = dir,
					cost = cur.cost + costs[cur.dir][dir],
				})
			end
		end
		::continue::
	end

	return found
end

local found = all_paths(G, S, E)
local best = found[1].cost
for _, path in ipairs(found) do
	if path.cost < best then
		best = path.cost
	end
end

local unique_steps, p2 = {}, 0

for _, path in ipairs(found) do
	if path.cost == best then
		for _, step in ipairs(path.path) do
			if not unique_steps[key(step, "")] then
				unique_steps[key(step, "")] = true
				p2 = p2 + 1
			end
		end
	end
end

for y in ipairs(G) do
	for x in ipairs(G[y]) do
		local o = unique_steps[key { y, x }]
		io.write(o and "O" or G[y][x])
	end
	print("")
end

print(best, p2)
