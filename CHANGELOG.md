# CHANGELOG

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.0.2] - 2021-05-28

### Changed
- ```:PackerRollback <snapshot name>``` allows you to rollback to a snapshot. You need to close and reopen NeoVim
- ```snapshot_default = stdpath('cache')/packer``` by default

### Commits
- d43d8de 2021-05-28 Implemented PackerRollback with display
- 826323d 2021-05-27 Refactoring
- e946e1f 2021-05-27 More EmmyLua docs
- 7a06c89 2021-05-27 snapshot_default = stdpath('cache')/packer
- 8357ea9 2021-05-26 Changed stdpath from config -> cache

## [0.0.1] - 2021-05-24

### Added

- ```:PackerSnapshot <snapshot name>``` which takes a snapshot of the plugins and saves it.
- Added ```snapshot``` and ```snapshot_path``` fields to ```config```
- To restore a snapshot you have to create create your own config file, i.e.
```
    return packer.startup({function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    ...

    end, 
    config = {snapshot = 'snapshot_name'}})
```
- By default snapshots are saved and loaded from ~/.config/nvim/plugin/, you can change this by setting ```snapshot_path ``` editing your config:
```
    config = {
        snapshot = 'your_snapshot',
        ...
        snapshot_path = 'your/new/path'
    }
```

### Commits
    
- 1bf7e3f Update CHANGELOG
- 71c0721 Added snapshot_path as default snapshot location
- ab466c3 Rollback working
- 2400050 Refactoring and added 'snapshot' field to config
- cbc8b06 PackerSnapshot + works
- 31c01cd Added async snapshot()
- 26480f2 Added filename parameter to PackerSnapshot command
- c7560a5 Added PackerSnapshot command
