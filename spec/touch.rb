describe "Object#touch" do

it "UITextField" do
@text=UITextField.new
A11y::Console.touch(@text, "Test")
@text.text.should=="Test"
end

it "UIButton" do
@button=UIButton.buttonWithType(UIButtonTypeRoundedRect)
$button_tapped=false
@button.addTarget(self, action: 'tap_button', forControlEvents: UIControlEventTouchUpInside)
A11y::Console.touch(@button)
$button_tapped.should==true
end

def tap_button
$button_tapped=true
end

it "UIPickerView" do
picker=UIPickerView.new
picker.delegate=self
picker.dataSource=self
A11y::Console.touch(picker, {row: 5, component: 0})
picker.selectedRowInComponent(0).should==5
A11y::Console.touch(picker, {row: "5", component: 0})
picker.selectedRowInComponent(0).should==5
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

it "UIDatePicker" do
picker=UIDatePicker.new
now=Time.now
A11y::Console.touch(picker, now)
picker.date.to_s.should==now.to_s
end

it "UISegmentedView" do
segment=UISegmentedControl.alloc.initWithItems(["Test 1", "Test 2"])
A11y::Console.touch(segment, 0)
segment.selectedSegmentIndex.should==0
A11y::Console.touch(segment, "2")
segment.selectedSegmentIndex.should==1
end

it "UISlider" do
slider=UISlider.new
A11y::Console.touch(slider, 0.5)
slider.value.should==0.5
end

it "UIStepper" do
stepper=UIStepper.new
A11y::Console.touch(stepper, 23)
stepper.value.should==23
end

it "UISwitch" do
switch=UISwitch.new
A11y::Console.touch(switch, true)
switch.on?.should==true
end

end
