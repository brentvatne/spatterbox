describe "recursively_tag" do
  it "works" do
    recursively_tag(%w(a b c)).should  eq(
      "<a>\n  <b>\n    <c>\n    </c>\n  </b>\n</a>\n"
    )
  end
end
