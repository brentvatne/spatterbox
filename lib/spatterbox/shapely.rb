module Shapely
  module Shapes
    class Shape
      # A circle has a side_length of 0, this is dealt with in the
      # number_of_sides macro
      attr_accessor :side_length

      # Polygons also have a radius! I mostly just did this part
      # for fun, and because it makes sense according to the object model
      attr_accessor :radius

      def initialize(measure)
        if sides == :infinite
          self.radius = measure
        else
          self.side_length = measure
        end
      end

      def self.number_of_sides(n)
        # Class method to return number of sides
        define_singleton_method(:sides) { n }

        # Instance method, same as above (for convenience)
        define_method(:sides) { self.class.sides }

        if n == :infinite
          define_method(:side_length) { 0 }
          define_method(:primary_measurement_name) { "radius" }
          define_method(:primary_measurement) { self.radius }
        else
          define_method(:radius) {
            side_length / (2 * Math.sin(Math.pi / sides))
          }
          define_method(:primary_measurement_name) { "side length" }
          define_method(:primary_measurement) { self.side_length }
        end
      end
    end

    class Triangle < Shape
      number_of_sides 3
    end

    class Square < Shape
      number_of_sides 4
    end

    class Pentagon < Shape
      number_of_sides 5
    end

    class Circle < Shape
      number_of_sides :infinite
    end
  end

  class Calculator
    def self.perimeter_of(shape)
      if shape.sides == :infinite
        Math::PI * (shape.radius * 2)
      else
        shape.sides * shape.side_length
      end
    end

    def self.area_of(shape)
      if shape.sides == :infinite
        Math::PI * shape.radius**2
      else
        numerator   = shape.side_length**2 * shape.sides
        denominator = 4 * (Math.tan(Math::PI / shape.sides))

        numerator / denominator
      end
    end
  end

  class CsvReader
    attr_reader :output_stream

    def initialize(output_stream = STDOUT)
      @output_stream = output_stream
    end

    def load(csv_string)
      @csv_string = csv_string
      self
    end

    def print_formatted_output
      each_entry do |name, measurement|
        shape = new_shape(name, measurement.to_f)

        puts "A #{shape_name(shape)} " +
             "with #{shape.primary_measurement_name} #{two_decimals(shape.primary_measurement)} u " +
             "has a perimeter of #{two_decimals(Calculator.perimeter_of(shape))} u " +
             "and an area of #{two_decimals(Calculator.area_of(shape))} u^2"
      end
    end

    def two_decimals(number)
      "%0.02f" % number
    end

    def shape_name(shape)
      shape.class.to_s.split("::").last.downcase
    end

    def new_shape(name, measurement)
      Shapes::const_get(name.capitalize).new(measurement)
    end

    def each_entry
      @csv_string.split("\n").each do |entry|
        yield entry.split(",")
      end
    end

    def puts(str)
      @output_stream.puts str
    end
  end
end
