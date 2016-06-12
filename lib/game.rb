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
        # binding.pry
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

end