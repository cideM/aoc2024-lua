local function insert(trie, word)
	local cur = trie
	for w in word:gmatch(".") do
		if not cur.children[w] then
			cur.children[w] = { children = {}, isTerminal = false, value = nil }
		end
		cur = cur.children[w]
	end

	cur.isTerminal = true
	cur.value = word
end

local function findSuffixes(trie, prefix)
	local out = {}
	local cur = trie
	for w in prefix:gmatch(".") do
		if not cur.children[w] then
			break
		end
		cur = cur.children[w]
	end
	-- `cur` is now the node that has `prefix`, and we want to return
	-- all its descendants
	local recur
	recur = function(n)
		if n.isTerminal then
			table.insert(out, n.value)
		end

		for _, child in pairs(n.children) do
			recur(child)
		end
	end

	recur(cur)

	return out
end

local root = { children = {}, isTerminal = false, value = "" }

DESIGNS = {}
for line in io.lines() do
	if line:match(",") then
		for s in line:gmatch("%w+") do
			insert(root, s)
		end
	elseif #line > 0 then
		table.insert(DESIGNS, line)
	end
end

local cache = {}

local function check(s, path)
	if cache[s] then
		return cache[s]
	end

	if s == "" then
		return 1
	end

	local out = 0
	local candidates = findSuffixes(root, s:sub(1, 1))
	for _, pat in ipairs(candidates) do
		local next, matches = s:gsub("^" .. pat, "")
		if matches > 0 and #findSuffixes(root, pat) > 0 then
			local copy = table.move(path, 1, #path, 1, {})
			table.insert(copy, pat)
			out = out + check(next, copy)
		end
	end

	cache[s] = out

	return out
end

local solutions = {}
local p1, p2 = 0, 0
for _, design in ipairs(DESIGNS) do
	solutions[design] = check(design, {})
	if solutions[design] > 0 then
		p1 = p1 + 1
	end
	p2 = p2 + solutions[design]
end
print(p1, p2)
