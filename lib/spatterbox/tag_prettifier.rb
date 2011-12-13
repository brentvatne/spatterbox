require 'strscan'

class TagPrettifier
  def initialize(input_stream = STDIN)
    @input_stream = input_stream
  end

  def prettify
    initialize_string_scanner and parse_tags
  end

  def gets
    @input_stream.gets
  end

  def parse_tags
    parse_open_tag || parse_closed_tag || bad_input
  end

  def parse_open_tag
    return false unless scanner.scan(/<\w*>/)
  end

  def parse_closed_tag
    return false unless scanner.scan(/<\/\w*>/)
  end

  def bad_input
    raise BadInputError
  end

  private
  def initialize_string_scanner
    @string_scanner = StringScanner.new(gets)
  end

  def scanner
    @string_scanner
  end

  class BadInputError < StandardError; end
end
