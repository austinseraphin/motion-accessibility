module Accessibility
module Browser

def self.tree
A11y::Data[:tree]
end
def self.tree=(tree)
A11y::Data[:tree]=tree
end
def self.path
A11y::Data[:path]||=Array.new
end
def self.path=(path)
A11y::Data[:path]=path
end
def self.current
A11y::Data[:current]
end
def self.current=(tree)
A11y::Data[:current]=tree
end
def self.cursor
Accessibility::Data[:cursor]
end
def self.cursor=(view)
Accessibility::Data[:cursor]=view
end

def self.init_transition(view)
raise "init_transition requires a UINavigationTransitionView" unless view.kind_of?(UINavigationTransitionView)
view=view.subviews.first
raise "Could not find the UIViewControllerWrapperView" unless view.kind_of?(UIViewControllerWrapperView)
view=view.subviews.first
raise "Could not find the UIView for the transition" unless view.kind_of?(UIView)
view
end

def self.init(view=nil)
view=UIApplication.sharedApplication.keyWindow if view.nil?
self.tree=A11y::Browser::Tree.build(view)
self.path<<tree if self.path.empty?
nil
end

def self.display_views
self.current=self.tree unless self.current
puts "Browsing "+self.current.display_view
self.current.browsable_nodes.each_with_index do |node, index|
next if node.nil?
output=node.display_view( index)
puts output unless output.nil?
end
end

def self.browse(request=nil)
new_view=nil
request=0 if request==:back||request==:up
if request.nil?
self.init
elsif request==:top
self.init
self.current=self.tree
self.path.clear
elsif request==0
raise "You cannot go back any further" if self.path.length<2
self.path.pop
self.current=self.path.last
self.init
else
self.init unless self.tree
self.current=self.tree unless self.current
found=self.current.find(request)
if found
raise "This view has no subviews" if found.subviews.empty?
self.init
self.current=found
self.path<<found
end
end
self.display_views
nil
end

def self.view(request=nil)
self.init
self.current=tree unless self.current
self.cursor=self.tree unless self.cursor
return self.cursor.view unless request
result=self.current.find(request)
raise "Unknown view" unless result
self.cursor=result
result.view
end

end
end

class NSObject

def browse(*args)
A11y::Browser.browse(*args)
end
def view(*args)
A11y::Browser.view(*args)
end
alias :b :browse
alias :v :view

end
