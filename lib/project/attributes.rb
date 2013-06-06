class UIView

Accessibility::Attributes.each do |ruby, ios|
next if ruby==:accessibility_traits=
if ruby=~/=$/
define_method(ruby) {|value| self.send(ios,value)}
else
define_method(ruby) {self.send(ios)}
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
end

if self.respond_to?(:method_added)
alias :method_added_accessibility :method_added
end

def self.method_added(name)
if self.respond_to?(:method_added_accessibility)
method_added_accessibility(name)
end
return if name=~/=$/
return unless Accessibility::Attributes.flatten.grep(%r{name.to_sym})
if Accessibility::Attributes.has_key?(name)
ruby=name
ios=Accessibility::Attributes[name]
define_method(ios) {self.send(ruby)}
else
ios=name
ruby=Accessibility::Attributes.rassoc(name).first
define_method(ruby) { self.send(ios)}
end
end

end
