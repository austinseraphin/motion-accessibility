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

end
