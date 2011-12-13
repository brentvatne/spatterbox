# Obligatory trendy startup name
describe Shapely do
  describe Shapely::Shapes do
    describe Shapely::Shapes::Triangle do
      it "has three sides" do
        Shapely::Shapes::Triangle.sides.should == 3
        new_triangle.sides.should == 3
      end

      it "should set side_length on initialize" do
        new_triangle(3).side_length.should == 3
      end
    end

    describe Shapely::Shapes::Square do
      it "has four sides" do
        Shapely::Shapes::Square.sides.should == 4
        new_square.sides.should == 4
      end
    end

    describe Shapely::Shapes::Pentagon do
      it "has four sides" do
        Shapely::Shapes::Pentagon.sides.should == 5
        new_pentagon.sides.should == 5
      end
    end

    describe Shapely::Shapes::Circle do
      it "has infinite sides" do
        Shapely::Shapes::Circle.sides.should == :infinite
        new_circle.sides.should == :infinite
      end

      it "should have 0 length for sides and side_length should be immutable" do
        circle = new_circle
        circle.side_length.should == 0
      end
    end
  end

  describe Shapely::Calculator do
    let(:triangle) { Shapely::Shapes::Triangle.new(3.5) }
    let(:triangles_perimeter) { 10.5 }
    let(:triangles_area) { 5.304405598179688 }
    let(:circle) { Shapely::Shapes::Circle.new(2) }
    let(:circles_perimeter) { 12.566370614359172 }
    let(:circles_area) { circles_perimeter }

    subject { Shapely::Calculator }

    describe "perimeter" do
      it "can calculate perimeter of a polygon" do
        subject.perimeter_of(triangle).should == triangles_perimeter
      end

      it "can calculate perimeter of a circle" do
        subject.perimeter_of(circle).should == circles_perimeter
      end
    end

    describe "area" do
      it "can calculate area of a polygon" do
        subject.area_of(triangle).should == triangles_area
      end

      it "can calculate area of a circle" do
        subject.area_of(circle).should == circles_area
      end
    end
  end

  describe Shapely::CsvReader do
    let(:sample_data) { "triangle,3.5\ncircle,2\n" }
    let(:csv_reader) { Shapely::CsvReader.new(StringIO.new) }

    describe "acceptance test" do
      # Note, I had to change the output string because the original one did not seem to
      # follow any reliable decimal rounding conventions
      it "should pass" do
        csv_reader.load(sample_data).print_formatted_output
        csv_reader.output_stream.rewind
        csv_reader.output_stream.read.should == <<eos
A triangle with side length 3.50 u has a perimeter of 10.50 u and an area of 5.30 u^2
A circle with radius 2.00 u has a perimeter of 12.57 u and an area of 12.57 u^2
eos
      end
    end

    describe "helper methods" do
      describe "new_shape" do
        it "shoud return an instance of the shape class passed in as a string" do
          csv_reader.new_shape("triangle", 5).should be_kind_of Shapely::Shapes::Triangle
        end
      end
    end
  end
end

# if shape.sides == :infinite
#  #circle
# else
#  #other
# end
#
# each_entry_in file do |entry|
#   shape = new_shape(entry.name, entry.measurement)
#   Calculator.print_information_about(shape)
# end
#
# class Triangle
#   number_of_sides 3
# end
#
# class Circle
#   number_of_sides :infinite
# end
