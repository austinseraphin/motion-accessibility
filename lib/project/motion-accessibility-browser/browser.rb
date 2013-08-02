module Accessibility
module Browser

def self.current
A11y::Data[:tree]
end
def self.current=(tree)
A11y::Data[:tree]=tree
end
def self.path
A11y::Data[:path]||[]
end
def self.path=(path)
A11y::Data[:path]=path
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
self.current=A11y::Browser::Tree.build(view)
self.cursor=view
nil
end

def self.display_views
puts "Browsing "+self.display_view(self.current.view)
self.current.browsable_nodes.each_index do |index|
next if self.current.browsable_nodes[index].nil?
puts self.display_view(self.current.browsable_nodes[index], index)
end
end

def self.browse(request=nil)
new_view=nil
request=0 if request==:back||request==:up
if request.nil?
self.init(self.current.view)
elsif request==:top
self.init
elsif request==0
raise "You cannot go back any further" if self.path.empty?
self.path.pop
self.init(self.path.last)
self.display_views
else
found=self.current.find(request)
new_view=found if found
end
if new_view
raise "This view has no subviews" if new_view.subviews.empty?
end
self.display_views
nil
end

def self.view(request=nil)
self.init
return self.cursor unless request
result=self.find_view(request)
raise "Unknown view" unless result
self.cursor=result
display_view result
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
