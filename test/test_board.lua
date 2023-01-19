function test_checkMatchesAvailable()
    local examples = {
        { 
            colors = {{ 1, 2, 1, 1, 3, 4, 5, 6}}, 
            matches = 1
        },
        { 
            colors = {{ 2, 3, 2, 2, 1, 4, 1, 1}}, 
            matches = 2
        }
    }

    for _, case in ipairs(examples) do
        local matches = countAvailableMatches(generateTilesFromColors(case.colors))
        assert_equal(case.matches, matches)
    end
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
