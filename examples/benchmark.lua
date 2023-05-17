local hrtime = require"uv".hrtime
local stats = require"./_stats"

local table_watcher = require"../table-watcher"

local dummy = {
    data = "data to get",
}

local events = {
    get = function(t, k, self)

    end,
    set = function(t, k, v, self)
        
    end
}

local watched = table_watcher.watch(dummy, events)
local _started = hrtime()

local min, max, values = 0, 0, {}
local iterations = 1000000

print"== starting benchmark =="
print("Doing " .. iterations .. " iterations for each test." )

for i = 1, iterations do
    local start = hrtime()
    local value = dummy.data
    table.insert(values, hrtime()-start)
end

max, min = stats.maxmin(values)
print("Standard get :")
print("\t| Minimum process time: " .. min/10^3 .. " μs")
print("\t| Maximum process time: " .. max/10^3 .. " μs")
print("\t| Average of " .. stats.mean(values)/10^3 .. " μs")
print("\t| Median of " .. stats.median(values)/10^3 .. " μs")
print("\t| Standard deviation of " .. stats.standardDeviation(values)/10^3 .. " μs")

min, max, values = 0, 0, {}

for i = 1, iterations do
    local start = hrtime()
    local value = watched.data
    table.insert(values, hrtime()-start)
end

max, min = stats.maxmin(values)
print("\nWatched get :")
print("\t| Minimum process time: " .. min/10^3 .. " μs")
print("\t| Maximum process time: " .. max/10^3 .. " μs")
print("\t| Average of " .. stats.mean(values)/10^3 .. " μs")
print("\t| Median of " .. stats.median(values)/10^3 .. " μs")
print("\t| Standard deviation of " .. stats.standardDeviation(values)/10^3 .. " μs")

min, max, values = 0, 0, {}


for i = 1, iterations do
    local start = hrtime()
    dummy.d = "some data"
    table.insert(values, hrtime()-start)
    dummy.d = nil
end

max, min = stats.maxmin(values)
print("\nStandard set :")
print("\t| Minimum process time: " .. min/10^3 .. " μs")
print("\t| Maximum process time: " .. max/10^3 .. " μs")
print("\t| Average of " .. stats.mean(values)/10^3 .. " μs")
print("\t| Median of " .. stats.median(values)/10^3 .. " μs")
print("\t| Standard deviation of " .. stats.standardDeviation(values)/10^3 .. " μs")

min, max, values = 0, 0, {}

for i = 1, iterations do
    local start = hrtime()
    watched.d = "some data"
    table.insert(values, hrtime()-start)
    watched.d = nil
end

max, min = stats.maxmin(values)
print("\nWatched set :")
print("\t| Minimum process time: " .. min/10^3 .. " μs")
print("\t| Maximum process time: " .. max/10^3 .. " μs")
print("\t| Average of " .. stats.mean(values)/10^3 .. " μs")
print("\t| Median of " .. stats.median(values)/10^3 .. " μs")
print("\t| Standard deviation of " .. stats.standardDeviation(values)/10^3 .. " μs")

min, max, values = 0, 0, {}

print("\n== end of benchmark, took ".. (hrtime()-_started)/10^6 .. " ms ==")