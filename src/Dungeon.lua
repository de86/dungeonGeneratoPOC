Dungeon = Class{};



function Dungeon:init()
    self.width = GAME_CONFIG.NUMBER_X_TILES;
    self.height = GAME_CONFIG.NUMBER_Y_TILES;
    self.tileSize = GAME_CONFIG.TILE_SIZE;
    self.map = self:generate();
    print_r(self.map);

    self.currentRoom = self.map[0];
end



function Dungeon:generate()
    local walker = Walker();
    return walker:buildDungeon();
end



function Dungeon:moveInDirection(direction)
    local availableDoors = self.currentRoom.adjacentRooms;

    if availableDoors[direction] ~= nil and availableDoors[direction].leadsToRoomId >= 0 then
        self.currentRoom = self.map[availableDoors[direction].leadsToRoomId];
        
        return true;
    else
        return false;
    end
end



function Dungeon:render()
    self.currentRoom:render(self.map);
end