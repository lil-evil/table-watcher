-- this example cover : 
-- - advanced use of events set and get

local table_watcher = require("../table-watcher")

-- lets create our table
local user = {
    id = 123456789,
    name = "john",
    surname = "doe",
    age = 20,
    hobbies = {"trips", "basketball", "linux"},
    driver_licence = true,
    secret = "not so secret"
}

-- now create our events callback
-- let's say, we don't want some code (not untrusted code!) to modify the user id
-- and "block" the access to secret
local events = {
    set = function(t, k, v, self) 
        if k == "id" then return self.block end 
    end,
    get = function(t, k, self) 
        if k == "secret" then return self:ret("this is not the secret") end -- or return self.block, "this is not the secret"
    end
}

-- and register all of that to create our watcher
local watched = table_watcher.watch(user, events)


print(watched.secret)

watched.id = 0
print(watched.id)