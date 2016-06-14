module Players

    class Player::Computer < Player

        def move(board)

            if check_winning_move(board)
                make_move = make_winning_move(board)
                puts "Make #{@token} winning move to position #{make_move}."
                make_move

            elsif check_opponent_winning_move(board)
                make_move = make_blocking_move(board)
                puts "Block #{opponent_token(board)}'s potential winning move at position #{make_move}."
                make_move

            elsif available_moves(board).count == 9 # Turn 1 as X token
                make_move = "5"
                puts "#{@token} makes middle move at position #{make_move}"
                make_move

            elsif available_moves(board).count == 8 # Turn 1 as O token
                make_move = ["1","3","7","9"].sample if available_moves(board).include?(5)
                make_move = "5" if !available_moves(board).include?(5)
                puts "#{@token} makes move at position #{make_move}"
                make_move

            else
                make_move = available_moves(board).sample
                puts "Make random #{@token} move to position #{make_move}"
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
        end # => end of #collect_position method

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

    end # => end of Player::Computer class

end # => Players module

# To-do list:
# 1. check board for available spots. [done]
# 3. check board for potential win combinations and make the winning move. [done]
# 4. check board for potential opponent win combinations and block opponent's potential winning combination.
# 5. create fork win
# 5a. Turn 1: 1st move: middle "5"
# 5a1.Turn 2: If opponent plays middle
# 5a2.Turn 3: Play 
# 6. block opponent fork win