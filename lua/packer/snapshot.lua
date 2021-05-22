local a = require('packer.async')
local async = a.sync
local await = a.wait

local function cfg(_config) config = _config end

local function do_snapshot(_, filename, plugins)
    return async(function()
        for index, value in ipairs(_G.packer_plugins["git-worktree.nvim"]) do
            print(string.format("index: %s, value: %s", index, value))
        end
        print(filename)
    end)
end

local snapshot = setmetatable({cfg = cfg}, {__call = do_snapshot})
return snapshot
