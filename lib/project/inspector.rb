# Accessibility Inspector

class Object

def inspect_accessibility
displayed=[]
attributes=Accessibility::All_Attributes.dup
attributes.merge(Accessibility::PickerView_Attributes) if self.class==UIPickerView
puts self.inspect
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
value=self.send(attribute)
value="nil" if value.nil?
end
case Accessibility.attribute_type(attribute)
when :boolean 
value=true if value==1
value=false if value==0||value.nil?
when :cgrect then value="x=#{value.origin.x.round(1)} y=#{value.origin.y.round(1)} width=#{value.size.width.round(1)} height=#{value.size.height.round(1)}"
when :cgpoint then value="x=#{value.x.round(1)} y=#{value.y.round(1)}"
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
