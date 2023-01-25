function test_swap()
    local expected = generateTilesFromColors({{1, 2}})
    local actual = swap(generateTilesFromColors({{2, 1}}), {x=1, y=1}, {x=2, y=1})
    assert_tiles_equals(expected, actual)
end

function assert_tiles_equals(tiles1, tiles2)
    for y = 1, #tiles1 do
        for x = 1, #tiles1[y] do
            assert_equal(tiles1[y][x].color, tiles2[y][x].color, 0, 
                string.format("at %d, %d is not equal.", x, y))
        end
    end
end

function assert_tile_grid_position(tile, x, y)
    assert_equal(tile.gridX, x, 0, string.format("expected gridX=%d at %d, %d.", tile.gridX, x, y))
    assert_equal(tile.gridY, y, 0, string.format("expected gridy=%d at %d, %d.", tile.gridY, x, y))
end