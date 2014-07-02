class Spec_Table_Test < UIViewController

attr_reader :table, :data

def viewDidLoad
super
@table=UITableView.alloc.initWithFrame(self.view.bounds)
@table.delegate=self
@table.dataSource=self
self.view.addSubview(@table)
@data=("A".."Z").to_a
end

def tableView(tableView, numberOfRowsInSection: section)
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

