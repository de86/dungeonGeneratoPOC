StartState = Class{__includes = State}



function StartState:update(dt)
    if love.keyboard.wasPressed('return') then
        print(enter);
        g_stateMachine:change(States.Play)
    end
end



function StartState:render()
    love.graphics.setColor(COLOURS.WHITE);
    love.graphics.printf(
        'Press Enter to Start',
        0,
        GAME_CONFIG.GAME_HEIGHT / 2,
        GAME_CONFIG.GAME_WIDTH,
        'center'
    );
end
