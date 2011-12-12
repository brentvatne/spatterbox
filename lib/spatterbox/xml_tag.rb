class XMLTag
  attr_reader :token, :depth, :space_per_indent

  def initialize(token, depth, space_per_indent=2)
    @token = remove_brackets(token)
    @depth = depth
    @current_tag = wrap(@token)
    @space_per_indent = space_per_indent
  end

  def open
    indent + "<#{token}>\n"
  end

  def close
    indent + "</#{token}>\n"
  end

  private
  def indent
    " " * (space_per_indent * depth)
  end

  def wrap(token)
    "<#{token}>"
  end

  def remove_brackets(token)
    token.gsub(/[<>]/,"")
  end
end
