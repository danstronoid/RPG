

TurnCounter = Class{}

function TurnCounter:init()
    self.count = 0
    self.counters = {}
end

local function addCounter(group, counter)
    local index = #group + 1
    counter.index = index
    counter.group = group
    group[index] = counter
end

local function rmCounter(group, counter)
    local index = counter.index
    group[index] = group[#group]
    group[index].index = index
    group[#group] = nil
end

function TurnCounter:increment()
    self.count = self.count + 1
    for i = 1, #self.counters do
        self.counters[i]:update(self.count)
    end
end

function TurnCounter:after(delay, callback)
    addCounter(self.counters, {
        delay = self.count + delay,
        callback = callback or function() end,
        update = function(counter, count)
            print('updoot')
            if count >= counter.delay then
                counter.callback()
                rmCounter(counter.group, counter)
            end
        end
    })  
end

function TurnCounter:reset()
    self.count = 0
    self.counters = {}
end

function TurnCounter:getCount()
    return self.count
end

