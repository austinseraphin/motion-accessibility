describe "UITableView" do
tests Spec_Table_Test

it "initialized properly" do
controller.table.class.should==UITableView
controller.data.length.should>0
controller.tableView(controller.table, numberOfRowsInSection: 0).should==controller.data.size
end

it "touches a UITableView" do
index=NSIndexPath.indexPathForRow(0, inSection: 0)
cell=controller.tableView(controller.table, cellForRowAtIndexPath: index)
cell.class.should==UITableViewCell
$touched_table=nil
A11y::Console.touch(cell, UIControlEventTouchUpInside, {superview: controller.table, index: index})
$touched_table.should==cell.textLabel.text
end

it "touches a UITableViewAccessibilityElement" do
index=NSIndexPath.indexPathForRow(0, inSection: 0)
	controller.accessibility_element_count.should.> 0
cell=controller.table.accessibility_element_at_index(0)
cell.class.should==UITableViewCellAccessibilityElement
$touched_table=nil
A11y::Console.touch(cell, UIControlEventTouchUpInside, {superview: controller.table, index: index})
cell.accessibility_element_count.should > 0
text=cell.accessibility_element_at_index(0)
$touched_table.should==text.accessibility_label
end

end
