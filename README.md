# motion-accessibility

# Making accessibility more accessible.

https://github.com/austinseraphin/motion-accessibility

Motion-Accessibility wraps the UIAccessibility protocols in nice
ruby. I hope that making it easier will encourage developers to use it
more and make their apps accessible.

## Installation

Add this line to your application's Gemfile:

    gem 'motion-accessibility'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install motion-accessibility

## Usage

### UIAccessibility Informal Protocol

This informal protocol describes how to convey proper information to
VoiceOver, the piece of software which allows the blind to read the
screen. All of the UIAccessibility attributes you can define in a
UIView now have Ruby-like names.

#### Defining Attributes in a Custom Subclass

You can define these attributes in one of two ways. Firstly you can
define a function in a subclass of UIView.

```
class CustomView < UIView

def accessibility_label
"Hello."
end

end
```

Note that motion-accessibility uses some metaprogramming to accomplish
this. It tries to play nicely with other gems. If another gem has
already defined the `UIView.method_added` method, it will alias it and
run it before its own.

#### Defining Attributes in the Instanciation Code

You can also set these attributes once you've defined a view.

```
view=UIView.alloc.init
view.accessibility_label="Hello."
```

#### `accessibility_label`

What VoiceOver reads. The most important thing to define. Many standard views set the accessibility label automatically. For example, if you set the text of a UILabel, it will also set the accessibility label. However, if you make a custom view you will have to define it. If you set an image for a button, its title will default to the image name. This can have ugly results. Even more annoyingly, if you don't set a label a button will just read as "Button". Make sure to set this.

Labels briefly describe the element. They do not include the control type. They begin with a capitalized word and do not end with a period. Localize them when possible.

#### `accessibility_hint`

Hints describe the results of performing an action. Only provide one when not obvious. They briefly describe results. They begin with a verb and omit the subject. They use the third person singular declarative form - Plays music instead of play music. Imagine describing it to a friend. "Tapping the button plays music." They begin with a capitalized word and ends with a period. They do not include the action or gesture.  They do not include the name or type of the controller or view. Localized.

#### `accessibility_traits`

Traits describe an element's state, behavior, or usage. They tell
VoiceOver how to respond to a view. To combine them, use the binary or `|` operator.

The `accessibility_attribute=` method accepts a symbol or array of symbols, and applies the accessibility_attribute method to them. For example, if a view displays an image  that opens a link, you can do this.

```
class ImageLinkView < UIView
# ....  
def accessibility_traits
:image.accessibility_trait|:link.accessibility_trait
end
end
```

Or, to set it in an instance of a viewyou can do this.

```
view=UIView.alloc.init
view.accessibility_traits=[:image, :link]
```

##### :none
The element does nothing.
##### :button
The view acts like a button.
##### :link
The view opens a link in Safari.
##### :search_field
The view acts like a search field.
##### :image
The view displays an image.
##### :selected
For example, a selected row in a table, or segment in a segmented control.
##### :keyboard_key
The view behaves like a keyboard key.
##### :static_text
The view displays static text.
##### :summary_element
The view provides summary information when the application starts.
##### :plays_sound
The view plays its own sound when activated.
#### :starts_media_session
Silences VoiceOver during a media session that should not be interrupted. For example, silence VoiceOver speech while the user is recording audio.
#### :updates_frequently
Tells VoiceOver to avoid handling continual notifications. Instead it should poll for changes when it needs updated information.
#### :adjustable
The view has an adjustable value. Also see the `accessibility_increment` and `accessibility_decrement` methods.
#### :allows_direct_interaction
This tells VoiceOver to allow the user to interact directly with the view. For example, a piano keyboard.
#### :causes_page_turn
Causes an automatic page turn when VoiceOver finishes reading the text within it.
#### :not_enabled
Not enabled and does not respond to user interaction.

#### `accessibility_value`

The value reported in a slider, for example.

#### `accessibility_language`

