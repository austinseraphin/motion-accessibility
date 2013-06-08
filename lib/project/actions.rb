class Accessibility

def Accessibility.perform_escape
accessibilityPerformEscape
end

def Accessibility.perform_magic_tap
accessibilityPerformMagicTap
end

def Accessibility.scroll(direction)
if direction.kind_of?(Fixnum)
accessibilityScroll(direction)
elsif direction.kind_of?(Symbol)
accessibilityScroll(direction.accessibility_scroll_direction)
else
raise "Unknown accessibility scroll direction #{direction}"
end
end

def Accessibility.increment
accessibilityIncrement
end

def Accessibility.decrement
accessibilityDecrement
end

end
