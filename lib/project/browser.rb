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
if view.nil?&&Accessibility::Browser.current_view.nil?
view=UIApplication.sharedApplication.keyWindow
view=view.subviews.first while view.subviews.length==1
Accessibility::Browser.current_view=view
else
Accessibility::Browser.current_view=view if view
end
end

def say_view(view, index=nil)
control=view.class.to_s
if view.accessibility_element?
name=view.accessibility_label||"Unlabeled"
say="#{control}: #{name}"
else
say=control
end
say="#{index}. #{say}" if index
say
end

def display_views
Accessibility::Browser.views.each_index do |index|
puts say_view(A11y::Browser.views[index], index)
end
end

def browse(request=nil)
Accessibility::Browser.init
new_view=nil
request=0 if request==:back
if request.nil?
display_views
else
found=A11y::Browser.find_view(request)
new_view=found if found
end
if new_view
raise "This view has no subviews" if new_view.subviews.empty?
A11y::Browser.current_view=new_view
display_views
end
nil
end

def self.find_view(request)
found=nil
if request.kind_of?(Fixnum)
raise "Invalid number" unless request>=0&&request<Accessibility::Browser.views.length
found=Accessibility::Browser.views[request]
elsif request.kind_of?(String)
results=[]
Accessibility::Browser.current_view.subviews.each do |view|
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

def view(request=nil)
Accessibility::Browser.init
return Accessibility::Browser.cursor unless request
result=Accessibility::Browser.find_view(request)
raise "Unknown view" unless result
Accessibility::Browser.cursor=result
say_view result
end

end
end

class NSObject

def touch(arg=nil)
control=self.class.to_s
if control=~/^UI.+?Button/
arg||=UIControlEventTouchUpInside
self.sendActionsForControlEvents(arg)
elsif control=="UITextField"
self.text=arg
else
raise "I don't know what to do with a #{control}"
end
end

end
