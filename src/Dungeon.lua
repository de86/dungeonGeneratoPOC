Dungeon = Class{};



function Dungeon:init()
    self.width = GAME_CONFIG.NUMBER_X_TILES;
    self.height = GAME_CONFIG.NUMBER_Y_TILES;
    self.tileSize = GAME_CONFIG.TILE_SIZE;

    self.currentRoomId = 0;
    self.map = self:generate();
    print_r(self.map);
end



function Dungeon:generate()
    local walker = Walker();
    return walker:buildDungeon();
end



function Dungeon:mapToString()
    local row = '';

    for y = 1, table.getn(self.map) do
        for x = 1, table.getn(self.map[1]) do
            row = row .. tostring(self.map[y][x]) .. ', ';
        end

        print(row);
        row = '';
    end

    print('-----------------------------------------------');
end



function Dungeon:render()
    self.map[self.currentRoomId]:render(self.map);
end