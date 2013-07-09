# Accessibility Inspector

class Object

def inspect_accessibility
displayed=[]
attributes=Accessibility::All_Attributes.dup
attributes.merge(Accessibility::PickerView_Attributes) if self.class==UIPickerView
attributes.each do |ruby,ios|
next if ios=~/^set/
next if displayed.member?(ios)
self.inspect_accessibility_attribute(ios)
displayed<<ios
end
nil
end

alias :inspect_a11y :inspect_accessibility

protected

def inspect_accessibility_attribute(attribute)
name=attribute.gsub(/(.)([A-Z])/,'\1 \2').capitalize
if Accessibility::Attribute_Types.member?(attribute)
begin
case attribute
when :accessibilityTraits then value=inspect_accessibility_traits
else
value=self.send(attribute).inspect
end
case Accessibility.attribute_type(attribute)
when :boolean then value=(value==1?true:false)
when :cgrect then value="x=#{self.origin.x} y=#{self.origin.y} width=#{self.size.width} height=#{self.size.height}"
when :cgpoint then value="x=#{self.origin.x} y=#{self.origin.y}"
end
rescue
value="Error: #{$!}"
end
puts "#{name}: #{value}"
elsif Accessibility.defined_attribute?(self.class,attribute)
puts "#{name}: Defined"
end
end 

end
