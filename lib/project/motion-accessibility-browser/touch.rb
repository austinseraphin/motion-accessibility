module Accessibility
module Browser

Update_Delay=1.0

def self.touch(view, arg=nil, options={})
self.init
$before=$browser_tree.copy
$browser_current=$browser_tree unless $browser_current
unless RUBYMOTION_ENV=='test'
found=$browser_current.find(view)
raise "Could not find the view" unless found
      view=found.view
end
control=A11y::Browser.touchable_type(view)
raise "I don't know how to touch a #{view.class}"  if control.nil?
sv=options[:superview]||found.superview.view
case control.to_s
when "UIButton"
arg||=UIControlEventTouchUpInside
view.sendActionsForControlEvents(arg)
when "UITabBarButton"
arg||=UIControlEventTouchUpInside
view.sendActionsForControlEvents(arg)
when "UITextField"
view.text=arg
when "UIPickerView"
self.touch_pickerview(view, arg)
when "UIDatePicker"
view.date=arg
when "UISegmentedControl"
self.touch_segmented(view, arg)
when "UISlider"
view.value=arg
when "UIStepper"
view.value=arg
when "UISwitch"
arg||=!view.arg
view.on=arg
when "UITableViewCell"
raise "Could not get the UITableView" unless sv.kind_of?(UITableView)
index=options[:index]||sv.indexPathForCell(view)
raise "Could not get the index" unless index
sv.delegate.tableView(self, didSelectRowAtIndexPath: index)
when "UINavigationItemButtonView"
view.superview.delegate.popViewControllerAnimated(true)
else
raise "I don't know what to do with a #{control}"
end
unless RUBYMOTION_ENV=="test"
NSTimer.scheduledTimerWithTimeInterval(Update_Delay, target: self, selector: 'after_timer', userInfo: nil, repeats: false)
end
end

def self.after_timer
self.init
if $browser_tree==$before
self.browse
else
self.browse :top
end
print "(main)> "
end

def self.touch_pickerview(view, arg)
raise "You must pass a hash with the row and component keywords" unless arg.kind_of?(Hash)&&arg[:row]&&arg[:component]
arg[:animated]||=false
if arg[:row].kind_of?(String)
results=[]
view.numberOfRowsInComponent(arg[:component]).times do |row_index|
title=view.delegate.pickerView(view, titleForRow: row_index, forComponent: arg[:component])
if title.casecmp(arg[:row])==0
results=[row_index]
break
end
if title=~Regexp.new(arg[:row],true)
results<<row_index
end
end
raise "Unknown value" if results.empty?
raise "That could refer to more than one value." if results.length>1
view.selectRow(results.first, inComponent: arg[:component], animated: false)
elsif arg[:row].kind_of?(Fixnum)
view.selectRow(arg[:row], inComponent: arg[:component], animated: arg[:animated])
else
raise "Unknown row #{arg[:row]}"
end
end

def self.touch_segmented(view, arg)
if arg.kind_of?(Fixnum)
view.selectedSegmentIndex=arg
elsif arg.kind_of?(String)
results=[]
view.numberOfSegments.times do |index|
title=view.titleForSegmentAtIndex(index)
if title.casecmp(arg)==0
results=[index]
break
end
if title=~Regexp.new(arg,true)
results<<index
end
end
raise "Unknown segment" if results.empty?
raise "That could refer to more than one segment" if results.length>1
view.selectedSegmentIndex=results.first
else
raise "Invalid segment"
end
end


end
end
