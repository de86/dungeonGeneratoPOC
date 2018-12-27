TweenRoomOutState = Class{__includes = State};



local TRANSITION_TIME = 0.12;



function TweenRoomOutState:init(fromRoom, toRoom, direction, viewDungeonState)
    self.fromRoom = fromRoom;
    self.toRoom = toRoom;
    self.currentRoom = self.fromRoom;
    self.direction = direction;
    self.renderOffsetX = 0;
    self.renderOffsetY = 0;
    self.onTweenFinish = onTweenFinish;
    self.viewDungeonState = viewDungeonState;
end


function TweenRoomOutState:getRenderOffset()
    local renderOffset = {x = 0, y = 0};

    if self.direction == Direction.North then
        renderOffset.y = GAME_CONFIG.GAME_HEIGHT;
    elseif self.direction == Direction.South then
        renderOffset.y = -GAME_CONFIG.GAME_HEIGHT
    elseif self.direction == Direction.West then
        renderOffset.x = GAME_CONFIG.GAME_WIDTH;
    elseif self.direction == Direction.East then
        renderOffset.x = -GAME_CONFIG.GAME_WIDTH;
    end
    
    return renderOffset;
end



function TweenRoomOutState:enter()
    print('tween enter');

    local renderOffset = self:getRenderOffset();

    Timer.tween(TRANSITION_TIME, {
        [self] = {
            renderOffsetX = renderOffset.x,
            renderOffsetY = renderOffset.y,
        }
    })
    :finish(function()
        print('tween room in');
        self.renderOffsetX = -renderOffset.x;
        self.renderOffsetY = -renderOffset.y;
        self.currentRoom = self.toRoom;

        Timer.tween(TRANSITION_TIME, {
            [self] = {
                renderOffsetX = 0,
                renderOffsetY = 0
            }
        })
        :finish(function()
            g_stateStack:pop();
        end)
    end)
end


function TweenRoomOutState:exit()
    self.viewDungeonState:onFinishRoomTransition();
end



function TweenRoomOutState:update(dt)
    print(self.renderOffsetX);
    Timer.update(dt);
end



function TweenRoomOutState:render()
    self.currentRoom:render(self.renderOffsetX, self.renderOffsetY);
end