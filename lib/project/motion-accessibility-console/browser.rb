module Accessibility
module Console

$browser_path=[]

def self.touchable_type(view)
control=view.class
until A11y::Touchable_Types.member?(control.to_s)||control.nil?
control=control.superclass
end
control
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

def self.browse(request=nil)
self.init unless $browser_current
request=0 if request==:back||request==:up
if request.nil?
elsif request==:top||request==:refresh
self.init
$browser_current=$browser_tree
$browser_path.clear
elsif request==0
raise "You cannot go back any further" if $browser_path.length<2
$browser_path.pop
$browser_current=$browser_path.last
self.init unless A11y::Data[:refresh]
else
self.init unless $browser_tree
$browser_current=$browser_tree unless $browser_current
found=$browser_current.find(request)
if found
if found.subviews.empty?
$browser_cursor=found
return found.view.inspect_a11y
end
self.init unless A11y::Data[:refresh]
$browser_current=found
$browser_path<<found
end
end
$browser_cursor=$browser_current
self.display_views
nil
end

def self.view(request=nil)
self.init unless A11y::Data[:refresh]
$browser_current=$browser_tree unless $browser_current
$browser_cursor=$browser_tree unless $browser_cursor
return $browser_cursor.view unless request
result=$browser_current.find(request)
raise "Unknown view" unless result
$browser_cursor=result
result.view
end

alias :b :browse
alias :v :view

end
end
