describe "UITableView" do
tests Table_Test

it "touches a UITableView" do
index=NSIndexPath.indexPathForRow(0, inSection: 0)
cell=controller.tableView(controller.table, cellForRowAtIndexPath: index)
cell.class.should==UITableViewCell
$touched_table=nil
cell.touch
$touched_table.should==cell.textLabel.text
end

end

class Table_Test < UIViewController

attr_reader :table

def viewDidLoad
super
@table=UITableView.alloc.initWithFrame(self.view.bounds)
@table.delegate=self
@table.dataSource=self
@table_data=("A".."Z").to_a
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
