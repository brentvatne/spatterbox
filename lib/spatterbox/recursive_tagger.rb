require_relative 'xml_tag.rb'

def recursively_tag(tokens, depth=0)
  return "" if tokens.empty?
  tag = XMLTag.new(tokens.shift, depth)

  tag.open + recursively_tag(tokens, depth+1) + tag.close
end
