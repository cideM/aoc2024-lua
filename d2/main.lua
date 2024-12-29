D, P1, P2 = {}, 0, 0

for line in io.lines() do
	local row = {}
	for ch in line:gmatch("%d+") do
		table.insert(row, tonumber(ch))
	end
	table.insert(D, row)
end

local function safe(line)
	local inc, dec = 0, 0
	for i, d in ipairs { table.unpack(line, 2) } do
		local prev = line[i]
		if d > prev then
			inc = inc + 1
		elseif d < prev then
			dec = dec + 1
		end

		local diff = math.abs(d - prev)
		if diff < 1 or diff > 3 then
			return false
		end
	end
	return inc == #line - 1 or dec == #line - 1
end

for _, line in ipairs(D) do
	if safe(line) then
		P1 = P1 + 1
	end

	for i in ipairs(line) do
		local copy = table.move(line, 1, #line, 1, {})
		table.remove(copy, i)
		if safe(copy) then
			P2 = P2 + 1
			goto continue
		end
	end
	::continue::
end
print(P1, P2)
