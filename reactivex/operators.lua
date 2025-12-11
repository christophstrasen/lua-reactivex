-- Nested shim: load the real aggregator one directory up (reactivex/operators.lua)
-- even when searchers pick up this file first. Avoid recursive require() on the
-- same module name by calling the parent chunk directly.
local function load_parent_aggregator()
	local info = debug and debug.getinfo and debug.getinfo(1, "S")
	local source = info and info.source or ""
	if source:sub(1, 1) == "@" then
		source = source:sub(2)
	end
	local dir = source:match("(.*/)") or "./"
	local chunk = loadfile(dir .. "../operators.lua")
	if chunk then
		return chunk()
	end
end

-- Prefer an already-exposed root-level operators.lua (PZ layout).
local ok, mod = pcall(require, "operators")
if ok then
	return mod
end

-- Fall back to the parent aggregator without recursing back into this shim.
return load_parent_aggregator()
