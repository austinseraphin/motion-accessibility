class UIView

Accessibility_Attributes = {
:accessibility_label => :accessibilityLabel,
:accessibility_label= =>  :setAccessibilityLabel,
:accessibility_hint => :accessibilityHint,
:accessibility_hint= => :setAccessibilityHint,
:accessibility_traits => :accessibilityTraits,
:accessibility_value => :accessibilityValue,
:accessibility_value= => :setAccessibilityValue,
:accessibility_language => :accessibilityLanguage,
:accessibility_language= => :setAccessibilityLanguage,
:accessibility_frame => :accessibilityFrame,
:accessibility_frame= => :setAccessibilityFrame,
:accessibility_activation_point => :accessibilityActivationPoint,
:accessibility_activation_point= => :setAccessibilityActivationPoint,
:accessibility_view_is_modal => :accessibilityViewIsModal,
:accessibility_view_is_modal= => :setAccessibilityViewIsModal,
:should_group_accessibility_children => :shouldGroupAccessibilityChildren,
:should_group_accessibility_children= => :setShouldGroupAccessibilityChildren,
:accessibility_elements_hidden => :accessibilityElementsHidden,
:accessibility_elements_hidden= => :setAccessibilityElementsHidden
}

Accessibility_Attributes.each do |ruby, ios|
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
return unless Accessibility_Attributes.flatten.grep(%r{name.to_sym})
if Accessibility_Attributes.has_key?(name)
ruby=name
ios=Accessibility_Attributes[name]
define_method(ios) {self.send(ruby)}
else
ios=name
ruby=Accessibility_Attributes.rassoc(name).first
define_method(ruby) { self.send(ios)}
end
end

end
