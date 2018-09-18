require_relative 'player'
require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'
require 'pry'
class Game
  attr_accessor :board, :player

  def initialize
    @board = Board.new
    @turn = 0
    @number_of_players = 0
    @players = []
    @complete
  end

  def play_game
    how_many_players
    get_player_one
    get_player_two
    take_turns
  end

  def current_team
    @players[@turn%2]
  end

  def check_for_complete
    if @board.complete
      @complete = true
      p "#{current_team.team} wins!!"
      play_again
    elsif @turn == 8
      @complete = true
      p "its a draw"
      play_again
    end
  end

  def play_again
    p "enter Y to play again, anything else to exit"
    play_again = gets.chomp
    if play_again == "Y"
      clear_board
      take_turns
    end
  end

  def clear_board ## keep teams, restart game
    @board = Board.new
    @turn = 0
    @complete = false
    @players.each{|p| p.restart} ## reset open spaces
  end


  def take_turns
    until @complete
      check_turn
    end
  end

  def check_turn
    position = current_team.take_turn
    if @board.find_spot(position, current_team.team)
      check_for_complete
      @players.each{|p| p.remove_position(position)}
      @turn +=1
    else
      check_turn
    end
  end

  def how_many_players
    puts "1 or 2 players?"
    until @number_of_players == "1" || @number_of_players == "2"
      @number_of_players = gets.chomp.downcase
      if @number_of_players != "1" && @number_of_players != "2"
        puts "you didn't put 1 or 2"
      end
    end
    puts "ok! #{@number_of_players} players!"
    @number_of_players = @number_of_players.to_i
  end

  def get_player_one
    puts "Player 1, Choose X or O"
    until @player1 == "x" || @player1 == "o"
      @player1 = gets.chomp.downcase
      if @player1 != "x" && @player1 != "o"
        puts "you didn't put x or o"
      end
    end
    puts "ok! player 1 is #{@player1}!"
    @players+=[HumanPlayer.new(@player1, @board)]
  end

  def get_player_two
    if @number_of_players == 1 && @players[0].team == "x"
      @players+=[ComputerPlayer.new("o", @board)]
    elsif @number_of_players == 1 && @players[0].team == "o"
      @players+=[ComputerPlayer.new("x", @board)]
    elsif @number_of_players == 2 && @players[0].team == "o"
      @players+=[HumanPlayer.new("x", @board)]
    else
      @players+=[HumanPlayer.new("o", @board)]
    end
  end

end
game = Game.new
game.play_game
