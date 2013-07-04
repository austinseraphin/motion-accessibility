class NSObject

Accessibility::Attributes.each do |ruby, ios|
next if ruby==:accessibility_traits=
if ruby=~/=$/
define_method(ruby) {|value| self.send(ios,value)}
elsif(ruby=~/^is_|\?$/)
define_method(ruby) do
result=self.send(ios)
result=true if result==1
result=false if result==0
result
end
else
define_method(ruby) {self.send(ios)}
end
end

Accessibility::Container_Attributes.each do |ruby, ios|
if ruby=="accessibility_element_count"
define_method(ruby) {self.send(ios)}
else
define_method(ruby) {|n| self.send(ios,n)}
end
end

Accessibility::Actions.each {|ruby,ios| define_method(ruby) {ios}}

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
end

if self.respond_to?(:method_added)
NSLog("motion-accessibility: aliasing method_added")
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
end

end
