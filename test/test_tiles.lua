function test_checkMatchesAvailable()
    local examples = {
        { 
            colors = {{ 1, 2, 1, 1, 3, 4, 5, 6}}, 
            matches = 1
        },
        { 
            colors = {{ 2, 3, 2, 2, 1, 4, 1, 1}}, 
            matches = 2
        },
        { 
            colors = {
                { 1, 2, 3, 4, 5, 6, 7, 8},
                { 1, 2, 1, 1, 5, 6, 7, 8},
            }, 
            matches = 1
        },
        { 
            colors = {{ 1, 1, 2, 1, 3, 4, 5, 6}}, 
            matches = 1
        },
        { 
            colors = {
                { 1, 2, 1, 4, 5, 6, 7, 8},
                { 1, 1, 2, 3, 5, 6, 7, 8},
            }, 
            matches = 1
        },
        { 
            colors = {
                { 2, 1, 2, 4, 5, 6, 7, 8},
                { 1, 4, 1, 3, 5, 6, 7, 8},
            }, 
            matches = 1
        },
        { 
            colors = {
                { 2, 3, 2, 4, 5, 6, 1, 8},
                { 2, 4, 1, 3, 5, 1, 7, 1},
            }, 
            matches = 1
        },
        { 
            colors = {
                { 2, 3, 2, 4, 5, 1, 1, 1},
                { 2, 4, 1, 3, 5, 6, 1, 8},
            }, 
            matches = 1
        },
        { 
            colors = {
                { 2, 3, 2, 4, 1, 1, 2, 1},
                { 2, 4, 1, 3, 5, 6, 1, 8},
            }, 
            matches = 2
        },
        { 
            colors = {
                { 1, },
                { 2, },
                { 1, },
                { 1, },
            }, 
            matches = 1
        },
        { 
            colors = {
                { 1, },
                { 1, },
                { 2, },
                { 1, },
            }, 
            matches = 1
        },
        { 
            colors = {
                { 1, 3},
                { 2, 1},
                { 1, 2},
            }, 
            matches = 1
        },
        { 
            colors = {
                { 1, 2},
                { 2, 1},
                { 3, 2},
            }, 
            matches = 1
        },
    }

    for _, case in ipairs(examples) do
        local matches = countAvailableMatches(generateTilesFromColors(case.colors))
        assert_equal(case.matches, matches)
    end
end

function test_checkMatchesFromPoint()
    local examples = {
        -- horizontal left to right
        {
            colors = {{ 1, 2, 1, 1, 3, 4, 5, 6}},
            point = { x= 1, y= 1},
            matches = 0
        },
        {
            colors = {{ 1, 1, 1, 2, 3, 4, 5, 6}},
            point = { x= 1, y= 1},
            matches = 1
        },
        {
            colors = {{ 2, 1, 1, 1, 3, 4, 5, 6}},
            point = { x= 2, y= 1},
            matches = 1
        },
        {
            colors = {{ 2, 2, 2, 2, 1, 1, 1, 5}},
            point = { x= 5, y= 1},
            matches = 1
        },
        {
            colors = {{ 2, 2, 2, 2, 2, 1, 1, 1}},
            point = { x= 6, y= 1},
            matches = 1
        },
        -- horizontal right to left
        {
            colors = {{ 2, 2, 1, 1, 3, 1, 1, 1}},
            point = { x= 8, y= 1},
            matches = 1
        },
        {
            colors = {{ 1, 1, 1, 2, 3, 4, 5, 6}},
            point = { x= 3, y= 1},
            matches = 1
        },
        -- centered horizontal
        {
            colors = {{ 1, 1, 1, 2, 3, 4, 5, 6}},
            point = { x= 2, y= 1},
            matches = 1
        },
        -- combined horizontal
        {
            colors = {{ 2, 2, 1, 1, 1, 1, 1, 1}},
            point = { x= 5, y= 1},
            matches = 3
        },
        {
            colors = {{ 2, 2, 1, 1, 1, 1, 2, 2}},
            point = { x= 5, y= 1},
            matches = 2
        },
        -- vertical top to bottom
        { 
            colors = {
                { 1, },
                { 1, },
                { 1, },
                { 2, },
                { 3, },
                { 4, },
                { 5, },
                { 6, },
            }, 
            point = { x= 1, y= 1},
            matches = 1
        },
        { 
            colors = {
                { 2, },
                { 2, },
                { 2, },
                { 2, },
                { 2, },
                { 2, },
                { 1, },
                { 1, },
            }, 
            point = { x= 1, y= 8},
            matches = 0
        },
        -- vertical bottom to top
        { 
            colors = {
                { 2, },
                { 2, },
                { 2, },
                { 2, },
                { 2, },
                { 1, },
                { 1, },
                { 1, },
            }, 
            point = { x= 1, y= 8},
            matches = 1
        },
        { 
            colors = {
                { 1, },
                { 1, },
                { 1, },
                { 2, },
                { 3, },
                { 4, },
                { 2, },
                { 2, },
            }, 
            point = { x= 1, y= 3},
            matches = 1
        },
        -- centered vertical
        { 
            colors = {
                { 1, },
                { 1, },
                { 1, },
                { 2, },
                { 3, },
                { 4, },
                { 2, },
                { 2, },
            }, 
            point = { x= 1, y= 2},
            matches = 1
        },
        { 
            colors = {
                { 2, },
                { 2, },
                { 2, },
                { 2, },
                { 3, },
                { 1, },
                { 1, },
                { 1, },
            }, 
            point = { x= 1, y= 7},
            matches = 1
        },
    }
   
    for _, case in ipairs(examples) do
        local tiles = generateTilesFromColors(case.colors)
        local matches = countMatchesFromPoint(tiles, case.point)
        assert_equal(matches, 
        case.matches, 
        0, 
        string.format("Expected %d but got %d at %d, %d", case.matches, matches, case.point.x, case.point.y))
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
