Room = Class{}



function Room:init(type, id, isCriticalPath)
    self.size = 600;
    self.offset = self.size / 2;
    self.id = id;
    self.type = type;
    self.adjacentRooms = {};
    self.isCriticalPath = isCriticalPath;
    self.pos = {
        x = SCREEN_CENTER_X - self.offset,
        y = SCREEN_CENTER_Y - self.offset
    };
    
    self.dungeonColour = COLOURS.DUNGEON[self.type];
end



function Room:addAdjacentRoom(direction, roomId, roomType)
    print(roomType, roomType == RoomType.Obstacle);
    local isLocked = roomType == RoomType.Obstacle;
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
