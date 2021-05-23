local a = require('packer.async')
local async = a.sync
local await = a.wait
local fmt = string.format
local log = require('packer.log')
local plugin_utils = require('packer.plugin_utils')

local function cfg(_config) config = _config end
--[[
property: 1
property: diff
property: short_name
property: path
property: install_path
property: installer
property: updater
property: name
property: url
property: revert_last
property: type
--]]

--- Makes a snapshot of all plugins to the path specified by filename
--- @param filename string
--- @param plugins table<string, any>
--- @return function
local function do_snapshot(_, filename, plugins)
  return async(function()
    local snapshot_content = ""
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
          snapshot_content = snapshot_content .. plugin.short_name .. ' ' .. r.ok .. "\n"
        end
      end
    end
    print(snapshot_content)

    local file = io.open(filename, "w+")

    file:write(snapshot_content)
    file:close()
  end)
end

local snapshot = setmetatable({cfg = cfg}, {__call = do_snapshot})
return snapshot
