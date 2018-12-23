DungeonGen = Class{__includes = State}



function DungeonGen:init()
    dungeon = Dungeon();
end



function DungeonGen:update(dt)
    if love.keyboard.wasPressed('space') then
        -- Dungeon
    end
end



function DungeonGen:render()
    dungeon:render();

    love.graphics.setColor(COLOURS.WHITE);
    love.graphics.print( 'dungeonGen test state', 25, 25);
end
