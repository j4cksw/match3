function test_checkMatchesAvailable()
    local tiles = {
        { Tile(1, 1, 1, 1, 0),
            Tile(1, 2, 2, 1, 0),
            Tile(1, 3, 1, 1, 0),
            Tile(1, 4, 1, 1, 0),
            Tile(1, 5, 3, 1, 0),
            Tile(1, 6, 4, 1, 0),
            Tile(1, 7, 5, 1, 0),
            Tile(1, 8, 6, 1, 0) },
    }
    assert_equal(1, countAvailableMatches(tiles))
    local tiles = {
        { 
            Tile(1, 1, 2, 1, 0),
            Tile(1, 2, 3, 1, 0),
            Tile(1, 3, 2, 1, 0),
            Tile(1, 4, 2, 1, 0),
            Tile(1, 5, 1, 1, 0),
            Tile(1, 6, 4, 1, 0),
            Tile(1, 7, 1, 1, 0),
            Tile(1, 8, 1, 1, 0) },
    }
    assert_equal(2, countAvailableMatches(tiles))
end

function generateTestTiles()
    local tiles = {}
    for tileY = 1, 8 do
        table.insert(tiles, {})
        for tileX = 1, 8 do
            table.insert(tiles[tileY],
                Tile(tileX, tileY, 1, 1, 0))
        end
    end
    return tiles
end
