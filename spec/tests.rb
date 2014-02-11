describe "Accessibility::Test" do

	it "tests for an accessibility label" do
		view=UIView.new
		A11y::Test.accessibility_label(view).should.be.false
		view.accessibility_label="test"
		A11y::Test.accessibility_label(view).should.be.true
	end

end

