local function do_snapshot(filename)
    print(filename)
end

local function cfg(_config) config = _config end

local snapshot = setmetatable({cfg = cfg}, {__call = do_snapshot})
return snapshot
