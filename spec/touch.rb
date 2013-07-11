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
picker=Picker.new
picker.delegate=self
picker.dataSource=self
picker.touch(row: 5, component: 0)
picker.selectedRowForComponent(0).should==5
picker.touch(row: "5", component: 0)
picker.selectedRowForComponent(0).should==4
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

end
