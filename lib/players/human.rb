module Players

    class Player::Human < Player

        def move(board)
            # board.available_moves.each.with_index do |value, index|
            #     board.moves[index] = value.to_s
            # end
            # board.moves_display
            # binding.pry
            board.display if board.turn_count == 0
            print "Where do you want to place your #{@token}: "
            user_input = gets.chomp
            # board.reset_available_moves
            # board.moves = [" "," "," "," "," "," "," "," "," "]
        end

    end

end