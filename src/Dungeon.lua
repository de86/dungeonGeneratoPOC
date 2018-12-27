--[[
    Will eventually hold more info about dungeon. Enemies, Bosses, Chests etc.
]]
Dungeon = Class{};



function Dungeon:init()
    -- Not currently needed
    -- self.width = GAME_CONFIG.NUMBER_X_TILES;
    -- self.height = GAME_CONFIG.NUMBER_Y_TILES;
    -- self.tileSize = GAME_CONFIG.TILE_SIZE;
    self.map = self:generate();
    print_r(self.map);
end



function Dungeon:generate()
    local walker = Walker();
    return walker:buildDungeon();
end