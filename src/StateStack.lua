--[[
    State Stack taken from GD50 course on edx

    Author: Colton Ogden
    Modified by: Dave Elliott
]]

StateStack = Class{}



function StateStack:init()
    self.states = {};
end



function StateStack:update(dt)
    --self.states[#self.states]:update(dt);
    for i, state in ipairs(self.states) do
        state:update(dt);
    end
end



function StateStack:render()
    for i, state in ipairs(self.states) do
        state:render();
    end
end


function StateStack:renderTopState()
    self.states[#self.states]:render();
end



function StateStack:clear()
    self.states = {};
end



function StateStack:push(state)
    table.insert(self.states, state)
    state:enter();
end



function StateStack:pop()
    print('popped');
    print_r(self.states[#self.states]);
    self.states[#self.states]:exit();
    table.remove(self.states);
end
