module Accessibility
module Browser

def self.current_view
Accessibility::Data[:view]
end
def self.current_view=(view)
Accessibility::Data[:view]=view
end
def self.cursor
Accessibility::Data[:cursor]
end
def self.cursor=(view)
Accessibility::Data[:cursor]=view
end

def self.views
[self.current_view.superview]+self.current_view.subviews
end

def self.init(view=nil)
if view.nil?&&self.current_view.nil?
view=UIApplication.sharedApplication.keyWindow
view=view.subviews.first while view.subviews.length==1
self.current_view=view
else
self.current_view=view if view
end
end

def self.display_view(view, index=nil)
display=Array.new
control=view.class.to_s
control="Superview #{control}" if index==0
name=view.accessibility_value||view.accessibility_label
if index
if index>0 and  not(view.subviews.empty?)
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

def self.display_views
puts "Browsing "+self.display_view(self.current_view)
self.views.each_index do |index|
next if self.views[index].nil?
puts self.display_view(self.views[index], index)
end
end

def self.browse(request=nil)
self.init
new_view=nil
request=0 if request==:back||request==:up
if request.nil?
self.display_views
else
raise "You cannot go back any further" if self.current_view.superview.nil?
found=self.find_view(request)
new_view=found if found
end
if new_view
raise "This view has no subviews" if new_view.subviews.empty?
self.current_view=new_view
self.cursor=nil
self.display_views
end
nil
end

def self.find_view(request)
found=nil
if request.kind_of?(Fixnum)
raise "Invalid number" unless request>=0&&request<self.views.length
found=self.views[request]
elsif request.kind_of?(String)
results=[]
self.current_view.subviews.each do |view|
next unless view.accessibility_label
pattern=Regexp.new(request,true)
compare=view.accessibility_label=~pattern
next if compare.nil?
if view.accessibility_label.downcase==request.downcase
return view
else
results<<view
end
end
raise "\"#{request}\" could refer to more than one view." if results.length>1
found=results.first
else
raise "Unknown request: #{request}: #{request.class}"
end
found
end

def self.view(request=nil)
self.init
return self.cursor unless request
result=self.find_view(request)
raise "Unknown view" unless result
self.cursor=result
say_view result
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
