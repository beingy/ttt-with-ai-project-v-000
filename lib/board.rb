require 'pry'

class Board
    attr_accessor :cells

    def initialize
        reset!
    end

    def reset!
        @cells = [" "," "," "," "," "," "," "," "," "]
    end

    def display
        puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
        puts "-----------"
        puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
        puts "-----------"
        puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
    end

    def position(user_input)
        @cells[user_input.to_i - 1]
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
        @cells[player_move.to_i - 1] = player.token
    end

end