The language used by VoiceOver to read the view.

#### `accessibility_frame`

The frame of the accessibility element. This defaults to the frame of the view.

#### `accessibility_activation_point`

The point activated when a VoiceOver user activates the view by double tapping it. This defaults to the center of the view. In other words, a VoiceOver can double-tap anywhere on the screen, but it will simulate a sighted user touching the center of the view.

#### `accessibility_view_is_modal`

Ignores elements within views which are siblings of the receiver. If you present a modal view and want VoiceOver to ignore other views on the screen, set this to true.

#### `should_group_accessibility_children`

VoiceOver gives two ways to browse the screen. The user can drag their finger around the screen and hear the contents. They can also swipe right or left with one finger to hear the next or previous element. Normally, VoiceOver reads from left to right, and from top to bottom. Sometimes this can get confusing, depending on the layout of the screen. Setting this to true tells VoiceOver to read the views in the order defined in the subviews array.

#### `accessibility_elements_hidden`

Tells VoiceOver to hid the subviews of this view.

#### `accessibility_element?`, or `is_accessibility_element`

Tells VoiceOver whether to regard this as something it can read or not. Standard views have this set to true. Custom views have this set to false.

#### `accessibility_identifier`

A unique identifier if you don't want to define the accessibility label.

### UIPickerView

If desired, you can use these methods to make your picker views more accessible. You only need to do this if the picker contains non-standard views.
#### `accessibility_label_for_component`
Accepts an integer and returns the accessibility label for the component.
#### `accessibility_hint_for_component `
Accepts an integer and returns the accessibility hint for the component.

### UIAccessibilityContainer Informal Protocol

The UIAccessibility Container informal protocol allows VoiceOver to handle a custom view which acts like a container. It  tells VoiceOver how to read the subviews in the proper order.
#### `accessibility_element_at_index`
Accepts an integer and returns the accessibility element.
#### `accessibility_element_count`
Returns the number of accessible elements.
#### `index_of_accessibility_element`
Accepts
### UIAccessibilityFocus Informal Protocol

This protocol lets you take actions if a view gains or loses VoiceOver's focus.
- `accessibility_element_did_become_focused`
- `accessibility_element_did_lose_focus`
- `accessibility_element_is_focused`

### UIAccessibilityReadingContent Informal Protocol

This protocol gives a seamless reading experience when dealing with
long pieces of text, such as a book.  -
#### `accessibility_content_for_line_number -`
Accepts an integer and returns the line of text to read.
#### `accessibility_frame_for_line_number -`
Accepts an integer and returns the frame which contains it.
#### `accessibility_line_number_for_point`
Accepts a CGPoint and returns the line number of the text to read.

### Notifications

The UIAccessibility notifications can either come from UIKit or from
an applications. You can observe them with the standard notification
center. You can post them with
`Accessibility.post_notification`. Motion-Accessibility adds an
accessibility_notification method to the Symbol class, so you can use
any of these symbols.

- :layout_changed
- :screen_changed
- :page_scrolled
- :announcement
- :announcement_did_finish
- :closed_captioning
- :guided_access
- :inverted_colors
- :mono_audio
- :voiceover

For example, if a view controller removes a subview and adds another,
you will want to post the layout changed notification. You can do this
with

```
Accessibility.post_notification(:layout_changed)
```

Much easier, don't you think?

#### Zoom Type

The :announcement_did_finish notification posts these. Use the
zoom_type method on the following symbols.

- :announcement_key_string_value
- :announcement_key_was_successful

### UIAccessibility Actions

These methods trigger when the VoiceOver user performs specific actions.

- `Accessibility.perform_escape`
- `Accessibility.perform_magic_tap`
- `Accessibility.scroll`
- `Accessibility.increment`
- `Accessibility.decrement`

#### Scroll Directions

Accessibility.scrolltakes one of the following scroll directions.

- :right
- :left
- :up
- :down
- :next
- :previous

## contributing


1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
