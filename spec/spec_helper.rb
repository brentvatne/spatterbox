require 'spatterbox'
require 'rspec'

RSpec.configure do |c|
  c.mock_with :rspec
end

def new_triangle(side_length=1)
  Shapely::Shapes::Triangle.new(side_length)
end

def new_square(side_length=1)
  Shapely::Shapes::Square.new(side_length)
end

def new_pentagon(side_length=1)
  Shapely::Shapes::Pentagon.new(side_length)
end

def new_circle(radius=1)
  Shapely::Shapes::Circle.new(radius)
end

def input_buffer(fake_return_value)
  StringIO.new(fake_return_value)
end

def running_prettifier(next_on_buffer)
  prettifier = TagPrettifier.new(input_buffer(next_on_buffer), StringIO.new)
  prettifier.send(:initialize_string_scanner)
  prettifier
end
