# Accessibility Inspector

class Object

def inspect_accessibility
displayed=[]
if self.class==Accessibility::Element
attributes=A11y::Element_Attributes.dup
else
attributes=Accessibility::All_Attributes.dup
attributes.merge(Accessibility::PickerView_Attributes) if self.class==UIPickerView
end
puts self.inspect
attributes.each do |ruby,ios|
next if ios=~/^set/
next if displayed.member?(ios)
self.inspect_accessibility_attribute(ios)
displayed<<ios
end
puts "Accessibility test: #{self.accessibility_test}" if self.accessibility_test
puts "Accessible: #{self.accessible?}"
A11y.doctor
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
value=self.send(attribute)
end
if value
case Accessibility.attribute_type(attribute)
when :boolean 
value=true if value==1
value=false if value==0||value.nil?
when :cgrect then value="x=#{value.origin.x.round(1)} y=#{value.origin.y.round(1)} width=#{value.size.width.round(1)} height=#{value.size.height.round(1)}"
when :cgpoint then value="x=#{value.x.round(1)} y=#{value.y.round(1)}"
when :uibezierpath then value="x=#{value.bounds.origin.x.round(1)} y=#{value.bounds.origin.y.round(1)} width=#{value.bounds.size.width.round(1)} height=#{value.bounds.size.height.round(1)}"
end
else
value="nil" if value.nil?
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
