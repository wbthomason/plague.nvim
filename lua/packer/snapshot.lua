local a = require('packer.async')
local async = a.sync
local await = a.wait
local fmt = string.format
local log = require('packer.log')
local plugin_utils = require('packer.plugin_utils')

local function cfg(_config) config = _config end

--- Makes a snapshot of all plugins to the path specified by filename
--- @param filename string
--- @param plugins Plugin[]
--- @return function
local function do_snapshot(_, filename, plugins)
  return async(function()
    local raw_snapshot = ""
    local opt, start = plugin_utils.list_installed_plugins()
    local installed = {}

    for key, _ in pairs(opt) do
      installed[key] = key
    end

    for key, _ in pairs(start) do
      installed[key] = key
    end

    for _, plugin in pairs(plugins) do
      if installed[plugin.install_path] ~= nil then -- this plugin is installed
        log.info(fmt("Snapshotting '%s'", plugin.short_name))
        local r = await(plugin.get_rev())
        if r == nil then
          log.warning(fmt("Snapshotting %s failed", plugin.short_name))
        else
          raw_snapshot = raw_snapshot .. plugin.short_name .. ' ' .. r.ok .. "\n"
        end
      end
    end

    local file = io.open(filename, "w+")
    file:write(raw_snapshot)
    file:close()
  end)
end

local snapshot = setmetatable({cfg = cfg}, {__call = do_snapshot})

return snapshot
