module Players

    class Player::Computer < Player

        def move(board)
            board_available_moves = []
            board.cells.each.with_index(1) do |value, index|
              board_available_moves << index if value == " "
            end
            player_move = board_available_moves.sample
            player_move.to_s
        end
        
    end

end