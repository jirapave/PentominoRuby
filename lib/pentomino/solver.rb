require_relative "shapes_manager"
require_relative "desk"

module Pentomino
  #Class represents a solver for a given desk and shapes. It uses Depth-First Search algorithm
  #where desk represents one configuration. In each iteration, desk is popped from stack, all
  #shapes are inserted on a desk if it does not containt that type of shape a those newly created
  #desks are placed on stack.
  class Solver
    attr_reader :result
    #When initialized, dimension of desk has to be specified
    def initialize(width, height)
      @base_desk = Pentomino::Desk.new(width,height)
      @shapes_man = Pentomino::ShapesManager.new
      @stack = []
      @result = nil
    end
    
    #Method provides a way to dynamically change a desk.
    def create_new_desk(width, height)
      @base_desk = Pentomino::Desk.new(width,height)
    end
    
    #Helper method to print all loaded shapes in this solver.
    def print_loaded_shapes()
      file_path = "basic_shapes.txt"
      app_root = File.expand_path(File.dirname(__FILE__))
      @shapes_man.generate_shapes(File.join(app_root, file_path))
      @shapes_man.shapes.each do |key, shape|
        desk = Pentomino::Desk.new(10,10)
        desk.free_point = Pentomino::Point.new(4,4)
        desk.insert_shape(shape)
        desk.print_desk
      end
    end
    
    #Method will try to solve a given desk with the basic Pentomino shapes:
    #http://cs.wikipedia.org/wiki/Pentomino#Pentominov.C3.A9_.C3.BAtvary
    def solve_with_basic_shapes()
      file_path = "basic_shapes.txt"
      app_root = File.expand_path(File.dirname(__FILE__))
      @shapes_man.generate_shapes(File.join(app_root, file_path))
      solve()
    end
    
    #Method will try to solve a given desk with shapes loaded from a given file
    def solve_with_own_shapes(file_path)
      @shapes_man.generate_shapes(file_path)
      solve()
    end
    
    #Helper method to print all the loaded shapes
    def print_current_shapes()
      puts @shapes_man.shapes.inspect
    end
    
    #Method will print result.
    def print_result()
      if @result == nil
        puts "There is no result to print"
        return false
      else
        @result.print
      end
    end
    
    #Returns true if a result was found or false if not.
    def result?()
      return false if result == nil
      return true
    end
    
    private
    #Method will find a solution to the given desk and shapes if it exist. Algorithm is using DFS search where
    #configuration is a desk.
    def solve()
      iterations = 0
      puts "Computing solution..."
      @stack.push @base_desk
      solution_found = false
      while @stack.length != 0 and solution_found == false
        desk = @stack.pop
        iterations += 1
        if desk.solved?
          solution_found = true
          @result = desk
          break
        else
          @shapes_man.shapes.each do |key, shape|
            #TODO zatim nefunguje, podminka neni nikdy splnena
            if !desk.contain_shape?(shape) and desk.shape_fits?(shape)
              desk_to_stack = desk.copy
              desk_to_stack.insert_shape(shape)
              @stack.push(desk_to_stack)
            end
          end
        end
        #puts "iterace: #{iterations}, stack: #{@stack.length}"
      end
      puts "Pocet iteraci: #{iterations}"
      if solution_found
        puts "Solution found:"
        @result.print_desk
      else
        puts "Solution for the given desk doesn't exist"
      end
    end
  end
end