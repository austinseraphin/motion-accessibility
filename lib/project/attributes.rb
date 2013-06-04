class UIView

alias :accessibility_label :accessibilityLabel
alias :accessibility_label= :setAccessibilityLabel
alias :accessibility_hint :accessibilityHint
alias :accessibility_hint= :setAccessibilityHint
alias :accessibility_traits :accessibilityTraits
alias :accessibility_value :accessibilityValue
alias :accessibility_value= :setAccessibilityValue
alias :accessibility_language :accessibilityLanguage
alias :accessibility_language= :setAccessibilityLanguage
alias :accessibility_frame :accessibilityFrame
alias :accessibility_frame= :setAccessibilityFrame
alias :accessibility_activation_point :accessibilityActivationPoint
alias :accessibility_activation_point= :setAccessibilityActivationPoint
alias :accessibility_view_is_modal :accessibilityViewIsModal
alias :accessibility_view_is_modal= :setAccessibilityViewIsModal
alias :should_group_accessibility_children :shouldGroupAccessibilityChildren
alias :should_group_accessibility_children= :setShouldGroupAccessibilityChildren
alias :accessibility_elements_hidden :accessibilityElementsHidden
alias :accessibility_elements_hidden= :setAccessibilityElementsHidden


def accessibility_traits=(traits)
bits=0
if traits.kind_of?(Fixnum
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

end

