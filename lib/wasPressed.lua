--[[
    Extension method to get single key stroke on last frame.
    Allows to do something on initial keypress and not worry about the
    key being held down.
]]--

love.keyboard.keysPressed = {};


function love.keypressed(key)
    love.keyboard.keysPressed[key] = true;
end


function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true;
    else
        return false;
    end
end


-- Should be called in top level update to guarantee cache is flushed
-- each frame
function love.keyboard.flushKeysPressedCache()
    love.keyboard.keysPressed = {};
end
