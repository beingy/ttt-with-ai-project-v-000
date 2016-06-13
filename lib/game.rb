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
        else
            turn
        end
    end

    def play
        until over?
            turn
        end
        if won?
            puts "Congratulations #{winner}!" 
        elsif draw?
            puts "Cats Game!"
        end
    end

    def play_again?
        print "Play again? [Yes/No]: "
        again_input = gets.chomp.downcase
        if again_input == "n" || again_input == "no"
            puts "=========="
            "Good bye, Human!\n".each_char do |c|
                sleep 0.1
                print c
            end
            exit # => exit game
        end
    end

    def start

        command_user_input = ""

        # Start TTT CLI while loop

        while command_user_input != "exit" do
            puts "======================="
            "Welcome to Tic Tac Toe!\n".each_char do |c|
              sleep 0.1
              print c
            end
            puts "======================="
            puts "Please select type of game to play: ('bye' to exit)"
            puts "[0] 0 Player Game"
            puts "[1] 1 Player Game"
            puts "[2] 2 Player Game"
            puts "[3] Wargames"
            print "Command: "
            command_user_input = gets.chomp.downcase

            # Start TTT case user_input

            case

            # Start 0 Player Game command

            when command_user_input == "0"
                puts "=========="
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

            # Start 1 Player Game command

            when command_user_input == "1"
                puts "=========="
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

            # Start 2 Player Game command

            when command_user_input == "2"
                puts "=========="
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
                        puts "Player 1, You won!"
                    elsif game.winner == "O"
                        puts "Player 2, You won!"
                    elsif game.draw?
                        puts "Draw!"
                    end
                    play_again?
                when "2"
                    player_1 = Player::Human.new("O")
                    player_2 = Player::Human.new("X")
                    game = Game.new(player_2,player_1)
                    game.play
                    if game.winner == "X"
                        puts "Player 2, You won!"
                    elsif game.winner == "O"
                        puts "Player 1, You won!"
                    elsif game.draw?
                        puts "Draw!"
                    end
                    play_again?
                
                end # => case user_input

            # End 2 Player Game command

            # Start Wargames commmand

            when command_user_input == "3" || command_user_input == "wargames"
                "Wargames commencing...\n".each_char do |c|
                          sleep 0.1
                          print c
                        end
                puts "Who should go first and be X, Player 1 or Player 2?"
                print "[1] or [2]: "
                user_input = gets.chomp

                case user_input # start Wargames case user_input

                # Player 1 AI play X

                when "1"
                    player_1_wins = 0
                    player_2_wins = 0
                    draws = 0
                    100.times do
                        player_1 = Player::Computer.new("X")
                        player_2 = Player::Computer.new("O")
                        game = Game.new(player_1,player_2)
                        game.play
                        if game.winner == "X"
                            puts "Player 1 AI won!"
                            player_1_wins += 1
                        elsif game.winner == "O"
                            puts "Player 2 AI won!"
                            player_2_wins += 1
                        elsif game.draw?
                            puts "Draw!"
                            draws += 1
                        end
                    end
                    puts "Out of 100 games played:"
                    puts "Player 1 AI won #{player_1_wins} games,"
                    puts "Player 2 AI won #{player_2_wins} games,"
                    puts "and #{draws} draws."
                    play_again?

                # end Player 1 AI play X

                # Player 2 AI play X

                when "2"
                    player_1_wins = 0
                    player_2_wins = 0
                    draws = 0
                    100.times do
                        player_1 = Player::Computer.new("O")
                        player_2 = Player::Computer.new("X")
                        game = Game.new(player_2,player_1)
                        game.display
                        game.play
                        if game.winner == "X"
                            puts "Player 2 AI won!"
                            player_2_wins += 1
                        elsif game.winner == "O"
                            puts "Player 1 AI won!"
                            player_1_wins += 1
                        elsif game.draw?
                            puts "Draw!"
                            draws += 1
                        end
                    end

                    puts "Out of 100 games played:"
                    puts "Player 1 AI won #{player_1_wins} games,"
                    puts "Player 2 AI won #{player_2_wins} games,"
                    puts "and #{draws} draws."
                    play_again?

                # End Player 2 AI play X

                end # => end Wargames case user_input

            # End Wargames command
            
            # Exit commmand

            when command_user_input == "bye" || command_user_input == "quit"
                puts "=========="
                "Good bye, Human!\n".each_char do |c|
                    sleep 0.1
                    print c
                end        
                command_user_input = "exit" # => exit game

            # End Exit command

            else
                puts "=========="
                puts "Your command is invalid.  Please try again."

            end # => end TTT case user_input

        end # => end TTT CLI while loop

    end # => end TTT #start method

end # => end Game Class