require File.join(File.expand_path(File.dirname(__FILE__)), '/../lib/spatterbox/recursively_tag')

puts recursively_tag(%w( a b c d e f ))
