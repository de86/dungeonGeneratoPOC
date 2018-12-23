Room = Class{}



function Room:init(type, id, isCriticalPath, entryPoint, prevRoomId)
    self.size = 500;
    self.OFFSET = self.size / 2;
    self.id = id;
    self.type = type;
    self.adjacentRooms = {};
    self.pos = {
        x = SCREEN_CENTER_X - self.OFFSET,
        y = SCREEN_CENTER_Y - self.OFFSET
    };
    
    self.dungeonColour = COLOURS.DUNGEON[self.type];

    -- Add previous room to adjacent room map. Set Id to 0 if no prevRoomId provided
    -- 0 returns to dungeon exit
    self:addAdjacentRoom(entryPoint, prevRoomId, type);
end



function Room:addAdjacentRoom(direction, roomId, roomType)
    local isLocked = roomType == RoomType.Obstacle
    local door = Door(direction, roomId, isLocked, self);
    self.adjacentRooms[direction] = door;
end



function Room:renderBase()
    love.graphics.setColor(self.dungeonColour);
    love.graphics.rectangle(
        "fill",
        self.pos.x,
        self.pos.y,
        self.size,
        self.size,
        30,
        30,
        12
    );
end



function Room:renderDoors()
    for position, door in pairs(self.adjacentRooms) do
        door:render(self.pos, self.size);
    end
end


function Room:render(dungeonMap)
    self:renderBase();
    self:renderDoors();
end
