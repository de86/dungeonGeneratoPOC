Door = Class{}



function Door:init(position, leadsToRoomId, isLocked, parentRoom)
    self.position = position;
    self.leadsToRoomId = leadsToRoomId;
    self.isLocked = isLocked;

    self.size = self:getSize();
    self.pos = self:getPosition(parentRoom.pos, parentRoom.size);
    self.status = self.isLocked and Doors.Locked or Doors.Open;
end



function Door:getPosition(roomPos, roomSize)
    local offset = roomSize / 2;
    local doorXOffset = (self.size.width / 2);
    local doorYOffset = (self.size.height / 2);
    
    -- Shows working out. Makes it more readable for me.
    local northEdgeY = roomPos.y;
    local southEdgeY = roomPos.y + roomSize;
    local northEdgeYWithOffset = northEdgeY - doorYOffset;
    local southEdgeYWithOffset = southEdgeY - doorYOffset;

    local eastEdgeX = roomPos.x;
    local westEdgeX = roomPos.x + roomSize;
    local eastEdgeXWithOffset = eastEdgeX - doorXOffset;
    local westEdgeXWithOffset = westEdgeX - doorXOffset;

    local roomCenterX = roomPos.x + offset;
    local roomCenterY = roomPos.y + offset;
    local roomCenterXOffset = roomCenterX - doorXOffset;
    local roomCenterYOffset = roomCenterY - doorYOffset;

    if self.position == Direction.North then
        return {x = roomCenterXOffset, y = northEdgeYWithOffset}
    elseif self.position == Direction.South then
        return {x = roomCenterXOffset, y = southEdgeYWithOffset}
    elseif self.position == Direction.East then
        return {x = westEdgeXWithOffset, y = roomCenterYOffset}
    elseif self.position == Direction.West then
        return {x = eastEdgeXWithOffset, y = roomCenterYOffset}
    end
end



function Door:getSize()
    local depth = 50;
    local breadth = 200;

    if self.position == Direction.North or self.position == Direction.South then
        return {width = breadth, height = depth}
    elseif self.position == Direction.East or self.position == Direction.West then
        return {width = depth, height = breadth}
    end
end



function Door:render(renderOffset)
    love.graphics.setColor(COLOURS.DOORS[self.status]);
    love.graphics.rectangle(
        "fill",
        self.pos.x + renderOffset.x,
        self.pos.y + renderOffset.y,
        self.size.width,
        self.size.height
    );
end
