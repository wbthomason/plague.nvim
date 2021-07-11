local a = require('plenary.async_lib.tests')
local path = require('plenary.path')
local describe = require('plenary.busted').describe
local it = require('plenary.busted').it
local await = require('packer.async').wait
local async = require('packer.async').sync
local packer = require("packer")
local log = require "packer.log"
local use = packer.use
local fmt = string.format

local config = {
    snapshot_path = vim.fn.stdpath("cache") .. "/" .. "packer"
}

local spec = {'wbthomason/packer.nvim'}

a.describe('Packer testing packer.snapshot()', function ()
    local snapshot_name = "test"
    local test_path = config.snapshot_path .. "/" .. snapshot_name
    local snapshot = require 'packer.snapshot'

    before_each(function ()
        local _packer = packer.startup(function ()
            use(spec)
        end)
        _packer.__manage_all()
    end)

    a.it(fmt("create snapshot '%s'", test_path), function ()
        await(snapshot(test_path, {spec}))
        local p = path:new(test_path)
        assert.True(p:exists())
    end)
end)
