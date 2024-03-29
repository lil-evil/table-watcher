# Table-watcher

a Lua library that allows you to observe changes on a table and more.


## Summary
---
1. [Installation](#Installation)
2. [Usage](#Usage)
3. [Limitations](#Limitations)
4. [Functions](#Functions)
5. [Changelog](#Changelog)
6. [License](#License)
---

## Installation

You can install table-watcher using [lit](https://github.com/luvit/lit). Run the following command:

```shell
$ lit install lil-evil/table-watcher
```

## Usage

To use table-watcher in your Lua project, you need to require the module:

```lua
local table_watcher = require("table-watcher")
local data = {1,2,3}

local events = {
    get = function(self, key) print("access to ".. key) end,
    set = function(self, key, value) print("set "..key.." to "..value) end
}
local watched = table_watcher.watch(data, events)

-- Access a value (triggers the get event)
local value = watched.key

-- Modify a value (triggers the set event)
watched.key = newValue

-- Create a clone of the watched table without triggering events
local clonedTable = watcher.unwatch(watched, true)
watched.key = newValue      -- still trigger
clonedTable.key = newValue  -- won't trigger

-- Destroy the watched table and restore the original table
local restoredTable = watcher.destroy(watched)
-- none will trigger
watched.key = newValue
restoredTable.key = newValue

-- Check if a table is being watched
local isWatched = watcher.is_watched(watched)
```
## Limitations
Any event can be prevented from trigger using `rawset` and `rawget`.
As such, functions from the table library may not work due to the use of theses function to interface with tables.

A benchmark can be done with [examples/benchmark.lua](examples/benchmark.lua).

## Functions

### `watcher.watch (data, events)`

Watch a table for gets and sets.

**Parameters:**

- `data` (table): Table to watch.
- `events` (table): List of events to interact with. ([Example](examples/events.lua))
  - `get` (function(table, key, self)): Triggered when accessing a field.
  - `set` (function(table, key, value, self)): Triggered when setting a field.

**Returns:**

- `table`: The watched table.

### `watcher.unwatch (data, clone)`

Returns a table that no longer triggers events.

**Parameters:**

- `data` (table): Table to unwatch.
- `clone` (boolean|nil): Whether to deep clone the table before returning it.

**Returns:**

- `table`: The unwatched table.

### `watcher.destroy (data)`

Completely destroys all watcher instances of this table and returns a shallow copy of the original table.

**Parameters:**

- `data` (table): Watcher to destroy.

**Returns:**

- `table`: The destroyed table.

### `watcher.is_watched (data)`

Checks if the data is watched.

**Parameters:**

- `data` (table): Table to check.

**Returns:**

- `boolean`: `true` if the table is watched, `false` otherwise.

## Changelog
You can see the full changelog [here](./changelog.md).

## License
This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for more information.