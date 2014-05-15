describe "Accessibility::Test" do

	it "find_tests" do
		A11y::Test.find_tests(UIView.new).class.should.equal(Hash)
		A11y::Test.find_tests(UIView).class.should.equal(Hash)
		A11y::Test.find_tests(UIActionSheet.new)[:accessibility_label].should.be.nil
		custom=A11y::Test.find_tests(UIView.new, UIView)
			custom.class.should.equal Hash
			custom[:is_accessibility_element].should.not.be.nil
	end

	it "UIActionSheet" do
		action=UIActionSheet.new
		action.should.be.accessible
	end

	it "UIActivityIndicatorView" do
		indicator=UIActivityIndicatorView.new
		indicator.should.be.accessible
	end

		it "UIAlertView" do
			alert=UIAlertView.alloc.initWithTitle("Test", message: "A test", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: nil)
			alert.should.be.accessible
		end

		it "UIButton" do
			button=UIButton.buttonWithType(UIButtonTypeRoundedRect)
			button.setTitle("Test", forState: UIControlStateNormal)
			button.should.be.accessible
		end

		it "UICollectionReusableView" do
			UICollectionReusableView.new.should.be.accessible
		end

		it "UIDatePicker" do
			picker=UIDatePicker.new
			picker.should.be.accessible
		end

		it "UIImage" do
			image=UIImage.imageNamed "Default-568h@2x.png"
			image.should.not.be.accessible
		end

		it "UIImageView" do
			UIImageView.new.should.be.accessible
		end

		it "UILabel" do
			label=UILabel.new
			label.text="Test"
			label.should.be.accessible
		end

		it "UIPageControl" do
			UIPageControl.new.should.be.accessible
		end

		it "UIRefreshControl" do
			UIRefreshControl.new.should.be.accessible
		end

		it "UISegmentedControl" do
			seg=UISegmentedControl.alloc.initWithItems(["1","2","3"])
seg.should.be.accessible
		end

it "UISlider" do
slider=UISlider.new
slider.value=0.5
slider.should.be.accessible
end

it "UIStepper" do
	stepper=UIStepper.new
	stepper.should.be.accessible
end

it "UISwitch" do
	switch=UISwitch.new
	switch.on=true
	switch.should.be.accessible
	switch.on=false
	switch.should.be.accessible
end

it "UITextField" do
	textfield=UITextField.new
	textfield.text="Test"
	textfield.should.be.accessible
end

		it "UIView" do
			UIView.new.should.be.accessible
		end

end

