local G, p1, p2 = {}, 0, 0
for line in io.lines() do
	if line:match("(%d+)|(%d+)") then
		G[line] = true
		goto skip_line
	end

	local p = {}
	for d in line:gmatch("%d+") do
		table.insert(p, tonumber(d))
	end

	if #p > 0 then
		for i = 2, #p do
			local l, r = p[i - 1], p[i]

			if G[r .. "|" .. l] then
				local original_order = {}
				for j, n in ipairs(p) do
					original_order[n] = j
				end
				table.sort(p, function(a, b)
					if G[a .. "|" .. b] then
						return true
					elseif G[b .. "|" .. a] then
						return false
					else
						return original_order[a] < original_order[b]
					end
				end)
				p2 = p2 + p[(#p // 2) + 1]
				goto continue
			end
		end

		p1 = p1 + p[(#p // 2) + 1]

		::continue::
	end

	::skip_line::
end
print(p1, p2)
