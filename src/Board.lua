--[[
    GD50
    Match-3 Remake

    -- Board Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The Board is our arrangement of Tiles with which we must try to find matching
    sets of three horizontally or vertically.
]]

Board = Class {}

function Board:init(x, y, level, generateTiles)
    print('init board with level: ' .. tostring(level))
    self.x = x
    self.y = y
    self.matches = {}
    self.level = level
    self.shinyRate = 0.2
    self.generateTiles = generateTiles or randomizeTiles
    self:initializeTiles()
end

function Board:increaseLevel()
    self.level = self.level + 1
end

function Board:varietyLevel()
    if self.level > 6 then
        return math.random(6)
    end
    return math.random(self.level)
end

function Board:initializeTiles()
    self.tiles = self.generateTiles(self:varietyLevel(), self.shinyRate)
end

function Board:checkAvailableMatches()
    return true
end

--[[
    Shifts down all of the tiles that now have spaces below them, then returns a table that
    contains tweening information for these new tiles.
]]
function Board:getFallingTiles()
    -- tween table, with tiles as keys and their x and y as the to values
    local tweens = {}

    -- for each column, go up tile by tile till we hit a space
    for x = 1, 8 do
        local space = false
        local spaceY = 0

        local y = 8
        while y >= 1 do
            -- if our last tile was a space...
            local tile = self.tiles[y][x]

            if space then
                -- if the current tile is *not* a space, bring this down to the lowest space
                if tile then
                    -- put the tile in the correct spot in the board and fix its grid positions
                    self.tiles[spaceY][x] = tile
                    tile.gridY = spaceY

                    -- set its prior position to nil
                    self.tiles[y][x] = nil

                    -- tween the Y position to 32 x its grid position
                    tweens[tile] = {
                        y = (tile.gridY - 1) * 32
                    }

                    -- set space back to 0, set Y to spaceY so we start back from here again
                    space = false
                    y = spaceY
                    spaceY = 0
                end
            elseif tile == nil then
                space = true

                if spaceY == 0 then
                    spaceY = y
                end
            end

            y = y - 1
        end
    end

    -- create replacement tiles at the top of the screen
    for x = 1, 8 do
        for y = 8, 1, -1 do
            local tile = self.tiles[y][x]

            -- if the tile is nil, we need to add a new one
            if not tile then
                local tile = Tile(x, y, math.random(9), self:varietyLevel(), math.random() <= self.shinyRate)
                tile.y = -32
                self.tiles[y][x] = tile

                tweens[tile] = {
                    y = (tile.gridY - 1) * 32
                }
            end
        end
    end

    return tweens
end

function Board:getNewTiles()
    return {}
end

function Board:resetTiles()
    self.tiles = {}
    for y = 1, 8 do
        table.insert(self.tiles, {})
        for x = 1, 8 do
            table.insert(self.tiles[y], nil)
        end
    end
end

function Board:render()
    for y = 1, #self.tiles do
        for x = 1, #self.tiles[1] do
            self.tiles[y][x]:render(self.x, self.y)
        end
    end
end

function Board:findByMousePosition(mouseX, mouseY)
    return findByPosition(self.tiles, {x=mouseX, y=mouseY}, { x=self.x, y=self.y })
end
