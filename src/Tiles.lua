function randomizeTiles(level, shinyRate)
    local tiles = {}
    print('initializing tiles' .. level)
    for tileY = 1, 8 do

        -- empty table that will serve as a new row
        table.insert(tiles, {})

        for tileX = 1, 8 do
            -- create a new tile at X,Y with a random color and variety
            table.insert(tiles[tileY],
                Tile(tileX, tileY, math.random(9), math.random(level), math.random() <= shinyRate))
        end
    end

    local matches = findMatches(tiles)
    if  #matches > 0 and countAvailableMatches(tiles) > 0 then
        -- recursively initialize if matches were returned so we always have
        -- a matchless board on start
        return randomizeTiles(level, shinyRate)
    end
    return tiles
end

--[[
    Goes left to right, top to bottom in the board, calculating matches by counting consecutive
    tiles of the same color. Doesn't need to check the last tile in every row or column if the 
    last two haven't been a match.
]]
function findMatches(tiles)
    local matches = {}

    -- how many of the same color blocks in a row we've found
    local matchNum = 1

    -- horizontal matches first
    for y = 1, 8 do
        local colorToMatch = tiles[y][1].color

        matchNum = 1

        -- every horizontal tile
        for x = 2, 8 do
            -- if this is the same color as the one we're trying to match...
            if tiles[y][x].color == colorToMatch then
                matchNum = matchNum + 1
            else
                -- set this as the new color we want to watch for
                colorToMatch = tiles[y][x].color

                -- if we have a match of 3 or more up to now, add it to our matches table
                if matchNum >= 3 then
                    local match = {}

                    -- go backwards from here by matchNum
                    for x2 = x - 1, x - matchNum, -1 do
                        -- add each tile to the match that's in that match
                        table.insert(match, tiles[y][x2])
                    end

                    -- add this match to our total matches table
                    table.insert(matches, match)
                end

                -- don't need to check last two if they won't be in a match
                if x >= 7 then
                    break
                end

                matchNum = 1
            end
        end

        -- account for the last row ending with a match
        if matchNum >= 3 then
            local match = {}

            -- go backwards from end of last row by matchNum
            for x = 8, 8 - matchNum + 1, -1 do
                table.insert(match, tiles[y][x])
            end

            table.insert(matches, match)
        end
    end

    -- vertical matches
    for x = 1, 8 do
        local colorToMatch = tiles[1][x].color

        matchNum = 1

        -- every vertical tile
        for y = 2, 8 do
            if tiles[y][x].color == colorToMatch then
                matchNum = matchNum + 1
            else
                colorToMatch = tiles[y][x].color

                if matchNum >= 3 then
                    local match = {}

                    for y2 = y - 1, y - matchNum, -1 do
                        table.insert(match, tiles[y2][x])
                    end

                    table.insert(matches, match)
                end

                matchNum = 1

                -- don't need to check last two if they won't be in a match
                if y >= 7 then
                    break
                end
            end
        end

        -- account for the last column ending with a match
        if matchNum >= 3 then
            local match = {}

            -- go backwards from end of last row by matchNum
            for y = 8, 8 - matchNum, -1 do
                table.insert(match, tiles[y][x])
            end

            table.insert(matches, match)
        end
    end

    return matches
end

--[[
    Remove the matches from the Board by just setting the Tile slots within
    them to nil, then setting self.matches to nil.
]]
function removeMatches(tiles, matches)
    if matches ~= nil and #matches == 0 then 
        print('not delete')
        return
    end

    print('delete')
    for k, match in pairs(matches) do
        for k, tile in pairs(match) do
            -- Remove entire row if the tile is shiny
            if tile.isShiny then
                for col = 1, 8 do
                    tiles[tile.gridY][col] = nil
                end
            end
            tiles[tile.gridY][tile.gridX] = nil
        end
    end

    matches = nil
end

