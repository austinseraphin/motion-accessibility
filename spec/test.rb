describe "Accessibility::Test" do

	it "find_tests" do
		A11y::Test.find_tests(UIView.new).class.should.equal(Hash)
		A11y::Test.find_tests(UIView).class.should.equal(Hash)
		A11y::Test.find_tests(UIActionSheet.new)[:accessibility_label].should.be.nil
		A11y::Test.find_tests(UITabBarItem.new).should==A11y::Test.find_tests(UIBarButtonItem.new)
		custom=UIView.new
custom.accessibility_test=UIView		
		custom=A11y::Test.find_tests(custom)
			custom.class.should.equal Hash
			custom[:is_accessibility_element].should.not.be.nil
			button=UIView.new
			button.accessibility_test=UIButton
			A11y::Test.find_tests(button).should.equal A11y::Test.find_tests(UIButton.new)
	end

	it "Object#accessibility_test=" do
		view=UIView.new
		view.accessibility_test=String
		view.accessibility_test.should.be.nil
		view.accessibility_test=:UIView
		view.accessibility_test.should==:UIView
	end

	it "UIActionSheet" do
		action=UIActionSheet.new
		action.frame=CGRect.new([0,0],[100,100])
		action.should.be.accessible
	end

	it "UIActivityIndicatorView" do
		indicator=UIActivityIndicatorView.new
		indicator.frame=CGRect.new([0,0],[100,100])
		indicator.should.be.accessible
	end

	it "UIAccessibilityElement" do
		a=A11y::Element.alloc.init_with_accessibility_container(self)
		a.accessibility_test=:UILabel
		a.label="Test"
a.traits=:static_text
a.is_accessibility_element=true
a.should.be.accessible
	end

	it "UIAccessibilityContainer" do
		container=Container_Test.new
		container.init_data
		container.frame=CGRectMake(0,0,100,100)
		container.should.be.accessible
	end

		it "UIAlertView" do
			alert=UIAlertView.alloc.initWithTitle("Test", message: "A test", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: nil)
		alert.frame=CGRect.new([0,0],[100,100])
			alert.should.be.accessible
		end

		it "UIButton" do
			button=UIButton.buttonWithType(UIButtonTypeRoundedRect)
			button.setTitle("Test", forState: UIControlStateNormal)
		button.frame=CGRect.new([0,0],[100,100])
			button.should.be.accessible
		end

		it "UICollectionReusableView" do
			collection=UICollectionReusableView.new
		collection.frame=CGRect.new([0,0],[100,100])
			collection.should.be.accessible
		end

		it "UIDatePicker" do
			picker=UIDatePicker.new
		picker.frame=CGRect.new([0,0],[100,100])
			picker.should.be.accessible
		end

		it "UIImage" do
			image=UIImage.imageNamed "Default-568h@2x.png"
			A11y::Test.quiet=true
			image.should.not.be.accessible
			A11y::Test.quiet=false
			image.accessibility_label="test"
			image.is_accessibility_element=true
			image.should.be.accessible
		end

		it "UIImageView" do
			image=UIImageView.new
		image.frame=CGRect.new([0,0],[100,100])
				image.should.be.accessible
		end

		it "UILabel" do
			label=UILabel.new
			label.text="Test"
		label.frame=CGRect.new([0,0],[100,100])
			label.should.be.accessible
		end

		it "UINavigationBar" do
test_controller=TestController.alloc.initWithNibName(nil, bundle: nil)
test_nav=UINavigationController.alloc.initWithRootViewController(test_controller)
test_nav.navigationBar.should.be.accessible
		end

		it "UINavigationController" do
			controller=Spec_Table_Test.alloc.initWithNibName(nil, bundle: nil)
			nav_controller=UINavigationController.alloc.initWithRootViewController(controller)
			nav_controller.should.be.accessible
		end

		it "UIPageControl" do
			page=UIPageControl.new
		page.frame=CGRect.new([0,0],[100,100])
			page.should.be.accessible
		end

it "UIPickerView" do
picker=UIPickerView.new
picker.delegate=self
picker.dataSource=self
A11y.doctor(picker)
picker.should.be.accessible
end

