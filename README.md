# motion-accessibility

Making accessibility more accessible.

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

### UIView

All of the UIAccessibility attributes you can define in a UIView now have Ruby-like names.

- accessibility_identifier
- accessibility_label
- accessibility_hint
- accessibility_traits
- accessibility_value
- accessibility_language
- accessibility_frame
- accessibility_activation_point
- accessibility_view_is_modal
- should_group_accessibility_children
- accessibility_elements_hidden
- accessibility_element?, is_accessibility_element

#### Defining Attributes in a Custom Subclass

You can define these attributes in one of two ways. Firstly you can define a function in a subclass of UIView.

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

#### Setting Accessibility Traits

Instead of those long constants, motion-accessibility adds an
accessibility_traitmethod to the Symbol class. Just call it on one of
the symbols in this list.

- :none
- :button
- :link
- :search_field
- :image
- :selected
- :keyboard_key
- :static_text
- :summary_element
- :plays_sound
- :starts_media_session
- :updates_frequently
- :adjustable
- :allows_direct_interaction
- :causes_page_turn
- :not_enabled

The accessibility_traits method accepts a symbol or array of symbols, and applies the accessibility_attribute method to them. For example, if a view displays an image that acts like a button and opens a link in Safari when pressed, you can now do this.
```
class ButtonView < UIView
# ....
def accessibility_traits
:image.accessibility_trait|:link.accessibility_trait 
end
end
```

Or, to set it in an instance you can do this, note the array.
```
view=UIView.alloc.init
view.accessibility_traits=[:image, :link]
```

### UIPickerView

If desired, you can use these methods to make your picker views more accessible.
- accessibility_abel_for_component
- accessibility_hint_for_component 

### Custom Container Views

The UIAccessibility Container informal protocol allows VoiceOver to
handle a custom view which acts like a container. Just implement these
methods:
- accessibility_element_at_index
- accessibility_element_count
- index_of_accessibility_element

### UIAccessibility Focus Informal Protocol

This protocol lets you take actions if a view gains or loses VoiceOver's focus.
- accessibility_element_did_become_focused
- accessibility_element_did_lose_focus
- accessibility_element_is_focused

### UIAccessibility Reading Content Informal Protocol

This protocol gives a seamless reading experience when dealing with long pieces of text, such as a book.
- accessibility_content_for_line_number
- accessibility_frame_for_line_number
- accessibility_line_number_for_point

### Notifications

The UIAccessibility notifications can either come from UIKit or from an applications. You can observe them with the standard notification center. You can post them with `Accessibility.post_notification`. Motion-Accessibility adds an accessibility_notification method to the Symbol class, so you can use any of these symbols.
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

For example, if a view controller removes a subview and adds another, you will want to post the layout changed notification. You can do this with
```
Accessibility.post_notification(:layout_changed)
```
Much easier, don't you think?

#### Zoom Type
The :announcement_did_finish notification posts these.
- :announcement_key_string_value
- :announcement_key_was_successful


### UIAccessibility Actions
These methods trigger when the VoiceOver user performs specific actions.
- Accessibility.perform_escape
- Accessibility.perform_magic_tap
- Accessibility.scroll
- Accessibility.increment
- Accessibility.decrement

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
