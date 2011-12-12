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

  end
end

def read
  until eos
    open_tag or close_tag
  end
end

def open_tag
  if next_tag_is_opening_tag?
    opening_tag = XMLTag.new(next_tag, current_depth)
    @stack << opening_tag
    opening_tag.indent
  end
end

#to indent, tag.indent.close
def close_tag
  if next_is_closing_tag?
    throw NoTagsLeftToClose if @stack.empty?
    throw AymmetricXMLError unless next_tag == (closing_tag = @stack.pop.close)
    closing_tag.indent
  end
end

