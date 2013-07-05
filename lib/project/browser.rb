module Accessibility
module Browser

Data=Hash.new

def self.init(view=UIApplication.sharedApplication.keyWindow, depth=0)
if depth==0
Data[:views]=[] 
end
raise "Cannot get the root view" unless view
if view.accessibility_element?
Data[:views]<<view
else
Data[:views]<<view if view.subviews.map {|v| v.accessibility_element?}.member?(true)
view.subviews.each {|view| Accessibility::Browser.init(view, depth+1)}
end
end

def views
Accessibility::Browser.init
Data[:views].each_index do |index|
subview=Data[:views][index]
control=subview.class.to_s
control.sub!(/^UI/,"")
if subview.accessibility_element?
name=subview.accessibility_label||"Unlabeled"
say="#{index}. #{name} #{control}"
else
say="#{index}. #{control}"
end
puts say
end
nil
end

def view(request=nil)
Accessibility::Browser.init
return Data[:view] unless request
if request.kind_of?(Fixnum)
raise "Invalid number" unless request>=0&&request<Data[:views].length
Data[:view]=Data[:views][request]
elsif request.kind_of?(String)
results=[]
Data[:views].each do |view|
next unless view.accessibility_label
compare=view.accessibility_label.casecmp(request)
if compare==0
Data[:view]=view
return view
elsif compare>0
results<<view
end
end
raise "That could refer to more than one view." if results.length>1
Data[:view]=results.first
else
raise "Unknown request: #{request}: #{request.class}"
end
end

end
end

class UIView

def touch(arg=nil)
control=self.class.to_s
if control=~/^UI.+?Button/
arg||=UIControlEventTouchUpInside
self.sendActionsForControlEvents(arg)
elsif control=="UITextField"
self.text=arg
else
riase "I don't know what to do with a #{control}"
end
end

end
