Walker = Class{};



function Walker:init()
    self.currentRoomId = 0;
    self.prevRoomId = 0;
    self.currentRootNodeId = 0;
    self.currentObstacleNodeId = null;
    self.prevRoomDirection = 0;

    self.roomCount = 0;
    self.map = {};
end



function Walker:buildDungeon()
    local EXIT = -1;
    local OBSTACLE_COUNT = 3;
    local IS_CRITICAL_PATH = true;

    local entryRoomNode = Room(RoomType.Entry, self.currentRoomId, IS_CRITICAL_PATH);
    entryRoomNode:addAdjacentRoom(getRandomDirection(), EXIT, RoomType.Exit);
    self.map[entryRoomNode.id] = entryRoomNode;

    self:generateDungeonLevels(3, self.currentRoomId);

    return self.map;
end



function Walker:generateDungeonLevels(obstacle_count, rootRoomId)
    self.currentRootNodeId = rootRoomId;
    self.currentRoomId = rootRoomId;

    for i = 1, obstacle_count do
        self.nextRoomdirection = self:getAvailableRoomDirection(self.map[self.currentRoomId]);
        self.prevRoomDirection = self:getEntryPointFromExitPoint(self.nextRoomdirection);

        local prevRoom = self.map[self.currentRoomId];
        local NEXT_ROOM_TYPE = RoomType.Standard
        local IS_CRITICAL_PATH = true;

        self:incrementRoomNode();
        
        prevRoom:addAdjacentRoom(self.nextRoomdirection, self.currentRoomId, NEXT_ROOM_TYPE);

        local nextRoom = Room(RoomType.Standard, self.currentRoomId, IS_CRITICAL_PATH);
        nextRoom:addAdjacentRoom(self.prevRoomDirection, prevRoom.id, prevRoom.type);

        self.map[nextRoom.id] = nextRoom;

        self:createPathToObstacle();
        --self:createPathToKey();
        --self:createOptionalPaths();
    end
end



function Walker:createPathToObstacle()
    local IS_CRITICAL_PATH = true;
    local isCreatingCriticalPath = true;

    while isCreatingCriticalPath do
        self.nextRoomdirection = self:getAvailableRoomDirection(self.map[self.currentRoomId]);
        self.prevRoomDirection = self:getEntryPointFromExitPoint(self.nextRoomdirection);

        local prevRoom = self.map[self.currentRoomId];
        local nextRoomType = self:rollForRoomType(RoomType.Obstacle, 1 / 3);

        self:incrementRoomNode();
        
        prevRoom:addAdjacentRoom(self.nextRoomdirection, self.currentRoomId, nextRoomType);

        local nextRoom = Room(nextRoomType, self.currentRoomId, IS_CRITICAL_PATH);
        nextRoom:addAdjacentRoom(self.prevRoomDirection, prevRoom.id, prevRoom.type);

        self.map[nextRoom.id] = nextRoom;

        isCreatingCriticalPath = not (nextRoomType == RoomType.Obstacle);
    end
end



function Walker:createPathToKey()
    --[[
        Generate a path somewhere off the path to the obstacle that leads to the obstacle key
    ]]--
end


function Walker:createOptionalPaths()
    --[[
        Generate paths at random points to chests or dead ends
    ]]--
end



function Walker:getAvailableRoomDirection(room)
    local direction = self:getRandomDirection();

    if room == nil then
        return direction
    end

    while room.adjacentRooms[direction] ~= nil do
        direction = self:getRandomDirection();
    end

    return direction;
end



function Walker:getRandomDirection()
    return math.random(1, 4)
end



function Walker:rollForRoomType(roomType, chanceForTrue)
    local isGivenRoomType = math.random() < chanceForTrue;

    return isGivenRoomType and roomType or RoomType.Standard;
end


function Walker:incrementRoomNode()
    self.prevRoomId = self.currentRoomId;
    self.roomCount = self.roomCount + 1;
    self.currentRoomId = self.roomCount;
end


function Walker:getEntryPointFromExitPoint(prevRoomExitPoint)
    return prevRoomExitPoint + (prevRoomExitPoint <= 2 and 2 or -2);
end
