describe "Object#touch" do

it "UITextField" do
@text=UITextField.new
@text.touch "Test"
@text.text.should=="Test"
end

it "UIButton" do
@button=UIButton.buttonWithType(UIButtonTypeRoundedRect)
$button_tapped=false
@button.addTarget(self, action: 'tap_button', forControlEvents: UIControlEventTouchUpInside)
@button.touch
$button_tapped.should==true
end

def tap_button
$button_tapped=true
end

it "UIPickerView" do
picker=UIPickerView.new
picker.delegate=self
picker.dataSource=self
picker.touch(row: 5, component: 0)
picker.selectedRowInComponent(0).should==5
picker.touch(row: "5", component: 0)
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
picker.touch(now)
picker.date.should==now
end

it "UISegmentedView" do
segment=UISegmentedControl.alloc.initWithItems(["Test 1", "Test 2"])
segment.touch(0)
segment.selectedSegmentIndex.should==0
segment.touch("2")
segment.selectedSegmentIndex.should==1
end

it "UISlider" do
slider=UISlider.new
slider.touch(0.5)
slider.value.should==0.5
end

it "UIStepper" do
stepper=UIStepper.new
stepper.touch(23)
stepper.value.should==23
end

it "UISwitch" do
switch=UISwitch.new
switch.touch(true)
switch.on?.should==true
end

end
