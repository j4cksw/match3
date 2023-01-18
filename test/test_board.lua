function test_checkMatchesAvailable() 
    local board = Board(0, 0, 1)
    assert_boolean(board.checkAvailableMatches())
end