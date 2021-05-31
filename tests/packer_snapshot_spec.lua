local a = require('plenary.async_lib.tests')
local await = require('packer.async').wait
local async = require('packer.async').sync
local packer = require("packer")
local fmt = string.format
local config = {
    snapshot_path = vim.fn.stdpath("cache") .. "/" .. "packer"
}

describe("Packer snapshot tests", function()
  local spec = {"tjdevries/colorbuddy.vim"}
  local short_name = 'colorbuddy'
  local snapshot_name = 'test'
  local test_path = config.snapshot_path .. "/" .. snapshot_name
  local expected = {}
  local actual = {}
  expected.colorbuddy = '87c80e3'

  packer.startup(spec)
  packer.install()

  it(fmt("snapshot '%s' created", snapshot_name), function ()
    packer.snapshot(snapshot_name)
    assert.True(vim.fn.filereadable(config.snapshot_path))
  end)

    --      it("snapshot is correctly formatted", function ()
    --        local tmp = io.open(tostring(test_path), "r+")
    --        local line = tmp:read("*l")
    --        local plugin = line:sub(1,line:find(" "))
    --        actual[plugin] = line:sub(line:find(" "), line:len())
    --        assert.are.same(actual, expected)
    --      end)

  --  describe("PackerRollback:", function ()
  --    it("success", function ()
  --      assert.True(true)
  --    end)
  --  end)
end)
