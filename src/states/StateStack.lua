--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- StateStack --

    This class implements a state machine using the behaviour of a stack 
    data structure.
]]

StateStack = Class{}

function StateStack:init()
    self.states = {}
end

function StateStack:update(dt)
    -- only update the state on top of the stack
    self.states[#self.states]:update(dt)
end

function StateStack:render()
    -- render all states in the stack
    for i, state in pairs(self.states) do
        state:render()
    end
end

-- remove all states from the stack
function StateStack:clear()
    self.states = {}
end

-- push a new state onto the stack
function StateStack:push(state)
    table.insert(self.states, state)
    state:enter()
end

-- pop a state off of the stack
function StateStack:pop()
    self.states[#self.states]:exit()
    table.remove(self.states)
end

-- return the state on top of the stack
-- need to give states an id for this to work
function StateStack:top()
    return self.states[#self.states].id
end