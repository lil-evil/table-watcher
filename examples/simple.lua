-- this basic example cover : 
-- - functions watch, destroy
-- - basic use of events set and get

local table_watcher = require"../table-watcher"

-- lets create our table
local user = {
    name = "john",
    surname = "doe",
    age = 20,
    hobbies = {"trips", "basketball", "linux"},
    driver_licence = true
}

-- now create our events callback
local events = {
    set = function(t, k, v) print("set " .. k .. " to " .. v) end,
    get = function(t, k) print("get " .. k .. " (" .. t[k] .. ")") end
}

-- and register all of that to create our watcher
local watched = table_watcher.watch(user, events)


-- this allow to track access to a field
-- and/or track modifications to a field

print("== user name : " .. watched.name .. " ==")

watched.age = 21
print("== set watched.age ==")

watched.birthdate = "12/03"
print("== set watched.birthdate ==")

-- when done with the watcher you can safely destroy it
table_watcher.destroy(watched)
print("== destroyed watcher ==")

-- this will not trigger
watched.age = 22
print("== set watched.age ==")