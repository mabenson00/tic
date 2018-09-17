class Game
  attr_reader :board
  def initialize
    @board = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    @computer = false
    @complete = false
    @open = ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"]
  end

  def play_game
    choose_your_player
    print_board
    take_turn
  end

  def duplicate(obj) ## when I did board = @board.dup it still referenced @board, and changed it when i was trying to print
   Marshal::load(Marshal.dump(obj))
  end

  def find_row(letter)
    alpha_table = {}
    (('A'..'Z').zip(0..25)).each { |x| alpha_table[x[0]] = x[1] }
    @board[alpha_table[letter]]
  end

  def find_spot(position)
    row = find_row(position[0])
    pos = (position[1].to_i) -1
    if row[pos] == nil
      row[pos] = @turn
    else
      p "that spot is already taken"
      take_turn
    end
    print_board
  end

  def check_for_out_of_bounds(position)
    if position[0] != "A" && position[0] !="B" && position[0] !="C"
      p "you put an invalid space"
      take_turn
    elsif position[1] != "1" && position[1] !="2" && position[1] !="3"
      p "you put an invalid space"
      take_turn
    end
  end

  def check_for_winner
    board = duplicate(@board)
    check_for_horizontal(board)
    check_for_vertical(board)
    check_for_diagonal(board)
  end

  def check_for_horizontal(board)
    board.each do |row|
      if row.uniq.length == 1 && row[0] == ("x" || "o")
        @complete = true
      end
    end
  end

  def check_for_vertical(board)
    board = board.transpose
    check_for_horizontal(board)
  end

  def check_for_diagonal(board)
      board.each_with_index do |row, i|
        row.rotate!(i)
      end
      check_for_vertical(board)
  end

  def take_turn
    until @complete
      if (@turn == @player2) && @computer
        position = @open.sample(1)[0]
        p "computer chooses #{position}"
      else
        puts "#{@turn}, choose your location. EG A1."
        position = gets.chomp
        check_for_out_of_bounds(position)
      end
      find_spot(position)
      @open -= [position]
      check_for_winner
      @turn == @player1? @turn = @player2 : @turn = @player1
      take_turn
    end
    p "#{@turn} wins!"
  end

  def print_board
    letter = "A"
    p " 1 2 3"
    board = duplicate(@board)
    board.each do |row|
      row.unshift(letter)
      p row.join("|")
      letter.next!
    end
  end

  def choose_your_player
   puts "Player 1: Choose X or O"
   until @player1 == "x" || @player1 == "o"
     @player1 = gets.chomp.downcase
     if @player1 != "x" && @player1 != "o"
       puts "you didn't put x or o"
     end
   end
   puts "ok! player 1 is #{@player1}!"
   @turn = @player1
   get_second_player
   puts "thanks!"
  end

  def get_second_player
    puts "Do you want to play against another humanw? y/n"
    until @human == "y" || @human == "n"
      @human = gets.chomp.downcase
      if @human != "y" && @human != "n"
        puts "you didn't put y or n"
      end
    end
    if @human == "y"
      (@player2 = (["x", "o"] -[@player1])[0])
      puts "ok! player 2 is #{@player2}"
    elsif @human == "n"
      @player2 = ((["x", "o"] - [@player1])[0]) ## could make a model for player, with the trait "human?" but not using for the board.
      @computer = true
      puts "ok! the computer is #{@player2}"
    end
  end

end
game = Game.new
game.play_game
