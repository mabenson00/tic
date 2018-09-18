require_relative 'Player'
class HumanPlayer < Player
  def take_turn
    puts "#{@team}, choose your location. EG A1."
    position = gets.chomp
    check_for_out_of_bounds(position)
    return position
  end
end
