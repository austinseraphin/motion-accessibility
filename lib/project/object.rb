
class NSObject

Accessibility::Attributes.each do |ruby, ios|
next unless self.respond_to?(ios)
next if ruby==:accessibility_traits=
if ruby=~/=$/
define_method(ruby) {|value| self.send(ios,value)}
else
define_method(ruby) do
result=self.send(ios)
case Accessibility.attribute_type(ios)
when :boolean
result=true if result==1
result=false if result==0||result.nil?
end
result
end
end
end

Accessibility::Container_Attributes.each do |ruby, ios|
if ruby==:accessibility_element_count
define_method(ruby) {self.send(ios)}
else
define_method(ruby) {|n| self.send(ios,n)}
end
end

Accessibility::Actions.each do |ruby,ios|
if ruby==:accessibility_scroll
define_method(ruby) {|direction| ios(direction)}
else
define_method(ruby) {ios}
end
end

def accessibility_traits=(traits)
bits=0
if traits.kind_of?(Fixnum)
bits=traits
elsif traits.kind_of?(Symbol)
bits=traits.accessibility_trait
elsif traits.kind_of?(Array)
traits.each {|trait| bits|=trait.accessibility_trait}
else
raise "Pass a bitmask, a symbol, or an array to accessibility_traits="
end
self.accessibilityTraits=bits
self
end

def inspect_accessibility_traits
traits=[]
Accessibility::Traits.each do |trait, bitmask|
if self.accessibility_traits&bitmask>0
name=trait.gsub(/_/,' ').capitalize
traits<<name
end
end
traits=["None"] if traits.empty?
	traits.join(', ')
end

if self.respond_to?(:method_added)
class << self
alias :method_added_motion_accessibility :method_added
Accessibility::Data[:object_method_added]=true
end
end

def self.method_added(name)
if self.respond_to?(:method_added_motion_accessibility)
self.method_added_motion_accessibility(name)
end
return if name=~/=$/
attributes=Accessibility::All_Attributes
return unless attributes.flatten.include?(name.to_sym)
if attributes.has_key?(name)
ruby=name
ios=attributes[name]
define_method(ios) {self.send(ruby)}
else
ios=name
ruby=attributes.rassoc(name).first
define_method(ruby) { self.send(ios)}
end
Accessibility.defined_attribute(self,ios)
end

end