def numberOfComponentsInPickerView(view)
1
end

def pickerView(view, titleForRow: row, forComponent: component)
"Row #{row.to_s}"
end

def pickerView(view, numberOfRowsInComponent: component)
10
end

it "UIPopoverBackgroundView" do
	UIPopoverBackgroundView.new.should.be.accessible
end

it "UIProgressView" do
	progress=UIProgressView.alloc.initWithProgressViewStyle(0)
		progress.frame=CGRect.new([0,0],[100,100])
	progress.should.be.accessible
end

		it "UIRefreshControl" do
			refresh=UIRefreshControl.new
		refresh.frame=CGRect.new([0,0],[100,100])
			refresh.should.be.accessible
		end

		it "UIScrollView" do
			scroll=UIScrollView.new
		scroll.frame=CGRect.new([0,0],[100,100])
			scroll.should.be.accessible
		end

		it "UISearchBar" do
			UISearchBar.new.should.be.accessible
		end

		it "UISegmentedControl" do
			seg=UISegmentedControl.alloc.initWithItems(["1","2","3"])
		seg.frame=CGRect.new([0,0],[100,100])
seg.should.be.accessible
		end

it "UISlider" do
slider=UISlider.new
		slider.frame=CGRect.new([0,0],[100,100])
slider.value=0.5
slider.should.be.accessible
end

it "UIStepper" do
	stepper=UIStepper.new
		stepper.frame=CGRect.new([0,0],[100,100])
	stepper.should.be.accessible
end

it "UISwitch" do
	switch=UISwitch.new
		switch.frame=CGRect.new([0,0],[100,100])
	switch.on=true
	switch.should.be.accessible
	switch.on=false
	switch.should.be.accessible
	switch.accessibility_label="test"
	switch.should.be.accessible
end

it "UITabBar" do
	tab=UITabBar.new
	item=UITabBarItem.alloc.initWithTitle("Test", image: nil, tag: 1)
	A11y.doctor item
	item.should.be.accessible
	tab.setItems([item], animated: false)
	A11y.doctor tab
	tab.should.be.accessible
end

it "UITableView" do
	controller=Spec_Table_Test.alloc.initWithNibName(nil, bundle: nil)
	controller.view.should.be.accessible
	controller.data.clear
	controller.table.reloadData
	controller.view.should.be.accessible
end

it "UITableViewCell" do
	cell=UITableViewCell.new
	cell.accessibility_label="Test"
	cell.should.be.accessible
end

it "UITableViewHeaderFooterView" do
	header=UITableViewHeaderFooterView.new
	header.textLabel.text="Hello"
	header.should.be.accessible
end

it "UITextField" do
	textfield=UITextField.new
		textfield.frame=CGRect.new([0,0],[100,100])
	textfield.text="Test"
	textfield.should.be.accessible
end

it "UIToolbar" do
	item=UIBarButtonItem.alloc.initWithTitle("Test", style: 0, target: self, action: 'tap_button')
	toolbar=UIToolbar.new
	toolbar.items=[item]
	toolbar.should.be.accessible
end

		it "UIView" do
			view=UIView.new
		view.frame=CGRect.new([0,0],[100,100])
			view.should.be.accessible
		end

		it "UIWebView" do
			web=UIWebView.new
			web.should.be.accessible
		end

		it "UIWindow" do
			window=UIWindow.new
			controller=Spec_Table_Test.alloc.initWithNibName(nil, bundle: nil)
			nav_controller=UINavigationController.alloc.initWithRootViewController(controller)
tab_controller=UITabBarController.alloc.initWithNibName(nil, bundle: nil)
tab_controller.viewControllers=[nav_controller]
			window.rootViewController=tab_controller
			window.makeKeyAndVisible
			A11y.doctor window
			window.should.be.accessible
		end

		describe "RMQ" do
			tests TestController
		it "RubyMotionQuery::RMQ" do
			buttons=rmq(UIButton)
			buttons.count.should.be>0
			buttons.should.be.accessible
			rmq.append(UIButton)
			rmq(UIButton).should.not.be.accessible
		end
		end

end

