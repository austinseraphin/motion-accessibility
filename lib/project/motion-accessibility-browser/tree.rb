class Accessibility
class Browser
class Tree

attr_accessor :view, :subviews

def initialize(options)
@view=options[:view]
@subviews=options[:subviews]
end

def views
views=[@view]
views+=@subviews if @subviews
views
end

def inspect
nodes=@subviews.collect {|tree| tree.inspect}
return @view.class.to_s if @subviews.empty?
result="[#{@view.class}"
result+=" #{nodes.join(" ")}" unless nodes.empty?
result+="]"
result
end

def self.build(view=nil)
view=UIApplication.sharedApplication.keyWindow if view.nil?
subviews=[]
view.subviews.each do |subview|
subviews<<self.build(subview)
end
self.new(view: view, subviews: subviews)
end

def find(request)
found=nil
if request.kind_of?(Fixnum)
raise "Invalid number" unless request>=0&&request<views.length
found=views[request]
elsif request.kind_of?(String)
results=[]
views.each do |node|
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
