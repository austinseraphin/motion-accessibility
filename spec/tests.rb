describe "Accessibility::Test" do

	it "accessibility label" do
		view=UIView.new
		A11y::Test.accessibility_label(view).should.be.false
		view.accessibility_label="test"
		A11y::Test.accessibility_label(view).should.be.true
	end

	it "accessibility frame" do
		view=UIView.new
		view.accessibility_frame=CGRectZero
		A11y::Test.accessibility_frame(view).should.be.true
	end

	it "accessibility activation point" do
		view=UIView.new
		view.accessibility_activation_point=CGPointZero
		A11y::Test.accessibility_activation_point(view).should.be.true
	end

	it "is_accessibility_element" do
		view=UIView.new
		A11y::Test.is_accessibility_element(view).should.be.false
		view.is_accessibility_element=true
		A11y::Test.is_accessibility_element(view).should.be.true
	end

	it "UIView" do
		view=UIView.new
		A11y::Test.nsobject(view).should.be.false
		view.accessibility_label="test"
		view.is_accessibility_element=true
		A11y::Test.nsobject(view).should.be.true
		view.should.be.accessible
	end

end

