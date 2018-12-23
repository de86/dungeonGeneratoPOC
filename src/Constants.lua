SCREEN_CENTER_X = GAME_CONFIG.GAME_WIDTH / 2;
SCREEN_CENTER_Y = GAME_CONFIG.GAME_HEIGHT / 2;

COLOURS = {
    WHITE = {1, 1, 1, 1},

    DUNGEON = {
        [RoomType.Entry]    = getLoveColourFromRGBA(130, 189, 66,  1),
        [RoomType.Standard] = getLoveColourFromRGBA(158, 158, 158, 1),
        [RoomType.Obstacle] = getLoveColourFromRGBA(208, 51,  37,  1),
        [RoomType.Key]      = getLoveColourFromRGBA(208, 148, 37,  1)
    },

    DOORS = {
        [Doors.Open]   = getLoveColourFromRGBA(155, 248, 145, 1),
        [Doors.Locked] = getLoveColourFromRGBA(248, 177, 145, 1)
    }
}
