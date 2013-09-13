module Accessibility
module Browser
class Tree

attr_accessor :view, :subviews, :superview

def initialize(options={})
@view=options[:view]
@subviews=options[:subviews]||[]
@superview=options[:superview]
end

def copy
other=A11y::Browser::Tree.new
other.superview=self.superview if superview
other.view=self.view if view
self.subviews.each {|subview| other.subviews<<subview.clone}
other
end

def ==(other)
return false unless self.superview.view==other.superview.view
return false unless self.view==other.view
return false unless self.subviews.size==other.subviews.size
self.subviews.each_index {|index| return false unless self.subviews[index].view==other.subviews[index].view}
return true
end

def browsable_nodes
nodes=[@superview]
if @subviews
if A11y::Reverse_Views.member?(@view.class.to_s)
nodes+=@subviews.reverse
else
nodes+=@subviews
end
end
nodes
end

def inspect
nodes=@subviews.collect {|tree| tree.inspect}
return @view.class.to_s if @subviews.empty?
result="[#{@view.class}"
result+=" #{nodes.join(" ")}" unless nodes.empty?
result+="]"
result
end

def display_view(index=nil)
display=Array.new
control=@view.class.to_s
control="Superview #{control}" if index==0
if @view.class==UITableViewCell
label=@view.subviews.first.subviews.first
raise "Could not find the UITableViewCell's label" unless label.kind_of?(UILabel)
name=label.text
else
name=A11y::View_Names[@view.class.to_s]||@view.accessibility_value||@view.accessibility_label if @view.accessibility_element?||view.superclass==UIControl
end
display<<index.to_s
display<<"Touchable" if A11y::Browser.touchable_type(@view)
display<<control
display<<name if name
if index
if index>0 and  not(@subviews.empty?)
indicator="with #{@subviews.length} subview"
indicator+="s" if @subviews.length>1
end
   display<<indicator
end
display.join(" ")
end

def self.accessible_view?(view)
return view.accessibility_element?||view.accessibility_label||view.accessibility_value||view.accessibility_traits
end

def self.ignore_view?(view)
return true if view.subviews.empty?&&!self.accessible_view?(view)
if view.superview
sv=view.superview
while sv&&self.ignore_view?(sv)
sv=sv.superview
end
return true if A11y::Browser.touchable_type(sv)
return true if view.class==UIImageView&&A11y::Ignored_ImageViews.member?(sv.class.to_s)
end
class_name=view.class.to_s
return true if class_name=~/^_/
A11y::Ignored_Views.member?(class_name)
end

def self.build(view=nil, superview=nil)
tree=self.new
view=UIApplication.sharedApplication.keyWindow if view.nil?
subviews=[]
view.subviews.each do |subview|
subview_tree=self.build(subview, tree)
if self.ignore_view?(subview)
subview_tree.subviews.each {|v| v.superview=tree}
subviews=subviews+subview_tree.subviews
else
subviews<<subview_tree
end
end
tree.view=view
tree.subviews=subviews
tree.superview=superview
tree
end

def find(request)
found=nil
if request.kind_of?(Fixnum)
raise "Invalid number" unless request>=0&&request<browsable_nodes.length
found=browsable_nodes[request]
elsif request.kind_of?(String)
results=[]
browsable_nodes.each do |node|
next if node.nil?
next unless node.view.accessibility_label
pattern=Regexp.new(request,true)
compare=node.view.accessibility_label=~pattern
next if compare.nil?
if node.view.accessibility_label.downcase==request.downcase
return node
else
results<<node
end
end
raise "\"#{request}\" could refer to more than one view." if results.length>1
found=results.first
else
raise "Unknown request: #{request}: #{request.class}" unless request.respond_to?(:superview)
found=request
end
found
end

end
end
end
