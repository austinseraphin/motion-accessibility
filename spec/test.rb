describe "Accessibility::Test" do

	it "object" do
		A11y::Test.object(UIView.new).class.should.equal(Hash)
		A11y::Test.object(UIActionSheet.new)[:accessibility_label].should.be.nil
	end

	it "UIView" do
		view=UIView.new
		view.should.not.be.accessible
		view.accessibility_label="test"
		view.is_accessibility_element=true
		view.should.be.accessible
	end

	it "UIActionSheet" do
		action=UIActionSheet.new
		action.should.be.accessible
	end

	it "UIActivityIndicatorView" do
		indicator=UIActivityIndicatorView.new
		indicator.should.be.accessible?
	end

		it "UIAlertView" do
			alert=UIAlertView.alloc.initWithTitle("Test", message: "A test", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: nil)
			alert.should.be.accessible
		end

		it "UILabel" do
			label=UILabel.new
			label.text="Test"
			label.should.be.accessible
		end


end

