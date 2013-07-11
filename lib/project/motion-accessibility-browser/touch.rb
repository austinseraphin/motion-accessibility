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
when "UIDatePicker"
self.date=arg
when "UISegmentedControl"
touch_segmented(arg)
when "UISlider"
self.value=arg
when "UIStepper"
self.value=arg
when "UISwitch"
self.on=arg
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
if title.casecmp(arg[:row])==0
results=[row_index]
break
end
if title=~Regexp.new(arg[:row],true)
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

def touch_segmented(arg)
if arg.kind_of?(Fixnum)
self.selectedSegmentIndex=arg
elsif arg.kind_of?(String)
results=[]
self.numberOfSegments.times do |index|
title=self.titleForSegmentAtIndex(index)
if title.casecmp(arg)==0
results=[index]
break
end
if title=~Regexp.new(arg,true)
results<<index
end
end
raise "Unknown segment" if results.empty?
raise "That could refer to more than one segment" if results.length>1
self.selectedSegmentIndex=results.first
else
raise "Invalid segment"
end
end

end
