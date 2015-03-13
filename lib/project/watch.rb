return unless defined? WKInterfaceObject

class WKInterfaceObject

def inspect
	self.accessibility_label
end

Accessibility::Watch_Attributes.each do |ruby,ios|
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

def accessibility_traits=(traits)
	self.accessibility_traits=traits
end

if self.respond_to?(:method_added)
alias :method_added_accessibility_Watch :method_added
end

def self.method_added(name)
if self.respond_to?(:method_added_accessibility)
method_added_accessibility_Watch(name)
end
return if name=~/=$/
attributes=Accessibility::Watch_Attributes
return unless attributes.flatten.grep(%r{name.to_sym})
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


Accessibility::Image_Region=UIAccessibilityImageRegion if defined?(UIAccessibilityImageRegion)

