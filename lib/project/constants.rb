module Accessibility

Data={}

Attributes = {
:accessibility_label => :accessibilityLabel,
:accessibility_label= =>  :setAccessibilityLabel,
:accessibility_hint => :accessibilityHint,
:accessibility_hint= => :setAccessibilityHint,
:accessibility_traits => :accessibilityTraits,
:accessibility_traits= => :setAccessibilityTraits,
:accessibility_value => :accessibilityValue,
:accessibility_value= => :setAccessibilityValue,
:accessibility_language => :accessibilityLanguage,
:accessibility_language= => :setAccessibilityLanguage,
:accessibility_frame => :accessibilityFrame,
:accessibility_frame= => :setAccessibilityFrame,
:accessibility_activation_point => :accessibilityActivationPoint,
:accessibility_activation_point= => :setAccessibilityActivationPoint,
:accessibility_path => :accessibilityPath,
:accessibility_path= => :setAccessibilityPath,
:accessibility_view_is_modal => :accessibilityViewIsModal,
:accessibility_view_is_modal= => :setAccessibilityViewIsModal,
:accessibility_modal_view? => :accessibilityViewIsModal,
:should_group_accessibility_children => :shouldGroupAccessibilityChildren,
:group_accessibility_children? => :shouldGroupAccessibilityChildren,
:should_group_accessibility_children= => :setShouldGroupAccessibilityChildren,
:accessibility_elements => :accessibilityElements,
:accessibility_elements= => :setAccessibilityElements,
:accessibility_elements_hidden => :accessibilityElementsHidden,
:accessibility_elements_hidden? => :accessibilityElementsHidden,
:accessibility_elements_hidden= => :setAccessibilityElementsHidden,
:accessibility_element_did_become_focused => :accessibilityElementDidBecomeFocused,
:accessibility_element_did_lose_focus => :accessibilityElementDidLoseFocus,
:accessibility_element_is_focused => :accessibilityElementIsFocused,
:accessibility_element_focused? => :accessibilityElementIsFocused,
:accessibility_element? => :isAccessibilityElement,
:is_accessibility_element => :isAccessibilityElement,
:is_accessibility_element= => :setIsAccessibilityElement,
:accessibility_custom_actions => :accessibilityCustomActions,
:accessibility_custom_actions= => :setAccessibilityCustomActions,
:accessibility_identifier => :accessibilityIdentifier,
:accessibility_identifier= => :setAccessibilityIdentifier
}

Element_Attributes = {
:container => :accessibilityContainer,
:container= => :setAccessibilityContainer,
:label => :accessibilityLabel,
:label= => :setAccessibilityLabel,
:hint => :accessibilityHint,
:hint= => :setAccessibilityHint,
:traits => :accessibilityTraits,
:value => :accessibilityValue,
:value= => :setAccessibilityValue,
:frame => :accessibilityFrame,
:frame= => :setAccessibilityFrame,
:did_become_focused => :accessibilityElementDidBecomeFocused,
:did_lose_focus => :accessibilityElementDidLoseFocus,
:is_focused => :accessibilityElementIsFocused,
:focused? => :accessibilityElementIsFocused
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

if UIDevice.currentDevice.systemVersion.to_f>=7.0
Speech_Attributes = {
:punctuation => UIAccessibilitySpeechAttributePunctuation,
:language => UIAccessibilitySpeechAttributeLanguage,
:pitch => UIAccessibilitySpeechAttributePitch
}
else
Speech_Attributes={}
end

PickerView_Attributes = {
:accessibility_label_for_component => :accessibilityLabelForComponent,
:accessibility_abel_for_component= => :setAccessibilityLabelForComponent,
:accessibility_hint_for_component => :accessibilityHintForComponent,
:accessibility_hint_for_component= => :setAccessibilityHintForComponent
}

Container_Attributes = {
:accessibility_element_count => :accessibilityElementCount,
:accessibility_element_at_index => :accessibilityElementAtIndex,
:index_of_accessibility_element => :indexOfAccessibilityElement
}

Reading_Content = {
accessibility_content_for_line_number: :accessibilityContentForLineNumber,
accessibility_frame_for_line_number: :accessibilityFrameForLineNumber,
accessibility_line_number_for_point: :accessibilityLineNumberForPoint,
accessibility_page_content: :accessibilityPageContent
}

Actions = {
:accessibility_decrement => :accessibilityDecrement,
:accessibility_increment => :accessibilityIncrement,
:accessibility_perform_escape => :accessibilityPerformEscape,
:accessibility_perform_magic_tap => :accessibilityPerformMagicTap,
:accessibility_scroll => :accessibilityScroll,
:accessibility_activate => :accessibilityActivate
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

Attribute_Types = {
:accessibilityIdentifier =>:string,
:accessibilityLabel => :string,
:accessibilityHint => :string,
:accessibilityTraits => :fixnum,
:accessibilityValue=>:string,
:accessibilityLanguage=>:string,
:accessibilityFrame=>:cgrect,
:accessibilityActivationPoint=>:cgpoint,
:accessibilityPath => :uibezierpath,
:accessibilityViewIsModal=>:boolean,
:shouldGroupAccessibilityChildren=>:boolean,
:accessibilityElementsHidden=>:boolean,
:isAccessibilityElement=>:boolean,
:accessibilityElements => :accessibility_elements
}

Default_Type_Values = {
:string => "Testing",
:boolean => true,
:fixnum => 23,
:cgrect=>CGRectMake(0,0,100,100),
:cgpoint=>CGPointMake(100,100),
:accessibility_elements => [UIView.new]
}

def self.attribute_type(attribute)
Attribute_Types[attribute]||nil
end

Defined_Attributes=Hash.new

def self.defined_attribute(class_name, attribute)
Defined_Attributes[class_name]||=Array.new
Defined_Attributes[class_name]<<attribute
end

def self.defined_attribute?(class_name, attribute)
attributes=Defined_Attributes[class_name]
return false if attributes.nil?
attributes.member?(attribute)
end

Touchable_Types = ["UITextField", "UIButton", "UIPickerView", "UIDatePicker",
"UISegmentedControl", "UISlider", "UIStepper", "UISwitch",
"UITableViewCell", "UITableViewCellAccessibilityElement", "UITabBarButton","UINavigationItemButtonView"]

Ignored_Views = ["UILayoutContainerView", "UITransitionView", "UINavigationTransitionView", "UIViewControllerWrapperView", "UITableViewCellContentView", "UINavigationItemView", "UITableViewWrapperView"]

Ignored_ImageViews = ["UINavigationBar", "UITabBar", "UITableView"]

Reverse_Views = ["UINavigationBar", "UITabBar"]

View_Names = {"UINavigationItemButtonView" => "Back Button"}

private
def compile_attributes
# Needed just to include these
view=UIView.new
view.accessibilityActivationPoint=CGPoint.new(100,100)
view.accessibilityViewIsModal=true
view.shouldGroupAccessibilityChildren=true
view.accessibilityElementsHidden=true
view.isAccessibilityElement=true
view.accessibilityTraits==0
view.accessibilityActivationPoint==nil
view.accessibilityViewIsModal==nil
view.shouldGroupAccessibilityChildren==nil
view.accessibilityElementsHidden==nil
view.isAccessibilityElement==true
view.indexOfAccessibilityElement(0)
end

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

def speech_attribute
Accessibility::Speech_Attributes[self]||(raise "Unknown speech attribute #{self}")
end

end

A11y=Accessibility unless defined? A11y
A11y::Custom_Action = UIAccessibilityCustomAction unless defined? A11y::Custom_Action

