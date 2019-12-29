--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- util --

    Helper functions.
]]

--[[
    Given an "atlas" (a texture with multiple sprites), as well as a
    width and a height for the tiles therein, split the texture into
    all of the quads by simply dividing it evenly.
    Taken directly from Colton Ogden - 50Mon.
]]
function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
                tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end

--[[ This is a function taken from the Love2D wiki used for creating
gradients.  source: https://love2d.org/wiki/Gradients ]]
-- Color multipler
local COLOR_MUL = love._version >= "11.0" and 1 or 255
 
function gradientMesh(dir, ...)
    -- Check for direction
    local isHorizontal = true
    if dir == "vertical" then
        isHorizontal = false
    elseif dir ~= "horizontal" then
        error("bad argument #1 to 'gradient' (invalid value)", 2)
    end
 
    -- Check for colors
    local colorLen = select("#", ...)
    if colorLen < 2 then
        error("color list is less than two", 2)
    end
 
    -- Generate mesh
    local meshData = {}
    if isHorizontal then
        for i = 1, colorLen do
            local color = select(i, ...)
            local x = (i - 1) / (colorLen - 1)
 
            meshData[#meshData + 1] = {x, 1, x, 1, color[1], color[2], color[3], color[4] or (1 * COLOR_MUL)}
            meshData[#meshData + 1] = {x, 0, x, 0, color[1], color[2], color[3], color[4] or (1 * COLOR_MUL)}
        end
    else
        for i = 1, colorLen do
            local color = select(i, ...)
            local y = (i - 1) / (colorLen - 1)
 
            meshData[#meshData + 1] = {1, y, 1, y, color[1], color[2], color[3], color[4] or (1 * COLOR_MUL)}
            meshData[#meshData + 1] = {0, y, 0, y, color[1], color[2], color[3], color[4] or (1 * COLOR_MUL)}
        end
    end
 
    -- Resulting Mesh has 1x1 image size
    return love.graphics.newMesh(meshData, "strip", "static")
end

-- this function formats time from seconds into HH:MM:SS
function formatTime(t)
    local hours = string.sub('0' .. math.floor(t / 3600), -2)
    local minutes = string.sub('0' .. math.floor(t / 60 % 60), -2)
    local seconds = string.sub('0' .. t % 60, -2)

    return hours .. ':' .. minutes .. ':' .. seconds
end

-- function to round to the nearest integer
function round(n)
    if n < 0 then
        return math.ceil(n - 0.5)
    else 
        return math.floor(n + 0.5)
    end
end