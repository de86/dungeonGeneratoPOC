Walker = Class{};



function Walker:init()
    self.currentRoomId = 0;
    self.prevNodeId = 0;
    self.currentRootNodeId = 0;
    self.currentObstacleNodeId = null;

    self.roomCount = 0;
    self.map = {};
end



function Walker:buildDungeon()
    local EXIT = -1;
    local OBSTACLE_COUNT = 3

    local entryRoomNode = self:createRoomNode(
        RoomType.Entry,
        IS_CRITICAL_PATH,
        self:getRandomDirection(),
        EXIT
    );
    self.map[entryRoomNode.id] = entryRoomNode;

    self:generateDungeonLevels(3);

    return self.map;
end



function Walker:generateDungeonLevels(obstacle_count)
    for i = 1, obstacle_count do
        local direction = self:getRandomDirection();

        self.currentRootNodeId = self.currentRoomId;
        self:incrementRoomNode();
        self:addAdjacentRoomNodeToRoomNode(self.prevNodeId, direction, self.currentRoomId, RoomType.Standard);

        local nextRoom = self:createRoomNode(RoomType.Standard, IS_CRITICAL_PATH, direction, self.prevNodeId);
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
        self:incrementRoomNode();

        local direction = self:getRandomDirection();
        local roomType = self:rollForRoomType(RoomType.Obstacle, 1 / 3);
        local nextRoom = self:createRoomNode(roomType, IS_CRITICAL_PATH, direction, self.prevNodeId);
        
        self:addAdjacentRoomNodeToRoomNode(self.prevNodeId, direction, self.currentRoomId, nextRoom.type);
        self.map[nextRoom.id] = nextRoom;

        isCreatingCriticalPath = not (roomType == RoomType.Obstacle);
    end
end



function Walker:addAdjacentRoomNodeToRoomNode(roomNodeId, direction, roomNodeIdToAdd, nextRoomType)
    self.map[roomNodeId]:addAdjacentRoom(direction, roomNodeIdToAdd, nextRoomType);
end



function Walker:createRoomNode(roomType, isCriticalPath, prevRoomExitPoint, prevRoomId)
    return Room(
        roomType,
        self.roomCount,
        isCriticalPath,
        self:getEntryPointFromExitPoint(prevRoomExitPoint),
        prevRoomId
    );
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



function Walker:getRandomDirection()
    return math.random(1, 4);
end



function Walker:rollForRoomType(roomType, chanceForTrue)
    local isGivenRoomType = math.random() < chanceForTrue;

    return isGivenRoomType and roomType or RoomType.Standard;
end



function Walker:jumpToRoomNode(node)
    self.currentRoomId = roomNode;
end



function Walker:incrementRoomNode()
    self.prevNodeId = self.currentRoomId;
    self.roomCount = self.roomCount + 1;
    self.currentRoomId = self.roomCount;
end


function Walker:getEntryPointFromExitPoint(prevRoomExitPoint)
    return prevRoomExitPoint + (prevRoomExitPoint <= 2 and 2 or -2);
end
