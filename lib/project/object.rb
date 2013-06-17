class NSObject

Accessibility::Attributes.each do |ruby, ios|
next if ruby==:accessibility_traits=
if ruby=~/=$/
define_method(ruby) {|value| self.send(ios,value)}
else
define_method(ruby) {self.send(ios)}
end
end

Accessibility::Container_Attributes.each do |ruby, ios|
if ruby=="accessibility_element_count"
define_method(ruby) {ios}
else
define_method(ruby) {|n| ios(n)}
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
class << self
alias :method_added_accessibility :method_added
end
end

def self.method_added(name)
if self.respond_to?(:method_added_accessibility)
method_added_accessibility(name)
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
