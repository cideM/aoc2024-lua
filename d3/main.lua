local line, p1, p2, matches_ordered = io.read("a"), 0, 0, {}
for _, pat in ipairs { "do%(%)", "don't%(%)", "mul%((%d+),(%d+)%)" } do
	local init = 1
	repeat
		local first, last, a, b = line:find(pat, init)
		if first then
			matches_ordered[first] = a and b and a * b or pat
		end
		init = last
	until not first
end
local keys = {}
for k in pairs(matches_ordered) do
	table.insert(keys, k)
end
table.sort(keys)
local factor = 1
for _, k in ipairs(keys) do
	local v = matches_ordered[k]
	factor = v == "don't%(%)" and 0 or v == "do%(%)" and 1 or factor
	if type(v) == "number" then
		p2 = p2 + v * factor
		p1 = p1 + v
	end
end
print(p1, p2)
