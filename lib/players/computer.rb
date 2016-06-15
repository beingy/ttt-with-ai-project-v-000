module Players

    class Player::Computer < Player

        def move(board, display_mode = true)

            if check_winning_move(board)
                make_move = make_winning_move(board)
                puts "  #{@token} made winning move to position #{make_move}." if display_mode
                make_move

            elsif check_opponent_winning_move(board)
                make_move = make_blocking_move(board)
                puts "  Blocked #{opponent_token(board)}'s potential winning move at position #{make_move}."  if display_mode
                make_move

            elsif check_corners(board)
                make_move = opposite_corner(board)
                puts "  #{opponent_token(board)} in 1 corner, #{@token} took opposite corner to position #{make_move}." if display_mode
                make_move

            elsif check_potential_opponent_fork(board)
                make_move = take_a_corner_to_draw(board)
                puts "  #{opponent_token(board)} trying to fork, #{@token} force draw by taking a corner at position #{make_move}." if display_mode
                make_move

            elsif available_moves(board).count == 8 # Turn 2 as O token
                if board.cells[4] == opponent_token(board)
                    make_move = ["1","3","7","9"].sample
                    puts "  #{@token} added to position #{make_move}"  if display_mode
                    make_move

                elsif available_moves(board).include?(5)
                    make_move = "5"
                    puts "  #{@token} added to position #{make_move}" if display_mode
                    make_move

                end
            
            elsif available_moves(board).count == 9 # Turn 1 as X token
                make_move = "5"
                puts "  #{@token} makes middle move at position #{make_move}" if display_mode
                make_move

            else
                make_move = available_moves(board).sample
                puts "  #{@token} made random move to position #{make_move}" if display_mode
                make_move

            end
            
            # check_opponent_winning_move
            # check_potential_fork_moves
            # check_opponent_fork_moves
            # play_center_position
            # play_corner_position

        end # => end of #move method

        def available_moves(board)
            collect_positions(" ", board)
        end # => end of #available_moves method

        def collect_positions(token_or_empty, board)
            positions = board.cells.each_index.select { |index| board.cells[index] == token_or_empty }
            positions.collect {|n| (n+1).to_s}
        end # => end of #collect_positions method

        def potential_winning_combos(board)
            Game::WIN_COMBINATIONS.collect { |combo|
                combo.collect {|cell| cell = board.cells[cell]} }
        end # => end of #potential_winning_combos method

        def winning_combos_token_count(board)
            potential_winning_combos(board).collect do |combo| 
                {
                x_count: combo.count { |c| c == "X" }, 
                o_count: combo.count { |c| c == "O" },
                empty_count: combo.count { |c| c == " " }
                }
            end
        end

        def x_winning_combo(board)
            winning_combos_token_count(board).index do |combo| 
                combo[:x_count] == 2 && combo[:empty_count] == 1 
            end
        end

        def o_winning_combo(board)
            winning_combos_token_count(board).index do |combo| 
                combo[:o_count] == 2 && combo[:empty_count] == 1
            end
        end         

        def check_winning_move(board)
            case @token
            when "X"
                x_winning_combo(board)
            when "O"              
                o_winning_combo(board)
            end
        end

        def check_opponent_winning_move(board)
            case @token
            when "X"
                o_winning_combo(board)
            when "O"              
                x_winning_combo(board)
            end
        end


        def find_empty_for_the_win(board)
            Game::WIN_COMBINATIONS[check_winning_move(board)].index { |index| board.cells[index] == " " }
        end

        def find_empty_to_block_win(board)
           Game::WIN_COMBINATIONS[check_opponent_winning_move(board)].index { |index| board.cells[index] == " " } 
        end

        def make_winning_move(board)
            (Game::WIN_COMBINATIONS[check_winning_move(board)][find_empty_for_the_win(board)] + 1).to_s
        end

        def make_blocking_move(board)
            (Game::WIN_COMBINATIONS[check_opponent_winning_move(board)][find_empty_to_block_win(board)] + 1).to_s
        end

        def opponent_token(board)  
            case @token
            when "X"
                "O"
            when "O"             
                "X"
            end 
        end

        def opposite_corner(board)
            corners = ["1","3","7","9"]
            available_corners = available_moves(board).select {|move| corners.include?(move)}
            available_corners[1]
        end

        def check_corners(board)
            corners = ["1","3","7","9"]
            available_corners = available_moves(board).select {|move| corners.include?(move)}
            available_corners.count == 3 ? true : false
        end

        def check_potential_opponent_fork(board)
            corners = ["1","3","7","9"]
            available_corners = available_moves(board).select {|move| corners.include?(move)}
            available_corners.count == 2 ? true : false
        end

        def take_a_corner_to_draw(board)
            corners = ["1","3","7","9"]
            available_corners = available_moves(board).select {|move| corners.include?(move)}
            available_corners.sample
        end

    end # => end of Player::Computer class

end # => Players module

# To-do list:
# 1. check board for available spots. [done]
# 3. check board for potential win combinations and make the winning move. [done]
# 4. check board for potential opponent win combinations and block opponent's potential winning combination.
# 5. create fork win
# 5a. Turn 1: X plays middle "5"
# 5a1.Turn 2: O plays corner ["1","3","7","9"].sample, example "1"
#      board.cells = ["O"," "," "," ","X"," "," "," "," "]
# 5a2.Turn 3: X plays opposite corner of O, "9" 
# always take a corner if no winning move
# 6. block opponent fork win