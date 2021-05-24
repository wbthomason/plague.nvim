# CHANGELOG
- Added PackerSnapshot command to take snapshots of all installed plugins.
- Added ```snapshot ``` and ```snapshot_path ``` fields to ```config```
- To restore a snapshot you have to create create your own config file, i.e.
```
    return packer.startup({function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    ...

    end, 
    config = {snapshot = 'snapshot_name'}})
```
- By default snapshots are saved and loaded from ~/.config/nvim/plugin/, you change this by setting ```snapshot_path ``` editing your config:
```
    config = {
        snapshot = 'your_snapshot',
        ...
        snapshot_path = 'your/new/path'
    }
```
