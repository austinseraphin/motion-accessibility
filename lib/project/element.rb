class UIAccessibilityElement

def initialize(container)
raise "Please initialize with a container, usually self." unless container
UIAccessibilityElement.alloc.initWithAccessibilityContainer(self)
end

alias :init_with_accessibility_container :initialize

Accessibility::Element_Attributes.each do |ruby,ios|
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
OAself.accessibilityTraits=bits
end

if self.respond_to?(:method_added)
alias :method_added_accessibility :method_added
end

def self.method_added(name)
if self.respond_to?(:method_added_accessibility)
method_added_accessibility(name)
end
return if name=~/=$/
attributes=Accessibility::Element_Attributes
return unless attributes.flatten.grep(%r{name.to_sym})
if attributes.has_key?(name)
ruby=name
ios=attributes[name]
if ios==:accessibilityElementIsFocused
	raise "You cannot define #{ruby}"
end
define_method(ios) {self.send(ruby)}
else
ios=name
ruby=attributes.rassoc(name).first
define_method(ruby) { self.send(ios)}
end
end

end

Accessibility::Element=UIAccessibilityElement
