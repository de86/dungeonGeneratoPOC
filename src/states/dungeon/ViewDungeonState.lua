ViewDungeonState = Class{__includes = State}



function ViewDungeonState:init(dungeon)
    self.dungeon = dungeon ~= nil and dungeon or Dungeon();
    self.currentRoom = self.dungeon.map[0];
    self.nextRoom = {};
    self.shouldUpdate = true;
    self.shouldRender = true;
end



function ViewDungeonState:pause()
    self.shouldUpdate = false;
    self.shouldRender = true;
end



function ViewDungeonState:sleep()
    self.shouldUpdate = false;
    self.shouldRender = false;
end



function ViewDungeonState:resume()
    self.shouldUpdate = true;
    self.shouldRender = true;
end



function ViewDungeonState:moveInDirection(direction)
    local availableDoors = self.currentRoom.adjacentRooms;
    
    if availableDoors[direction] ~= nil and availableDoors[direction].leadsToRoomId >= 0 then
        self.nextRoom = self.dungeon.map[availableDoors[direction].leadsToRoomId];
        
        g_stateStack:push(TweenRoomOutState(
            self.currentRoom,
            self.nextRoom,
            direction,
            self
        ));

        self:sleep();
    end
end



function ViewDungeonState:onFinishRoomTransition()
    self.currentRoom = self.nextRoom;
    self:resume();
end



function ViewDungeonState:update(dt)
    if self.shouldUpdate then
        if love.keyboard.wasPressed('up') then
            self:moveInDirection(Direction.North);

        elseif love.keyboard.wasPressed('down') then
            self:moveInDirection(Direction.South);

        elseif love.keyboard.wasPressed('right') then
            self:moveInDirection(Direction.East);

        elseif love.keyboard.wasPressed('left') then
            self:moveInDirection(Direction.West);

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
end



function ViewDungeonState:render()
    if self.shouldRender then
        self.currentRoom:render();

        love.graphics.setColor(COLOURS.WHITE);
        love.graphics.print('dungeonGen test state', 25, 25);
    end
end
