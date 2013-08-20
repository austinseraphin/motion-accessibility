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

it "UITableView" do
table=UITableView.alloc.initWithFrame(CGRectZero)
table.delegate=self
table.dataSource=self
@table_data=("A".."Z").to_a
index=NSIndexPath.indexPathForRow(0, inSection: 0)
cell=tableView(table, cellForRowAtIndexPath: index)
cell.class.should==UITableViewCell
$touched_table=nil
cell.touch
$touched_table.should==cell.textLabel.text
end

def tableView(view, numberOfRowsInSection: section)
@table_data.count
end

def tableView(view, cellForRowAtIndexPath: index)
@reuse_identifier||="CELL_IDENTIFIER"
cell=view.dequeueReusableCellWithIdentifier(@reuse_identifier)
cell=UITableViewCell.alloc.initWithStyle(0, reuseIdentifier: @reuse_identifier)
cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator
cell.textLabel.text=@table_data[index.row]
cell
end

def tableView(view, didSelectRowAtIndexPath: index)
$touched_table=@table_data[index.row]
end

end
