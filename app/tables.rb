class Table_Test < UIViewController

attr_reader :table

Phonetics = %w[alpha bravo charlie delta echo foxtrat golf hotel india juliet kilo lima mike november oscar papa quebec romeo siera tango uniform victor whiskey x-ray yankee zulu]

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
@data.count/2
end

def numberOfSectionsInTableView(view)
	2
end

def tableView(view, cellForRowAtIndexPath: index)
	letter=(index.section*13)+index.row
@reuse_identifier||="CELL_IDENTIFIER"
cell=view.dequeueReusableCellWithIdentifier(@reuse_identifier)
cell=UITableViewCell.alloc.initWithStyle(0, reuseIdentifier: @reuse_identifier)
cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator
cell.textLabel.text=@data[letter]
cell
end

def tableView(view, didSelectRowAtIndexPath: index)
	letter_index=(index.section*13)+index.row
letter=@data[letter_index]
phonetic=Phonetics[letter_index]
controller=UIViewController.alloc.initWithNibName(nil, bundle: nil)
controller.title=letter
label=UILabel.alloc.initWithFrame(CGRectZero)
label.text=phonetic
label.sizeToFit
label.center=[controller.view.frame.size.width/2, controller.view.frame.size.height/2]
controller.view.addSubview(label)
self.navigationController.pushViewController(controller, animated: true)
end

end
