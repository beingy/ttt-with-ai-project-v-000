require 'pry'

class Board
    attr_accessor :cells
    # , :moves

    def initialize
        reset!
    end

    def reset!
        @cells = [" "," "," "," "," "," "," "," "," "]
        # @moves = @cells
    end

    # def reset_available_moves
    #     available_moves.clear
    # end

    def display
        puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
        puts "-----------"
        puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
        puts "-----------"
        puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
    end

    # def moves_display
    #     puts "[#{@moves[0]}]|[#{@moves[1]}]|[#{@moves[2]}]"
    #     puts "-----------"
    #     puts "[#{@moves[3]}]|[#{@moves[4]}]|[#{@moves[5]}]"
    #     puts "-----------"
    #     puts "[#{@moves[6]}]|[#{@moves[7]}]|[#{@moves[8]}]"
    # end

    # def available_moves
    #     board_available_moves = []
    #     @cells.each.with_index(1) do |value, index|
    #       board_available_moves << index if value == " "
    #     end
    #     # binding.pry
    #     board_available_moves
    # end

    def position(player_move)
        @cells[player_move.to_i - 1]
    end

    def full?
        @cells.all? { |cell|  cell == "X" || cell == "O" }
    end

    def turn_count
        @cells.count { |cell| cell == "X" || cell == "O" }
    end

    def taken?(player_move)
        position(player_move) == "X" || position(player_move) == "O" ? true : false
    end

    def valid_move?(player_move)
        value_moves = ["1","2","3","4","5","6","7","8","9"]
        value_moves.detect {|move| move == player_move } unless taken?(player_move)
    end

    def update(player_move, player)
        puts "Turn #{turn_count + 1}: #{player.token}'s Turn"
        @cells[player_move.to_i - 1] = player.token
        display
        puts "=============="
    end

end