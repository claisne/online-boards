require "./online_boards/checkers/*"

board = Checkers::Board.new_starting_position()

color = Checkers::Color::White
moves = board.moves(color)
while !moves.empty?
  color = color.opponent()
  board.apply_move(moves.sample(1).shift)
  moves = board.moves(color)
  puts board
  puts
end
