INPUT = {}
P1 = 0
P2 = 0

G = {}

for line in io.lines() do
	local row = {}
	for ch in line:gmatch(".") do
		table.insert(row, ch)
	end
	table.insert(G, row)
end

for y, row in ipairs(G) do
	for x, cell in ipairs(row) do
		for _, dir in ipairs {
			{ 0, -1 },
			{ -1, -1 },
			{ -1, 0 },
			{ -1, 1 },
			{ 0, 1 },
			{ 1, 1 },
			{ 1, 0 },
			{ 1, -1 },
		} do
			local buf = { cell }
			local dy, dx = table.unpack(dir)
			local y2, x2 = y, x
			for _ = 1, 3 do
				y2, x2 = y2 + dy, x2 + dx
				table.insert(buf, (G[y2] or {})[x2])
			end
			if table.concat(buf) == "XMAS" then P1 = P1 + 1 end
		end

		if cell == "A" then
			local buf = { cell }
			for _, dir in ipairs { { -1, -1 }, { -1, 1 }, { 1, 1 }, { 1, -1 } } do
				local dy, dx = table.unpack(dir)
				local y2, x2 = y + dy, x + dx
				table.insert(buf, (G[y2] or {})[x2])
			end
			local patterns = {
				AMSSM = true,
				AMMSS = true,
				ASMMS = true,
				ASSMM = true,
			}
			if patterns[table.concat(buf)] then P2 = P2 + 1 end
		end
	end
end

print(P1, P2)
