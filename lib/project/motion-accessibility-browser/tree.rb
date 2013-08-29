module Accessibility
module Browser
class Tree

attr_accessor :view, :subviews, :superview

def initialize(options={})
@view=options[:view]
@subviews=options[:subviews]
@superview=options[:superview]
end

def browsable_nodes
nodes=[@superview]
nodes+=@subviews if @subviews
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
name=@view.accessibility_value||view.accessibility_label
if index
if index>0 and  not(@subviews.empty?)
indicator="+"
else
indicator=" "
end
indicator+=index.to_s
		      display<<indicator
end
display<<control
display<<name if name
display.join(" ")
end

def self.accessible_view?(view)
return view.accessibility_element?||view.accessibility_label||view.accessibility_value||view.accessibility_traits
end

def self.ignore_view?(view)
return true if view.subviews.empty?&&!self.accessible_view?(view)
return true if view.superview&&A11y::Touchable_Types.member?(view.superview.class.to_s)
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
raise "Unknown request: #{request}: #{request.class}"
end
found
end

end
end
end
