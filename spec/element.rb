describe Accessibility::Element do

	before do
		@a=A11y::Element.init_with_accessibility_container(self)
		@a.label="Test"
		@a.hint="Test"
@a.traits=:button
@a.frame=CGRectMake(0,0,100,100)
@a.value="23"
@a.is_accessibility_element=true
	end

	it "#initialize" do
		@a.container.should.equal self
		@a.label.should.equal "Test"
		@a.hint.should.equal "Test"
@a.traits.should.equal :button.accessibility_trait
@a.frame.class.should.equal CGRect
@a.value.should.equal "23"
@a.is_accessibility_element.should.equal true
	end

end

