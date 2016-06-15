class Game
    attr_accessor :board, :player_1, :player_2

    WIN_COMBINATIONS = [
        [0,1,2], 
        [3,4,5], 
        [6,7,8],
        [0,3,6], 
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]]

    def initialize(
            player_1 = Player::Human.new("X"),
            player_2 = Player::Human.new("O"), 
            board = Board.new)
        @player_1 = player_1
        @player_2 = player_2
        @board = board
    end

    def current_player
        @board.turn_count % 2 == 0 ? @player_1 : @player_2
    end

    def over?
        true if won? || draw?
    end

    def won?
        WIN_COMBINATIONS.detect do |combo| (
            @board.cells[combo[0]] == @player_1.token &&
            @board.cells[combo[1]] == @player_1.token &&
            @board.cells[combo[2]] == @player_1.token ) || (
            @board.cells[combo[0]] == @player_2.token &&
            @board.cells[combo[1]] == @player_2.token &&
            @board.cells[combo[2]] == @player_2.token )
        end
    end

    def draw?
        true if board.full? && !won?
    end

    def winner
        board.cells[won?[0]] if won?
    end

    def turn
        player_move = current_player.move(board)
        if board.valid_move?(player_move)
            board.update(player_move, current_player)
            board.display
            puts "========================================="
        else
            turn
        end
    end

    def play
        turn until over?
        if won?
            puts "  Congratulations #{winner}!" 
        elsif draw?
            puts "  Cats Game!"
        end
    end

    def wargames_turn
        display_mode = false
        player_move = current_player.move(board, display_mode)
        if board.valid_move?(player_move)
            board.update(player_move, current_player, display_mode)
        else
            wargames_turn
        end
    end

    def wargames_play
        wargames_turn until over?
    end

    def play_again?
        print "Play again? [Yes/No]: "
        again_input = gets.chomp.downcase
        if again_input == "n" || again_input == "no"
            puts "========================================="
            puts "Good bye, Human!"
            # "Good bye, Human!\n".each_char do |c|
            #     sleep 0.1
            #     print c
            # end
            exit # => exit game
        end
    end

    def start_menu
            puts "     " + ".-----------------------------."
            puts "     " + "|   Welcome to Tic Tac Toe!   |"
            # "Welcome to Tic Tac Toe!\n".each_char do |c|
            #   sleep 0.1
            #   print c
            # end
            puts "     " + ":_____________________________:"
            puts "Please select type of game to play: ('bye' to exit)"
            puts "[0] 0 Player Game"
            puts "[1] 1 Player Game"
            puts "[2] 2 Player Game"
            puts "[3] Wargames"
            print "Command: "
    end

    def switch_on?(feature)
        if feature == "y" || feature == "yes"
            true
        elsif feature = "n" || feature == "no"
            false
        end
    end

    def start
        command_user_input = ""

        while command_user_input != "exit" do # Start TTT CLI while loop
            start_menu #display start menu
            command_user_input = gets.chomp.downcase

            case # Start TTT case user_input
            when command_user_input == "0" # Start 0 Player Game command
                puts "========================================="
                puts "Who should go first and be X, Player 1 or Player 2?"
                print "[1] or [2]: "
                user_input = gets.chomp

                case user_input
                when "1"
                    player_1 = Player::Computer.new("X")
                    player_2 = Player::Computer.new("O")
                    game = Game.new(player_1,player_2)
                    game.play
                    if game.winner == "X"
                        puts "Player 1 AI won!"
                    elsif game.winner == "O"
                        puts "Player 2 AI won!"
                    elsif game.draw?
                        puts "Draw!"
                    end
                    play_again?

                when "2"
                    player_1 = Player::Computer.new("O")
                    player_2 = Player::Computer.new("X")
                    game = Game.new(player_2,player_1)
                    game.play
                    if game.winner == "X"
                        puts "Player 2 AI won!"
                    elsif game.winner == "O"
                        puts "Player 1 AI won!"
                    elsif game.draw?
                        puts "Draw!"
                    end
                    play_again?

                end # => case user_input
                # End 0 Player Game command

            when command_user_input == "1" # Start 1 Player Game command
                puts "========================================="
                puts "Who should go first and be X, Player 1 or Player 2?"
                print "[1] or [2]: "
                user_input = gets.chomp
                
                case user_input
                when "1"
                    player_1 = Player::Human.new("X")
                    player_2 = Player::Computer.new("O")
                    game = Game.new(player_1,player_2)
                    game.play
                    if game.winner == "X"
                        puts "Player 1, You won!"
                    elsif game.winner == "O"
                        puts "Player 2 AI won!"
                    elsif game.draw?
                        puts "Draw!"
                    end
                    play_again?

                when "2"
                    player_1 = Player::Human.new("O")
                    player_2 = Player::Computer.new("X")
                    game = Game.new(player_2,player_1)
                    game.play
                    if game.winner == "X"
                        puts "Player 2 AI won!"
                    elsif game.winner == "O"
                        puts "Player 1, You won!"
                    end
                    play_again?

                end # => case user_input 
                # End 1 Player Game command

            when command_user_input == "2" # Start 2 Player Game command
                puts "========================================="
                puts "Who should go first and be X, Player 1 or Player 2?"
                print "[1] or [2]: "
                user_input = gets.chomp

                case user_input
                when "1"
                    player_1 = Player::Human.new("X")
                    player_2 = Player::Human.new("O")
                    game = Game.new(player_1,player_2)
                    game.play
                    if game.winner == "X"
                        puts "  Player 1, You won!"
                    elsif game.winner == "O"
                        puts "  Player 2, You won!"
                    elsif game.draw?
                        puts "  Draw!"
                    end
                    play_again?

                when "2"
                    player_1 = Player::Human.new("O")
                    player_2 = Player::Human.new("X")
                    game = Game.new(player_2,player_1)
                    game.play
                    if game.winner == "X"
                        puts "  Player 2, You won!"
                    elsif game.winner == "O"
                        puts "  Player 1, You won!"
                    elsif game.draw?
                        puts "  Draw!"
                    end
                    play_again?
                
                end # => case user_input
                # End 2 Player Game command

