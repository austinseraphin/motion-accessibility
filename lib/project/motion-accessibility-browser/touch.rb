class NSObject

def touch(arg=nil)
control=self.class
until A11y::Touchable_Types.member?(control.to_s)||control.nil?
control=control.superclass
end
raise "I don't know how to touch a #{self.class}" if control.nil?
case control.to_s
when "UIButton"
arg||=UIControlEventTouchUpInside
self.sendActionsForControlEvents(arg)
when "UITextField"
self.text=arg
when "UIPickerView"
touch_pickerview(arg)
else
raise "I don't know what to do with a #{control}"
end
self.browse unless RUBYMOTION_ENV=="test"
end

protected

def touch_pickerview(arg)
raise "You must pass a hash with the row and component keywords" unless arg.kind_of?(Hash)&&arg[:row]&&arg[:component]
arg[:animated]||=false
if arg[:row].kind_of?(String)
results=[]
self.numberOfRowsInComponent(arg[:component]).times do |row_index|
title=self.delegate.pickerView(self, titleForRow: row_index, forComponent: arg[:component])
puts "#{title} =~ #{arg[:row]}"
if title=~Regexp.new(arg[:row],true)
results=[row_index]
break
end
if title=~Regexp.new(arg[:row])
results<<row_index
end
end
raise "Unknown value" if results.empty?
raise "That could refer to more than one value." if results.length>1
self.selectRow(results.first, inComponent: arg[:component], animated: false)
elsif arg[:row].kind_of?(Fixnum)
selectRow(arg[:row], inComponent: arg[:component], animated: arg[:animated])
else
raise "Unknown row #{arg[:row]}"
end
end

end
