INIT_REGS, PROG = {}, {}
for line in io.lines() do
	if line:match("Register") then
		table.insert(INIT_REGS, tonumber(line:match("%d+")))
	end

	if line:match("Program") then
		local nums = {}
		for n in line:gmatch("%d+") do
			table.insert(nums, tonumber(n))
		end
		PROG = nums
	end
end

local function run(inita, initb, initc, program)
	local ip, a, b, c = 1, inita, initb, initc
	local out = {}
	while ip < #program do
		local opcode = program[ip]
		local operand = program[ip + 1]
		local combo_ops = {
			[0] = 0,
			[1] = 1,
			[2] = 2,
			[3] = 3,
			[4] = a,
			[5] = b,
			[6] = c,
		}

		if opcode == 0 then
			a = a // (2 ^ combo_ops[operand])
		elseif opcode == 1 then
			b = b ~ operand
		elseif opcode == 2 then
			b = combo_ops[operand] % 8
		elseif opcode == 3 then
			if a ~= 0 then
				ip = operand + 1
			end
		elseif opcode == 4 then
			b = b ~ c
		elseif opcode == 5 then
			table.insert(out, tostring(combo_ops[operand] % 8))
		elseif opcode == 6 then
			b = a // (2 ^ combo_ops[operand])
		elseif opcode == 7 then
			c = a // (2 ^ combo_ops[operand])
		end

		if opcode == 3 and a ~= 0 then
		else
			ip = ip + 2
		end
	end

	for i in ipairs(out) do
		out[i] = math.floor(out[i])
	end

	return out
end

local a, b, c = table.unpack(INIT_REGS)
local out = run(a, b, c, PROG)
print(table.concat(out, ","))

local inita = a + 8 ^ 15
local pow = 13
local match = #PROG
local prog = {}

while match > 0 do
	inita = inita + 8 ^ pow
	local out_ = run(inita, b, c, PROG)
	local s1 = table.concat(table.move(out_, match, #PROG, 1, {}), ",")
	local s2 = table.concat(table.move(PROG, match, #PROG, 1, {}), ",")
	if s1 == s2 then
		table.insert(prog, 1, out_[match])
		print("MATCHED", table.concat(run(inita, b, c, PROG), ","), inita)
		pow = math.max(0, pow - 1)
		match = match - 1
	end
end

print(inita)
