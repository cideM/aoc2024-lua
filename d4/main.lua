G, P1, P2 = {}, 0, 0
for line in io.lines() do
	local row = {}
	for c in line:gmatch(".") do
		table.insert(row, c)
	end
	table.insert(G, row)
end

local function get_dir_str(start, dir, len)
	local buf = {}
	local cur = start
	while G[cur[1]] and G[cur[1]][cur[2]] and #buf < len do
		table.insert(buf, G[start[1]][start[2]])
		cur[1] = cur[1] + dir[1]
		cur[2] = cur[2] + dir[2]
	end
	return table.concat(buf)
end

for y = 1, #G do
	for x = 1, #G[y] do
		for _, vec in ipairs {
			{ 0, -1 },
			{ -1, -1 },
			{ -1, 0 },
			{ -1, 1 },
			{ 0, 1 },
			{ 1, 1 },
			{ 1, 0 },
			{ 1, -1 },
		} do
			local str = get_dir_str({ y, x }, vec, 4)
			if str == "XMAS" then
				P1 = P1 + 1
			end
		end

		local strs = {}
		for _, vec in ipairs {
			{ -1, -1 },
			{ -1, 1 },
			{ 1, 1 },
			{ 1, -1 },
		} do
			local str = get_dir_str({ y, x }, vec, 2)
			table.insert(strs, str)
		end

		local patterns = {
			AMASASAM = true,
			AMAMASAS = true,
			ASAMAMAS = true,
			ASASAMAM = true,
		}
		if patterns[table.concat(strs)] then
			P2 = P2 + 1
		end
	end
end
print(P1, P2)
