class Accessibility

Attributes = {
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

Traits = {
none: UIAccessibilityTraitNone,
button: UIAccessibilityTraitButton,
link: UIAccessibilityTraitLink,
search_field: UIAccessibilityTraitSearchField,
image: UIAccessibilityTraitImage,
selected: UIAccessibilityTraitSelected,
keyboard_key: UIAccessibilityTraitKeyboardKey,
static_text: UIAccessibilityTraitStaticText,
summary_element: UIAccessibilityTraitSummaryElement,
plays_sound: UIAccessibilityTraitPlaysSound,
starts_media_session: UIAccessibilityTraitStartsMediaSession,
updates_frequently: UIAccessibilityTraitUpdatesFrequently,
adjustable: UIAccessibilityTraitAdjustable,
allows_direct_interaction: UIAccessibilityTraitAllowsDirectInteraction,
causes_page_turn: UIAccessibilityTraitCausesPageTurn,
not_enabled: UIAccessibilityTraitNotEnabled
}

end

class Symbol

def accessibility_trait
if Accessibility::Traits[self]
Accessibility::Traits[self]
else
raise "Unknown accessibility trait #{trait}"
end
end

end
