class Accessibility

Data={}

Attributes = {
:accessibility_identifier => :accessibilityIdentifier,
:accessibility_identifier= => :setAccessibilityIdentifier,
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
:accessibility_modal_view? => :accessibilityViewIsModal,
:should_group_accessibility_children => :shouldGroupAccessibilityChildren,
:group_accessibility_children? => :shouldGroupAccessibilityChildren,
:should_group_accessibility_children= => :setShouldGroupAccessibilityChildren,
:accessibility_elements_hidden => :accessibilityElementsHidden,
:accessibility_elements_hidden? => :accessibilityElementsHidden,
:accessibility_elements_hidden= => :setAccessibilityElementsHidden,
:accessibility_element_did_become_focused => :accessibilityElementDidBecomeFocused,
:accessibility_element_did_lose_focus => :accessibilityElementDidLoseFocus,
:accessibility_element_is_focused => :accessibilityElementIsFocused,
:accessibility_element_focused? => :accessibilityElementIsFocused,
:accessibility_element? => :isAccessibilityElement,
:is_accessibility_element => :isAccessibilityElement,
:is_accessibility_element= => :isAccessibilityElement=
}

Element_Attributes = {
:container => :accessibilityContainer,
:container= => :setAccessibilityContainer,
:frame => :accessibilityFrame,
:frame= => :setAccessibilityFrame,
:hint => :accessibilityHint,
:hint= => :setAccessibilityHint,
:label => :accessibilityLabel,
:label= => :setAccessibilityLabel,
:traits => :accessibilityTraits,
:value => :accessibilityValue,
:value= => :setAccessibilityValue,
:did_become_focused => :accessibilityElementDidBecomeFocused,
:did_lose_focus => :accessibilityElementDidLoseFocus,
:is_focused => :accessibilityElementIsFocused,
:focused? => :accessibilityElementIsFocused,
:is_accessibility_element => :isAccessibilityElement,
:is_accessibility_element => :setIsAccessibilityElement,
:accessibility_element? => :isAccessibilityElement
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
header: UIAccessibilityTraitHeader,
summary_element: UIAccessibilityTraitSummaryElement,
plays_sound: UIAccessibilityTraitPlaysSound,
starts_media_session: UIAccessibilityTraitStartsMediaSession,
updates_frequently: UIAccessibilityTraitUpdatesFrequently,
adjustable: UIAccessibilityTraitAdjustable,
allows_direct_interaction: UIAccessibilityTraitAllowsDirectInteraction,
causes_page_turn: UIAccessibilityTraitCausesPageTurn,
not_enabled: UIAccessibilityTraitNotEnabled
}

PickerView_Attributes = {
:accessibility_label_for_component => :accessibilityLabelForComponent,
:accessibility_abel_for_component= => :setAccessibilityLabelForComponent,
:accessibility_hint_for_component => :accessibilityHintForComponent,
:accessibility_hint_for_component= => :setAccessibilityHintForComponent
}

Container_Attributes = {
:accessibility_element_at_index => :accessibilityElementAtIndex,
:accessibility_element_count => :accessibilityElementCount,
:index_of_accessibility_element => :indexOfAccessibilityElement
}

Reading_Content = {
accessibility_content_for_line_number: :accessibbilityContentForLineNumber,
accessibility_frame_for_line_number: :accessibilityFrameForLineNumber,
accessibility_line_number_for_point: :accessibilityLineNumberForPoint,
accessibility_page_content: :accessibilityPageContent
}

Actions = {
:accessibility_decrement => :accessibilityDecrement,
:accessibility_increment => :accessibilityIncrement,
:accessibility_perform_escape => :accessibilityPerformEscape,
:accessibility_perform_magic_tap => :accessibilityPerformMagicTap,
:accessibility_scroll => :accessibilityScroll
}

All_Attributes=Attributes.merge(Container_Attributes).merge(Reading_Content).merge(Actions)

Notifications = {
:layout_changed => UIAccessibilityLayoutChangedNotification,
:screen_changed => UIAccessibilityScreenChangedNotification,
:page_scrolled => UIAccessibilityPageScrolledNotification,
:announcement => UIAccessibilityAnnouncementNotification,
:announcement_did_finish => UIAccessibilityAnnouncementDidFinishNotification,
:closed_captioning => UIAccessibilityClosedCaptioningStatusDidChangeNotification,
:guided_access => UIAccessibilityGuidedAccessStatusDidChangeNotification,
:invert_colors => UIAccessibilityInvertColorsStatusDidChangeNotification,
:mono_audio => UIAccessibilityMonoAudioStatusDidChangeNotification,
:voiceover => UIAccessibilityVoiceOverStatusChanged
}

def Accessibility.post_notification(notification, *args)
if(notification.kind_of?(Fixnum))
UIAccessibilityPostNotification(notification, *args)
elsif(notification.kind_of?(Symbol))
raise "You cannot post #{notification} as an accessibility notification" unless Notifications[notification].kind_of?(Fixnum)
UIAccessibilityPostNotification(Notifications[notification], *args)
else
raise "Unknown accessibility notification #{notification}"
end
end

Scroll_Directions = {
:right => UIAccessibilityScrollDirectionRight,
:left => UIAccessibilityScrollDirectionLeft,
:up => UIAccessibilityScrollDirectionUp,
:down => UIAccessibilityScrollDirectionDown,
:next => UIAccessibilityScrollDirectionNext,
:previous => UIAccessibilityScrollDirectionPrevious
}

Zoom = {
:announcement_key_string_value => UIAccessibilityAnnouncementKeyStringValue,
:announcement_key_was_successful => UIAccessibilityAnnouncementKeyWasSuccessful
}

end

class Symbol

def accessibility_trait
Accessibility::Traits[self]||(raise("Unknown accessibility trait #{trait}"))
end

def accessibility_notification
Accessibility::Notifications[self]||(raise "Unknown accessibility notification #{self}")
end

def accessibility_scroll_direction
Accessibility::Scroll_Directions[self]||(raise "Unknown accessibility scroll direction #{self}")
end

def accessibility_zoom_type
Accessibility::Zoom[self]||(raise("Unknown zoom type #{self}"))
end

end
