require 'spatterbox'
require 'rspec'

RSpec.configure do |c|
  c.mock_with :rspec
end

def input_buffer(fake_return_value)
  StringIO.new(fake_return_value)
end

def running_prettifier(next_on_buffer)
  prettifier = TagPrettifier.new(input_buffer(next_on_buffer), StringIO.new)
  prettifier.send(:initialize_string_scanner)
  prettifier
end
