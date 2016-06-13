module Players

    class Player::Computer < Player

        AI_WIN_COMBOS = [
        [2,5,8], #    # side right
        [0,1,2], #    # side top
        [0,3,6], #    # side left
        [6,7,8], #    # side bottom
        [3,4,5], #    # middle left right
        [1,4,7], #    # middle top down
        [0,4,8], #    # middle top left-bottom right corner
        [2,4,6]] #    # middle top right-bottom left corner

        def move(board)
            board_available_moves = []
            board.cells.each.with_index(1) do |value, index|
              board_available_moves << index if value == " "
            end
            player_move = board_available_moves.sample
            # if win_rule(board_available_moves, board)
            #     win_move = win_rule(board_available_moves, board)
            #     win_move.to_s
            # else
                win_rule(board_available_moves, board)
                puts "Added #{@token} to position #{player_move}."
                player_move.to_s
            # end
        end

        def win_rule(board_available_moves, board)
            token_winning_combo_available = []
            winning_combo_available = []

            board.cells.each.with_index(1) do |value, index|
              token_winning_combo_available << index if value == " " || value == @token
            end

            AI_WIN_COMBOS.each.with_index do |combo, index|
                if 
                token_winning_combo_available.include?(combo[0]+1) && 
                token_winning_combo_available.include?(combo[1]+1) &&
                token_winning_combo_available.include?(combo[2]+1)
                    winning_combo_available << AI_WIN_COMBOS[index]
                end
            end

            # AI_WIN_COMBOS.each.with_index do |combo, index|
            #     if 
            #     board_available_moves.include?(combo[0]+1) && 
            #     board_available_moves.include?(combo[1]+1) &&
            #     board_available_moves.include?(combo[2]+1)
            #         winning_combo_available << AI_WIN_COMBOS[index]
            #     end
            # end
            # binding.pry
            case 
            when winning_combo_available.count == 8
                puts "Win rule: #{@token} has #{winning_combo_available.count} ways to win."
                # false
            when winning_combo_available.count == 7
                puts "Win rule: #{@token} has #{winning_combo_available.count} ways to win."
                # false
            when winning_combo_available.count == 6
                puts "Win rule: #{@token} has #{winning_combo_available.count} ways to win."
                # false
            when winning_combo_available.count == 5
                puts "Win rule: #{@token} has #{winning_combo_available.count} ways to win."
                puts "#{winning_combo_available}"
                # false
            when winning_combo_available.count == 4
                puts "Win rule: #{@token} has #{winning_combo_available.count} ways to win."
                puts "#{winning_combo_available}"
                # false
            when winning_combo_available.count == 3
                puts "Win rule: #{@token} has #{winning_combo_available.count} ways to win."
                puts "#{winning_combo_available}"
                # false
            when winning_combo_available.count == 2
                puts "Win rule: #{@token} has #{winning_combo_available.count} ways to win."
                puts "#{winning_combo_available}"
                # false
            when winning_combo_available.count == 1
                puts "Win rule: #{@token} has #{winning_combo_available.count} way to win."
                puts "#{winning_combo_available}"
                # false
            end

            # board_available_moves.each do |move|
            #     board.cells.each.with_index do |value, index|
            #     end
            # end
        end

        def two_in_a_row(winning_combo_available, board)
            winning_move = []
            winning_combo_available.each do |combo|
                if
                board.cells[combo[0]] == @token &&
                board.cells[combo[1]] == @token &&
                board.cells[combo[2]] == " "
                    winning_move << board.cells[combo[2]]
                elsif
                board.cells[combo[0]] == @token &&
                board.cells[combo[1]] == " " &&
                board.cells[combo[2]] == @token
                    winning_move << board.cells[combo[1]]
                elsif 
                board.cells[combo[0]] == " " &&
                board.cells[combo[1]] == @token &&
                board.cells[combo[2]] == @token
                    winning_move << board.cells[combo[0]]
                end
            end
            # binding.pry
            winning_move

        end

    end

end