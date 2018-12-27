DungeonGen = Class{__includes = State}


--[[
    Maybe only use single global state stack but add isPaused flag to states.
    This should let us skip updating and rendering without destroying state object.

    Pause: doesn't update, does render
    Sleep: doesn't update, doesn't render
]]--
function DungeonGen:init()
    self.dungeonGenStateStack = StateStack();
    self.dungeonGenStateStack:push(ViewDungeonState());
end



function DungeonGen:update(dt)
    self.dungeonGenStateStack:update(dt)
end



function DungeonGen:render()
    self.dungeonGenStateStack:render();
end
