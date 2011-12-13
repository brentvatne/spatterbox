#!/usr/bin/env ruby

require File.join(File.expand_path(File.dirname(__FILE__)), '/../lib/spatterbox/shapely')

csv_path = ARGV.first
csv_as_string = ""

if csv_path == "sample"
	csv_as_string = File.open(File.expand_path("./data/sample_shapes.csv")).read
else
	csv_as_string = File.open(csv_path).read
end

Shapely::CsvReader.new.load(csv_as_string).print_formatted_output
