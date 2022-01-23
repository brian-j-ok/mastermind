# Game Class
class Game
  COLORS = %w[RED GREEN BLUE YELLOW BROWN ORANGE BLACK WHITE].freeze
  @board_array = Array.new(4) { COLORS[rand(8)] }

  def initialize
    puts 'Hello, what is your name?'
    temp_name = gets.chomp
    @player = Player.new(temp_name)
    create_board
    play
  end

  def create_board
    @board_array = Array.new(4) { COLORS[rand(8)] }
    puts @board_array
  end

  def play
    turn_number = 0
    while turn_number < 2
      puts "#{@player.name}, please select your four colors in order."
      temp_guess_arr = gets.chomp.split
      if check_guess(temp_guess_arr)
        break
      end

      turn_number += 1
    end

    puts "#{@player.name}, you took too many turns and lost. Would you like to play again?"
    if gets.chomp == "YES"
      create_board
      play
    end
  end

  def check_guess(guess_arr)
    if (guess_arr <=> @board_array).zero?
      puts 'You got it!'
      true
    else
      puts evaluate_guess(guess_arr)
      false
    end
  end

  def evaluate_guess(guess_arr)
    evaluated_guess_arr = [0, 0, 0]
    guess_arr.each_with_index do |guess, index|
      if @board_array[index] == guess
        evaluated_guess_arr[0] += 1
      elsif @board_array.include?(guess)
        evaluated_guess_arr[1] += 1
      else
        evaluated_guess_arr[2] += 1
      end
    end
    "#{evaluated_guess_arr[0]} exact; #{evaluated_guess_arr[1]} correct color; #{evaluated_guess_arr[2]} nothing"
  end
end

# Player Class
class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

Game.new