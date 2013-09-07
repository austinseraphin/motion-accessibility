describe "UITableView" do
tests Table_Test

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
A11y::Browser.touch(cell, UIControlEventTouchUpInside, {superview: controller.table, index: index})
$touched_table.should==cell.textLabel.text
end

end

class Table_Test < UIViewController

attr_reader :table, :data

def viewDidLoad
super
@table=UITableView.alloc.initWithFrame(self.view.bounds)
@table.delegate=self
@table.dataSource=self
@data=("A".."Z").to_a
end

def tableView(tableVview, numberOfRowsInSection: section)
@data.count
end

def tableView(tableView, cellForRowAtIndexPath: index)
@reuse_identifier||="CELL_IDENTIFIER"
cell=tableView.dequeueReusableCellWithIdentifier(@reuse_identifier)
cell=UITableViewCell.alloc.initWithStyle(0, reuseIdentifier: @reuse_identifier)
cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator
cell.textLabel.text=@data[index.row]
cell
end

def tableView(tableView, didSelectRowAtIndexPath: index)
$touched_table=@data[index.row]
end

end
