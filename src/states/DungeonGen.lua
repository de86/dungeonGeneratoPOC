DungeonGen = Class{__includes = State}



function DungeonGen:init()
    dungeon = Dungeon();
end



function DungeonGen:update(dt)
    if love.keyboard.wasPressed('up') then
        dungeon:moveInDirection(Direction.North);

    elseif love.keyboard.wasPressed('down') then
        dungeon:moveInDirection(Direction.South);

    elseif love.keyboard.wasPressed('right') then
        dungeon:moveInDirection(Direction.East);

    elseif love.keyboard.wasPressed('left') then
        dungeon:moveInDirection(Direction.West);

    elseif love.keyboard.wasPressed('space') then
        --[[
            ToDo:
                - Tween between rooms
                - Debug menu
                - Re-generate dungeons on keypress
                - Implement path to key
                - Implement path to chests
                - Implement dead-ends
                - Implement shortcuts between sections/floors
        ]]
    end
end



function DungeonGen:render()
    dungeon:render();

    love.graphics.setColor(COLOURS.WHITE);
    love.graphics.print('dungeonGen test state', 25, 25);
end
