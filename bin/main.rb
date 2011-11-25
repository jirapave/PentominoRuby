lib_dir = File.dirname($0) + '/../lib/'
unless $:.include?(lib_dir) || $:.include?(File.expand_path(lib_dir))
$:.unshift(File.expand_path(lib_dir))
end

require "pentomino/solver"
puts "Enter width of a desk:"
width = gets.chomp.to_i
puts "Enter height of a desk:"
height = gets.chomp.to_i
puts "Enter \"default\" for default pentomino shapes or path to a file with defined shapes:"
file = gets.chomp
solver = Pentomino::Solver.new(width,height)
if file == "default"
  solver.solve_with_basic_shapes
else
  solver.solve_with_own_shapes(file)
end



#629 612 iterations needed
#solver = Pentomino::Solver.new(15,4)
#2 813 iterations needed
#solver = Pentomino::Solver.new(10,6)
#3 809 iterations needed
#solver = Pentomino::Solver.new(12,5)
#solver.solve_with_basic_shapes

#Own shapes, currently squares
#solver = Pentomino::Solver.new(2,2)
#file_path = "own_shapes.txt"
#app_root = File.expand_path(File.dirname(__FILE__))
#result_file = File.join(app_root, file_path)
#solver.solve_with_own_shapes(result_file)

#Own shapes, two shapes, L from 3 squares and I from 2 squares
#solver = Pentomino::Solver.new(2,3)
#file_path = "other_shapes.txt"
#app_root = File.expand_path(File.dirname(__FILE__))
#result_file = File.join(app_root, file_path)
#solver.solve_with_own_shapes(result_file)