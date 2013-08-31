class Table_Test < UIViewController

attr_reader :table

def initWithNibName(name, bundle: bundle)
super
self.tabBarItem=UITabBarItem.alloc.initWithTitle("Table", image: nil, tag: 1)
self
end

def viewDidLoad
super
self.title="Table Test"
@table=UITableView.alloc.initWithFrame(self.view.bounds)
view.addSubview(@table)
@table.delegate=self
@table.dataSource=self
@data=("A".."Z").to_a
end

def tableView(view, numberOfRowsInSection: section)
@data.count
end

def tableView(view, cellForRowAtIndexPath: index)
@reuse_identifier||="CELL_IDENTIFIER"
cell=view.dequeueReusableCellWithIdentifier(@reuse_identifier)
cell=UITableViewCell.alloc.initWithStyle(0, reuseIdentifier: @reuse_identifier)
cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator
cell.textLabel.text=@data[index.row]
cell
end

def tableView(view, didSelectRowAtIndexPath: index)
letter=@data[index.row]
controller=UIViewController.alloc.initWithNibName(nil, bundle: nil)
controller.title=letter
label=UILabel.alloc.initWithFrame(CGRectZero)
label.text=letter
label.sizeToFit
label.center=[controller.view.frame.size.width/2, controller.view.frame.size.height/2]
controller.view.addSubview(label)
self.navigationController.pushViewController(controller, animated: true)
end

end
