--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- TurnCounter --

    This class functions much like a timer library except 
    it updates only when the increment method is called.  This
    class should be instantiated at the global level so that the
    timer functions can be accessed anywhere.
]]

TurnCounter = Class{}

-- keep a table of all active turn counters 
function TurnCounter:init()
    self.count = 0
    self.counters = {}
end

-- add a new counter to the table
local function addCounter(group, counter)
    local index = #group + 1
    counter.index = index
    counter.group = group
    group[index] = counter
end

-- remove a counter from the table
local function rmCounter(group, counter)
    local index = counter.index
    group[index] = group[#group]
    group[index].index = index
    group[#group] = nil
end

-- increment the turn count and call update on all of the counters
function TurnCounter:increment()
    self.count = self.count + 1
    for i = 1, #self.counters do
        self.counters[i]:update(self.count)
    end
end

-- creates a new counter that will exceute the callback after a number of turns
function TurnCounter:after(delay, callback)
    addCounter(self.counters, {
        delay = self.count + delay,
        callback = callback or function() end,
        update = function(counter, count)
            --print('updoot')
            if count >= counter.delay then
                counter.callback()
                rmCounter(counter.group, counter)
            end
        end
    })  
end

-- reset the counter and remove all active counters
function TurnCounter:reset()
    self.count = 0
    self.counters = {}
end

-- get the current turn count
function TurnCounter:getCount()
    return self.count
end

