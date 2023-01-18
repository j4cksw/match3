function test_checkMatchesAvailable()

    local tiles_1 = generateTilesFromColors({{ 1, 2, 1, 1, 3, 4, 5, 6}})
    assert_equal(1, countAvailableMatches(tiles_1))

    local tiles_2 = generateTilesFromColors({{ 2, 3, 2, 2, 1, 4, 1, 1}})
    assert_equal(2, countAvailableMatches(tiles_2))
end

function generateTilesFromColors(colors)
    local tiles = {}
    for tileY = 1, #colors do
        table.insert(tiles, {})
        for tileX = 1, #colors[tileY] do
            table.insert(tiles[tileY], Tile(tileX, tileY, colors[tileY][tileX], 0, 0))
        end
    end
    return tiles
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
