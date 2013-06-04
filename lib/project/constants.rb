class Accessibility

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
