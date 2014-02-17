describe "Accessibility::Test" do

	it "object" do
		A11y::Test.object(UIView.new).class.should.equal(Hash)
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
			UIAlertView.new.should.be.accessible
		end

end

