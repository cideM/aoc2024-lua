A, B = {}, {}
P1, P2 = 0, 0
for line in io.lines() do
	local a, b = line:match("(%d+)%s+(%d+)")
	a, b = tonumber(a), tonumber(b)
	table.insert(A, a)
	table.insert(B, b)
end
table.sort(A)
table.sort(B)
for i, n in ipairs(A) do
	P1 = P1 + math.abs(B[i] - n)
end
print(P1)

local frequencies = {}
for _, n in ipairs(B) do
	if not frequencies[n] then
		frequencies[n] = 0
	end
	frequencies[n] = frequencies[n] + 1
end

for _, n in ipairs(A) do
	P2 = P2 + n * (frequencies[n] or 0)
end
print(P2)
