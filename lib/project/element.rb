class UIAccessibilityElement

def self.init_with_accessibility_container(container)
	UIAccessibilityElement.alloc.initWithAccessibilityContainer(container)
end

Accessibility::Element_Attributes.each do |ruby,ios|
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

def traits=(traits)
	self.accessibility_traits=traits
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

class NSObject

def accessibility_element_container?
	!self.accessibility_element_at_index(0).nil?
end

	def each_accessibility_element
		return unless self.accessibility_element_container?
		self.accessibility_element_count.times {|n| yield(self.accessibility_element_at_index(n))}
	end

end

