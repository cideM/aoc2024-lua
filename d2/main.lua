local function pass(nums)
	local asc = nil
	for i = 2, #nums do
		local prev, cur = nums[i - 1], nums[i]
		local diff = math.abs(cur - prev)
		if diff < 1 or diff > 3 then
			return false
		end

		if asc == nil then
			asc = cur > prev
			goto continue
		end

		if asc and cur < prev or asc == false and cur > prev then
			return false
		end
		::continue::
	end
	return true
end

P1, P2 = 0, 0
for line in io.lines() do
	local nums = {}
	for num in line:gmatch("%d+") do
		table.insert(nums, tonumber(num))
	end

	for i = 1, #nums do
		local nums_copy = table.move(nums, 1, #nums, 1, {})
		table.remove(nums_copy, i)
		if pass(nums_copy) then
			P2 = P2 + 1
			goto continue
		end
	end

	::continue::

	P1 = P1 + (pass(nums) and 1 or 0)
end
print(P1, P2)
