local packer = require("packer")
local path = require("plenary.path")
local config = {
    snapshot_path = vim.fn.stdpath("cache").."/packer/"
}

describe("Packer snapshot tests", function()
  after_each(function()
    packer.reset()
  end)

  it("PackerSnapshot: ", function ()
    local spec = {"tjdevries/colorbuddy.vim"}
    local short_name = 'colorbuddy'
    local snapshot_name = 'test'
    local test_path = path.joinpath(config.snapshot_path, snapshot_name)
    local expected = {}
    expected.colorbuddy = '87c80e3'
    packer.startup(spec)
    packer.install()
    packer.snapshot(snapshot_name)
    describe("snapshot exists", function ()
      assert.True(path.exists(test_path))
    end)
    describe("snapshot is correctly formatted", function ()
      assert.True(path.exists(test_path))
    end)
  end)

end)

describe("Packer snapshot rollback tests", function ()
  print("prova")
end)
