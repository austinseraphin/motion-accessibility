# Accessibility Inspector

module Accessibility

def self.inspect(obj)
displayed=[]
if obj.class==Accessibility::Element
attributes=A11y::Element_Attributes.dup
else
attributes=Accessibility::All_Attributes.dup
attributes.merge(Accessibility::PickerView_Attributes) if obj.class==UIPickerView
end
puts obj.inspect
attributes.each do |ruby,ios|
next if ios=~/^set/
next if displayed.member?(ios)
self.inspect_accessibility_attribute(obj,ios)
displayed<<ios
end
puts "Accessibility test: #{obj.accessibility_test}" if obj.accessibility_test
puts "Accessibility container: #{obj.accessibility_element_count} elements" if obj.accessibility_element_container?
puts "Accessible: #{obj.accessible?}"
A11y.doctor
end

def self.inspect_accessibility_attribute(obj,attribute)
name=attribute.gsub(/(.)([A-Z])/,'\1 \2').capitalize
if Accessibility::Attribute_Types.member?(attribute)
begin
case attribute
when :accessibilityTraits then value=self.inspect_accessibility_traits(obj)
else
value=obj.send(attribute)
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

def self.inspect_accessibility_traits(obj)
	return obj.accessibility_traits if obj.accessibility_traits>Accessibility::Traits.values.max
traits=[]
Accessibility::Traits.each do |trait, bitmask|
if obj.accessibility_traits&bitmask>0
name=trait.gsub(/_/,' ').capitalize
traits<<name
end
end
traits=["None"] if traits.empty?
	traits.join(', ')
end

end
