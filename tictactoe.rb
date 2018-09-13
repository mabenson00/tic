class Game
  attr_reader :board
  def initialize
    # Instance variables
    @board = [[nil,nil,nil], [nil,nil,nil], [nil,nil,nil]]
  end

  def play_game
    print_board
  end

  # def set_up_board
  #   ## two options: all nil, add when there's an element || or put the space IDs in, but don't print them. and just find and replace.
  #   # thought about using a db, but array of arrays seemed to make more sense, and there was nothing about saving results.
  #   # what would the models be? the board has spaces, the spaces have letters that correspond to what you'd guess?
  #   # and then a player field. but then you'd have to print/algorithm it by doing some fancy math or just putting it in an array.
  # end

  def print_board
    letter = "A"
    p " 1 2 3"
    board = @board.dup
    board.each do |row|
      row.unshift(letter)
      p row.join(" |")[0..-2]
      letter.next!
    end
  end

  def choose_your_player
   puts "Player 1: Choose X or O (X goes first)"
   puts" you didnt choose x or o, try again" while (@player1 = gets.chomp) != ("x" || "o")
   puts "ok! player 1 is #{@player1}!"
   get_second_player
   puts "thanks!"
  end

  def get_second_player
    puts "Do you want to play against a computer? Y/N"
    puts" you didnt choose Y or N, try again" while (human = gets.chomp) != ("y" || "n")
    if human = "y"
      (@player2 = ["x", "o"] -[@player1]).to_s
      puts "ok! player 2 is #{@player2}"
    elsif human= "n"
      @computer = (["x", "o"] - [@player1]).to_s ## could make a model for player, with the trait "human?" but not using for the board.
      puts "ok! the computer is #{@computer}"
    end
  end

end
game = Game.new
game.play_game
p game.board
