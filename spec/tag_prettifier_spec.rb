describe TagPrettifier do
  let(:sample_input) { input_buffer("<html><body><div><a></a></div></body></html>") }
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
      prettifier = TagPrettifier.new(sample_input, StringIO.new)
      prettifier.prettify
      prettifier.output_stream.rewind
      prettifier.output_stream.read.should == sample_output
    end

    it "should raise an error for each of the malformed examples" do
      expect { TagPrettifier.new(
                input_buffer("<html><body><div></a></body></html>"), StringIO.new).prettify
             }.to raise_error TagPrettifier::BadInputError

      expect { TagPrettifier.new(
                input_buffer("<html><body><div><a></div></a>"), StringIO.new).prettify
             }.to raise_error TagPrettifier::BadInputError
    end
  end

  describe "helper methods" do
    it "uses the input stream passed in to prettify" do
      input = "from my input stream"
      prettifier = TagPrettifier.new(input_buffer(input))
      prettifier.send(:gets).should == input
    end

    describe "parse_open_tag" do
      it "adds the tag to the stack" do
        prettifier = running_prettifier("<body>")

        prettifier.stub!(:parse_tags)
        prettifier.stack.should == []
        prettifier.parse_open_tag
        prettifier.stack.first.token.should == "body"
      end

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

      it "raises a BadInputError if no tag is open" do
        prettifier = running_prettifier("</html>")
        expect { prettifier.parse_closed_tag }.to raise_error TagPrettifier::BadInputError
      end

      it "raises a BadInputError if closing tag doesn't match last open" do
        prettifier = running_prettifier("<html></body>")
        prettifier.stub!(:parse_tags)
        prettifier.parse_open_tag
        expect { prettifier.parse_closed_tag }.to raise_error TagPrettifier::BadInputError
      end
    end

    describe "bad_input" do
      it "raises a BadInputError if input is invalid" do
        prettifier = running_prettifier("invalid text")
        expect { prettifier.send(:bad_input!) }.to raise_error(TagPrettifier::BadInputError)
      end
    end
  end
end