# Start Wargames commmand

            when command_user_input == "3" || command_user_input == "wargames" 
                puts "========================================="
                "Starting simulation...\n".each_char do |c|
                    sleep 0.1
                    print c
                end
                reps = 100
                puts "Who should go first and be X, AI Player 1 or AI Player 2?"
                print "[1] or [2]: "
                user_input = gets.chomp
                puts "Display all #{reps} games?"
                print "[Y]es or [N]o? "
                display_mode = gets.chomp.downcase

                case user_input # start Wargames case user_input
                when "1" # Player 1 AI play X
                    player_1_wins = 0
                    player_2_wins = 0
                    draws = 0
                    rep_counter = 1
                    wargames_start_time = Time.now
                    reps.times do
                        puts "Game #{rep_counter}:" if switch_on?(display_mode)
                        player_1 = Player::Computer.new("X")
                        player_2 = Player::Computer.new("O")
                        game = Game.new(player_1,player_2)
                        switch_on?(display_mode) ? game.play : game.wargames_play
                        if game.winner == "X"
                            puts "  Player 1 AI won!" if switch_on?(display_mode)
                            player_1_wins += 1
                        elsif game.winner == "O"
                            puts "  Player 2 AI won!" if switch_on?(display_mode)
                            player_2_wins += 1
                        elsif game.draw?
                            puts "  Draw!" if switch_on?(display_mode)
                            draws += 1
                        end
                        rep_counter += 1
                    end
                    wargames_end_time = Time.now
                    wargames_time_elapse = wargames_end_time - wargames_start_time

                    p1_win_percent = player_1_wins * 100.0 / reps
                    p2_win_percent = player_2_wins * 100.0 / reps
                    draws_percent = draws * 100.0 / reps

                    puts "========================================="
                    puts "Simulation report for #{reps} games played:"
                    puts "AI Player 1 won #{player_1_wins} games (#{p1_win_percent}% win rate),"
                    puts "AI Player 2 won #{player_2_wins} games (#{p2_win_percent}% win rate),"
                    puts "and #{draws} draws (#{draws_percent}% draw rate)."
                    puts "Simulation completed in #{wargames_time_elapse} seconds."
                    puts "========================================="
                    play_again? 
                    # end of Player 1 AI play X

                when "2" # Player 2 AI play X
                    player_1_wins = 0
                    player_2_wins = 0
                    draws = 0
                    rep_counter = 1
                    wargames_start_time = Time.now
                    reps.times do
                        puts "Game #{rep_counter}:" if switch_on?(display_mode)
                        player_1 = Player::Computer.new("O")
                        player_2 = Player::Computer.new("X")
                        game = Game.new(player_2,player_1)
                        switch_on?(display_mode) ? game.play : game.wargames_play
                        if game.winner == "X"
                            puts "  Player 2 AI won!" if switch_on?(display_mode)
                            player_2_wins += 1
                        elsif game.winner == "O"
                            puts "  Player 1 AI won!" if switch_on?(display_mode)
                            player_1_wins += 1
                        elsif game.draw?
                            puts "  Draw!" if switch_on?(display_mode)
                            draws += 1
                        end
                    end
                    wargames_end_time = Time.now
                    wargames_time_elapse = wargames_end_time - wargames_start_time

                    p1_win_percent = player_1_wins * 100.0 / reps
                    p2_win_percent = player_2_wins * 100.0 / reps
                    draws_percent = draws * 100.0 / reps

                    puts "========================================="
                    puts "Simulation report for #{reps} games played:"
                    puts "AI Player 1 won #{player_1_wins} games (#{p1_win_percent}% win rate),"
                    puts "AI Player 2 won #{player_2_wins} games (#{p2_win_percent}% win rate),"
                    puts "and #{draws} draws (#{draws_percent}% draw rate)."
                    puts "Simulation completed in #{wargames_time_elapse} seconds."
                    puts "========================================="
                    play_again?
                    # End Player 2 AI play X

                end # => end Wargames case user_input
            # End Wargames command
            
            # Exit commmand
            when command_user_input == "bye" || command_user_input == "quit" || command_user_input == "exit"
                puts "========================================="
                puts "Good bye, Human!"
                # "Good bye, Human!\n".each_char do |c|
                #     sleep 0.1
                #     print c
                # end        
                command_user_input = "exit" # => exit game
            # End Exit command

            else
                puts "========================================="
                puts "Your command is invalid.  Please try again."

            end # => end TTT case user_input

        end # => end TTT CLI while loop

    end # => end TTT #start method

end # => end Game Class