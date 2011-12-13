describe TagPrettifier do
  let(:sample_input) { "<html><body><div><a></a></div></body></html>" }
  let(:sample_output) { <<eos }
<html>
  <body>
    <div>
      <a>
      </a>
    </div>
  </body>
</html>
eos

  describe "acceptance test" do
    it "should produce the correct output from given sample" do
      # TagPrettifier.prettify(sample_input).should == sample_output
    end

    it "" do

    end
  end

  describe "helper methods" do
    it "uses the input stream passed in to prettify" do
      input = "from my input stream\n"
      prettifier = TagPrettifier.new(input_buffer(input))
      prettifier.gets.should == input
    end

    describe "parse_open_tag" do
      it "returns false if open tag is not next" do
        prettifier = running_prettifier("</html>")
        prettifier.parse_open_tag.should == false
      end
    end

    describe "parse_closed_tag" do
      it "returns false if closed tag is not next" do
        prettifier = running_prettifier("<html>")
        prettifier.parse_closed_tag.should == false
      end
    end

    describe "bad_input" do
      it "raises a BadInputError if input is invalid" do
        prettifier = running_prettifier("invalid text")
        expect { prettifier.bad_input }.to raise_error(TagPrettifier::BadInputError)
      end
    end
  end
end

# def read
#   until eos
#     open_tag or close_tag
#   end
# end

# def open_tag
#   if next_tag_is_opening_tag?
#     opening_tag = XMLTag.new(next_tag, current_depth)
#     @stack << opening_tag
#     opening_tag.indent
#   end
# end

# #to indent, tag.indent.close
# def close_tag
#   if next_is_closing_tag?
#     throw NoTagsLeftToClose if @stack.empty?
#     throw AymmetricXMLError unless next_tag == (closing_tag = @stack.pop.close)
#     closing_tag.indent
#   end
# end

