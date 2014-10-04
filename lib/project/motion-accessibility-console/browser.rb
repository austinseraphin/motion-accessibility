module Accessibility
module Console

$browser_path=[]
$browser_last=nil
Update_Delay=1.0

def self.touchable_type(view)
control=view.class
until A11y::Touchable_Types.member?(control.to_s)||control.nil?
control=control.superclass
end
if control.class==UITableViewCell
	control=nil unless controll.respond_to?("tableView:didSelectRowAtIndexPath")
end
control
end

def self.scrollable_view?(view)
control=view.class
until control==UIScrollView||control.nil?
control=control.superclass
end
control==UIScrollView
end

def self.init(view=nil)
view=UIApplication.sharedApplication.keyWindow if view.nil?
$browser_tree=A11y::Console::Tree.build(view)
$browser_path<<$browser_tree if $browser_path.empty?
nil
end

def self.display_views
$browser_current=$browser_tree unless $browser_current
puts "Browsing "+$browser_current.display_view
$browser_current.browsable_nodes.each_with_index do |node, index|
next if node.nil?
output=node.display_view( index)
puts output unless output.nil?
end
end

def self.start_refreshing
if !A11y::Data[:refresh]&&RUBYMOTION_ENV!='test'
NSTimer.scheduledTimerWithTimeInterval(Update_Delay, target: self, selector: 'refresh', userInfo: nil, repeats: true)
A11y::Data[:refresh]=true
A11y::Console.init
end
end

def browse(request=nil)
A11y::Console.init unless $browser_current
A11y::Console.start_refreshing
request=0 if request==:back
if request.nil?
elsif request==:top
A11y::Console.init
$browser_current=$browser_tree
$browser_path.clear
elsif request==0
raise "You cannot go back any further" if $browser_path.length<2
$browser_path.pop
$browser_current=$browser_path.last
A11y::Console.init unless A11y::Data[:refresh]
elsif request==:refresh
	raise "This view cannot refresh." unless $browser_current.view.respond_to?(:reloadData)
	$browser_current.view.reloadData
elsif request==:scroll
raise "This view cannot scroll" unless A11y::Console.scrollable_view?($browser_current.view)
below=CGRect.new([0, $browser_current.view.size.height], $browser_current.view.size)
$browser_current.view.scrollRectToVisible(below, animated: false)
elsif request.kind_of?(Fixnum)||request.kind_of?(String)
A11y::Console.init unless $browser_tree
$browser_current=$browser_tree unless $browser_current
found=$browser_current.find(request)
if found
if found.subviews.empty?
$browser_cursor=found
return A11y.inspect found.view
end
A11y::Console.init unless A11y::Data[:refresh]
$browser_current=found
$browser_path<<found
$browser_last=request
end
elsif request.respond_to?(:view)&&request.respond_to?(:subviews)
	A11y::Console.init(request)
	$browser_current=$browser_tree
else
	puts "Unknown request: #{request.inspect}"
end
$browser_cursor=$browser_current
A11y::Console.display_views
nil
end

def self.refresh
A11y::Console.init
$before=$browser_tree.copy unless $before
unless $browser_tree==$before
puts "The screen has changed."
A11y::Console.browse :top
puts "(Main)> "
end
$before=$browser_tree.copy
end

def view(request=nil)
A11y::Console.init unless A11y::Data[:refresh]
$browser_current=$browser_tree unless $browser_current
$browser_cursor=$browser_tree unless $browser_cursor
result=nil
if request
result=$browser_current.find(request)
raise "Unknown view" unless result
$browser_cursor=result
result=result.view
else
result=$browser_cursor.view 
result
end
if result.class==UITableViewCellAccessibilityElement
result=result.tableViewCell
end
result
end

module_function :browse, :view
alias :b :browse
alias :v :view

end
end
