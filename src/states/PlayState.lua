PlayState = Class{__includes = State}


function PlayState:update(dt)
end



function PlayState:render()
    love.graphics.setColor(COLOURS.WHITE);
    love.graphics.printf(
        'Playing',
        0,
        GAME_CONFIG.GAME_HEIGHT / 2,
        GAME_CONFIG.GAME_WIDTH,
        'center'
    );
end
