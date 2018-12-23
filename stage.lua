--[[
    The Stage is designed to manage the rendering of the
    game world to the screen.

    May need a more comprehensive table to store all rendering
    data

    ToDo:
        - Implementation
        - Managing of entity rendering
        - Particles
]]--
Stage = Class{};

local LAYERS_QTY = 10;



--[[
    Builds tables used for layers.
    10 Layers total
]]--
function Stage:init(layerIndex, map)
end



--[[
    Takes a table of tiles and an index and inserts the tiles
    into the given layer. an empty tile in the given table does not
    overwrite, the existing tile is preserved.
]]--
function Stage:pushToLayer(layerIndex, map)
end



--[[
    Totally clears the layer at the given index
]]--
function Stage:clearLayer(layerIndex)
end



--[[
    Totally clears ALL layers
]]--
function Stage:clearStage(layerIndex)
end



--[[
    Renders all layers to the screen with higher index layers overdrawing
    lower level layers    
]]--
function Stage:render()
end
