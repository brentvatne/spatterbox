describe XMLTag do
  let(:div_tag) { XMLTag.new("div", 0) }
  describe "opening_tag" do
    it "returns the token wrapped in braces and add a newline" do
      div_tag.open.should == "<div>\n"
    end
  end

  describe "closing_tag" do
    it "returns the token wrapped in braces with a leading forward slash and add a newline" do
      div_tag.close.should == "</div>\n"
    end
  end

  describe "correct indentation" do
    it "returns two spaces for each depth by default" do
      div_tag = XMLTag.new("div", 1)
      div_tag.open.should == "  <div>\n"
    end
  end

  describe "valid inputs" do
    it "works with a token (eg 'div')" do
      div_tag = XMLTag.new("div", 0)
      div_tag.open.should == "<div>\n"
    end

    it "accepts a tag" do
      div_tag = XMLTag.new("<div>", 0)
      div_tag.open.should == "<div>\n"
    end
  end
end
