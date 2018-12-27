--[[
    Top Down

    Author: Dave Elliott
    Contact: daelliott86@gmail.com

    Top down is a procedurally generated top down adventure proof of concept game.
    The aim of this PoC is to figure out how to procedurally generate maps, towns,
    enemies, quests dungeons, weapons and loot.
]]--

require 'gameConfig';

require 'src/Enums';
require 'src/Utils';
require 'src/Constants'

require 'lib/exports';
require 'assets/exports';

require 'src/states/DungeonGen';
require 'src/states/PlayState';
require 'src/states/StartState';
require 'src/states/dungeon/ViewDungeonState';
require 'src/states/dungeon/TweenRoomOutState';

require 'src/Walker';
require 'src/StateMachine';
require 'src/StateStack';
require 'src/Dungeon';
require 'src/Room';
require 'src/Door';


function love.load()
    math.randomseed(GAME_CONFIG.SEED);

    love.graphics.setDefaultFilter('linear', 'linear');
    love.window.setTitle(GAME_CONFIG.TITLE);

    push:setupScreen(
        GAME_CONFIG.GAME_WIDTH,
        GAME_CONFIG.GAME_HEIGHT,
        GAME_CONFIG.WINDOW_WIDTH,
        GAME_CONFIG.WINDOW_HEIGHT,
        GAME_CONFIG.PUSH_SETTINGS
    );

    g_stateStack = StateStack()
    g_stateStack:push(ViewDungeonState());
end



function love.resize(w, h)
    push:resize(w, h)
end



function love.update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit();
    end

    g_stateStack:update(dt);

    love.keyboard.flushKeysPressedCache();
end



function love.draw()
    push:start();

    g_stateStack:render();

    push:finish();
end
