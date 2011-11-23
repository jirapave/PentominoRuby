require_relative "shape"
require_relative "point"

module Pentomino
  #Class represents a reader which can read a file with the defined representation and load shapes.
  #<b>Example representation:<b>
  #<em>type,number:number,number:number.....</em>
  #Number:Number are coordinates of a certain square, type is a name and id for a shape.
  #Note that type should be unique for each shape!
  class ShapesReader
    class << self
      #Method will read a given file a yield each shape which it founds.
      def read_shapes(file_path)
        begin
          file = File.open(file_path, 'r')
          while (line = file.gets)
            line = line.chomp
            data = line.split(",")
            shape = Pentomino::Shape.new(data[0].to_s)
            data.delete_at(0)
            data.each do |x|
              coord = x.split(":")
              shape.add_square(Pentomino::Point.new(coord[0].to_i, coord[1].to_i))
            end
            yield shape
          end
        rescue Errno::ENOENT
        puts "No such file \"#{file_path}\""
        end
      end
    end
  end
end