function countAvailableMatches(tiles)
    local matchesCount = 0
    for y = 1, #tiles do
        for x = 1, #tiles[y] - 3 do
            if tiles[y][x].color == tiles[y][x+2].color and tiles[y][x].color == tiles[y][x+3].color then
                print(x, y)
                matchesCount = matchesCount + 1
            end
            if tiles[y][x].color == tiles[y][x+1].color and tiles[y][x].color == tiles[y][x+3].color then
                print(x, y)
                matchesCount = matchesCount + 1
            end
        end
        for x = 1, #tiles[y] - 2 do
            if y + 1 <= #tiles and tiles[y][x].color == tiles[y+1][x+1].color and tiles[y][x].color == tiles[y][x+2].color then
                print(x, y)
                matchesCount = matchesCount + 1
            end
            if y - 1 >= 1 and tiles[y][x].color == tiles[y-1][x+1].color and tiles[y][x].color == tiles[y][x+2].color then
                print(x, y)
                matchesCount = matchesCount + 1
            end
        end
        for x = 1, #tiles[y] do
            if y <= #tiles - 3 and tiles[y][x].color == tiles[y+2][x].color and tiles[y][x].color == tiles[y+3][x].color then
                print(x, y)
                matchesCount = matchesCount + 1
            end
            if y <= #tiles - 3 and tiles[y][x].color == tiles[y+1][x].color and tiles[y][x].color == tiles[y+3][x].color then
                print(x, y)
                matchesCount = matchesCount + 1
            end
            if x + 1 <= #tiles[y] and y <= #tiles - 2 and tiles[y][x].color == tiles[y+1][x+1].color and tiles[y][x].color == tiles[y+2][x].color then
                print(x, y)
                matchesCount = matchesCount + 1
            end
            if x - 1 >= 1 and y <= #tiles - 2 and tiles[y][x].color == tiles[y+1][x-1].color and tiles[y][x].color == tiles[y+2][x].color then
                print(x, y)
                matchesCount = matchesCount + 1
            end
        end
    end
    
    print(matchesCount)
    return matchesCount
end

function countMatchesFromPoint(tiles, point)
    local matchesCount = 0
    -- horizontal
    if point.x <= #tiles[point.y] - 2 and tiles[point.y][point.x].color == tiles[point.y][point.x+1].color and tiles[point.y][point.x].color == tiles[point.y][point.x+2].color then
        matchesCount = matchesCount + 1
    end
    if point.x >= 3 and tiles[point.y][point.x].color == tiles[point.y][point.x-1].color and tiles[point.y][point.x].color == tiles[point.y][point.x-2].color then
        matchesCount = matchesCount + 1
    end
    if point.x > 1 and point.x <= #tiles[point.y] -1 and tiles[point.y][point.x].color == tiles[point.y][point.x-1].color and tiles[point.y][point.x].color == tiles[point.y][point.x+1].color then
        matchesCount = matchesCount + 1
    end
    -- vertical
    if #tiles >= 3 and point.y <= #tiles -2 and tiles[point.y][point.x].color == tiles[point.y+1][point.x].color and tiles[point.y][point.x].color == tiles[point.y+2][point.x].color then
        matchesCount = matchesCount + 1
    end
    if #tiles >= 3 and point.y >= 3 and tiles[point.y][point.x].color == tiles[point.y-1][point.x].color and tiles[point.y][point.x].color == tiles[point.y-2][point.x].color then
        matchesCount = matchesCount + 1
    end
    if point.y > 1 and point.y <= #tiles - 1 and tiles[point.y][point.x].color == tiles[point.y-1][point.x].color and tiles[point.y][point.x].color == tiles[point.y+1][point.x].color then
        matchesCount = matchesCount + 1
    end
    return matchesCount
end

function swap(tiles, target, destination, onFinished)
    local targetTile = tiles[target.y][target.x]
    local destTile = tiles[destination.y][destination.x]

    targetTile.gridX = destTile.gridX
    targetTile.gridY = destTile.gridY

    destTile.gridX = target.x
    destTile.gridY = target.y
    
    tiles[targetTile.gridY][targetTile.gridX] = targetTile
    tiles[destTile.gridY][destTile.gridX] = destTile

    Timer.tween(0.1, {
        [targetTile] = {x = destTile.x, y = destTile.y},
        [destTile] = {x = targetTile.x, y = targetTile.y}
    }):finish(onFinished)

    return tiles
end