gSprites = {
    [SpriteSheets.Dungeon] = love.graphics.newImage('assets/dungeonTilesheet.png')
};

gSpriteQuads = {
    [SpriteSheets.Dungeon] = GetQuadsFromAtlas(gSprites[SpriteSheets.Dungeon])
};
