--[[
    Given an image atlas return a 2D table (array) of quads
    corresponding to each sprite in the atlas
]]--
function GetQuadsFromAtlas(atlas)
    local tileSize = GAME_CONFIG.TILE_SIZE;
    local atlasWidth = atlas:getWidth() / tileSize;
    local atlasHeight = atlas:getHeight() / tileSize;

    local quads = {};
    local quadCount = 1;

    for y = 0, atlasHeight - 1 do
        for x = 0, atlasWidth - 1 do
            local quad = love.graphics.newQuad(
                x * tileSize,
                y * tileSize,
                tileSize,
                tileSize,
                gSprites[SpriteSheets.Dungeon]:getDimensions()
            );

            quads[quadCount] = quad;
            quadCount = quadCount + 1;
        end
    end

    return quads;
end


--[[
    Recursive table printing function.
    https://coronalabs.com/blog/2014/09/02/tutorial-printing-table-contents/
]]
function print_r ( t )
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end


function getLoveColourFromRGBA(r, g, b, a)
    local HEXMAX = 255;

    return {
        r / HEXMAX,
        g / HEXMAX,
        b / HEXMAX,
        a
    }
end



function getRandomDirection()
    return math.random(1, 4);
end