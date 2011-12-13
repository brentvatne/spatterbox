#!/usr/bin/env ruby

require File.join(File.expand_path(File.dirname(__FILE__)), '/../lib/spatterbox/tag_prettifier')

if $_
  TagPrettifier.new(StringIO.new($_)).prettify
else
  TagPrettifier.new.prettify
end
