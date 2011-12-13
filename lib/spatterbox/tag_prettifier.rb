require 'strscan'
require_relative 'xml_tag'

class TagPrettifier
  attr_reader :stack, :input_stream, :output_stream, :depth

  def initialize(input_stream = STDIN, output_stream = STDOUT)
    @input_stream  = input_stream
    @output_stream = output_stream
    @depth = 0
    @stack = []
  end

  def prettify
    initialize_string_scanner and parse_tags
  end

  def parse_tags
    parse_open_tag || parse_closed_tag || no_more_input? ||  bad_input!
  end

  def parse_open_tag
    return false unless tag = scanner.scan(/<\w*>/)
    stack << XMLTag.new(tag, depth)

    print_open_tag and increase_depth and parse_tags
  end

  def parse_closed_tag
    return false unless tag = scanner.scan(/<\/\w*>/)
    bad_input! if stack.empty? or not stack.last.close[tag]

    print_close_tag and decrease_depth and parse_tags
  end

  private
  def gets
    @input_stream.gets.chomp
  end

  def puts(str)
    @output_stream.puts str
    true
  end

  def no_more_input?
    if scanner.eos?
      bad_input! unless stack.empty?
      true
    end
  end

  def print_open_tag
    puts stack.last.open
  end

  def print_close_tag
    puts stack.pop.close
  end

  def initialize_string_scanner
    @string_scanner = StringScanner.new(gets)
  end

  def scanner
    @string_scanner
  end

  def bad_input!
    raise BadInputError
  end

  def increase_depth
    @depth = @depth + 1
  end

  def decrease_depth
    @depth = @depth - 1
  end

  class BadInputError < StandardError; end
end
