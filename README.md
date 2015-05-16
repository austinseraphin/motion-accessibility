# motion-accessibility

# Making accessibility more accessible.

https://github.com/austinseraphin/motion-accessibility

Motion-accessibility provides the tools needed for sighted and blind iOS
RubyMotion developers to make their apps more accessible. It wraps Apple’s
UIAccessibility protocols in Ruby, and provides an accessibility inspector. It
has a console for blind developers, since the iOS simulator doesn’t work well
with VoiceOver. It also has automated accessibility testing for your views, and
the accessibility doctor will help diagnose your problems and tell you how to
fix them. You can build accessibility testing into your specs, so you will
never break VoiceOver compatibility!

## Installation

Add this line to your application's Gemfile:

    gem 'motion-accessibility'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install motion-accessibility

## Usage
### The Motion-Accessibility Console

The motion-accessibility console gives you a way to interact with a running
application through a purely textual interface. This works well for blind
developers and command line users.

#### Enabling the Console

To enable the console, you can do one of two things. If you would just like to try it, type `include Accessibility::Console` at a REPL prompt. If you would like to use it in your application, add `require motion-accessibility-console` to your Rakefile. You have to do this even if you use bundler.

#### `browse` or `b`

The `browse` or `b` command lets you examine the view hierarchy in a
speech-friendly way. This lets you see all the relevant views displayed in your
running application. It will detect if the screen has changed and refresh
itself automatically.

The following examples come from the sample app included with motion-accessibility.

``` (main)> browse Browsing  UIWindow 1 UIView with 3 subviews 2
UINavigationBar with 2 subviews 3 UITabBar with 3 subviews => nil ```

If a view has subviews, you can browse that view.

```
((main)> b 1
Browsing  UIView
0 Superview UIWindow 
1 UILabel Hello! 
2 Touchable UITextField  
3 Touchable UIButton Update 
=> nil
```

You can return to the top of the view hierarchy by using `:top`. This also
refreshes the browser.

You can refresh a table with `:refresh`.

You may pass the `:scroll` keyword to scroll a UIScrollView or descendants,
such as a UITableView. This still has some minor issues .

#### `view` or `v`

The `view` or `v` command simply returns the current view. If you have just
browsed a view, it will return that. Otherwise, you may specify the view you
wish to browse. Note that for all the commands, you may either use its number
or accessibility label.

```
(main)> v 1
=> #<UILabel:0x8feda00>
```

#### `touch`
The `touch` command lets you interact with the various controls. It works on
all standard UIControls. `touch` can accept an argument depending on the type
of control. For example, you can pass a UITextField a string to set its value.

```
(main)> touch 2,"Motion-accessibility rocks!"
Browsing  UIView
0 Superview UIWindow 
1 UILabel Hello! 
2 Touchable UITextField Motion-accessibility rocks! 
3 Touchable UIButton Update 
=> nil
```

UIButtons can take a UIControlEvent, but default to
`UIControlEventTouchUpInside`. Note here the use of an accessibility label to
reference the view.

```
(main)> touch "update"
Browsing  UIView
0 Superview UIWindow 
1 UILabel Motion-accessibility rocks! 
2 Touchable UITextField Motion-accessibility rocks! 
3 Touchable UIButton Update 
=> nil
```

### The Accessibility Inspector

You can easily see the state of any of the following attributes and methods by
using the accessibility inspector. Just call `Accessibility.inspect` and pass
any object as an argument.

```
(main)> A11y.inspect label
#<UILabel:0xb438140>
Accessibility label: Hello!
Accessibility hint: nil
Accessibility traits: Static text
Accessibility value: nil
Accessibility language: nil
Accessibility frame: x=0.0 y=0.0 width=100.0 height=100.0
Accessibility activation point: x=50.0 y=50.0
Accessibility path: nil
Accessibility view is modal: false
Should group accessibility children: false
Accessibility elements: nil
Accessibility elements hidden: false
Is accessibility element: true
Accessibility custom actions: nil
Accessibility identifier: nil
Accessible: true
=> nil
```

By the way, `a11y` stands for `accessibility`, because it has a, then 11
letters, then y. Hence, you can use `A11y.inspect` as a shortcut.

### Automated Accessibility Testing

Below  you will find detailed documentation about all of the accessibility
protocols. Don’t feel overwhelmed. The accessibility inspector will tell you
exactly what you have to do. Let’s start by creating an unlabeled button, the
bane of all VOiceOver users.

```
(main)> button=UIButton.new
=> #<UIButton:0xd7831a0>
(main)> A11y.inspect button
#<UIButton:0xd7831a0>
Accessibility label: nil
Accessibility hint: nil
Accessibility traits: Button
Accessibility value: nil
Accessibility language: nil
Accessibility frame: x=0.0 y=0.0 width=0.0 height=0.0
Accessibility activation point: x=0.0 y=0.0
Accessibility path: nil
Accessibility view is modal: false
Should group accessibility children: false
Accessibility elements hidden: false
Is accessibility element: false
Accessibility identifier: nil
Accessible: false
2014-05-27 19:02:50.209 motion-accessibility[8851:70b] #<UIButton:0xd7831a0>: You must set the accessibility_label. You can use the setTitle:forState method to do this on a button.
2014-05-27 19:02:50.223 motion-accessibility[8851:70b] #<UIButton:0xd7831a0>: You must set is_accessibility_element=true to make VoiceOver aware of it. This will often happen automatically when a view becomes visible by giving it a frame and adding it to a subview.
=> #<UIButton:0xd7831a0>
```

This incorporates two features discussed below.

#### `accessible?`
Call the `accessible?` predicate on any object to determine its accessibility.
Like all predicates it returns true or false. You can include this in your
specs. If you build in accessibility testing you will never break
accessibility, something even worse than no accessibility at all. For example,
if you have a variable `@label` which contains a label, you could write: ```
@label.should.be.accessible ``` So simple! This works recursively. Say you run
some functional tests on a view controller.

```
tests Test_Controller
it “#accessible?`
controller.should.be.accessible
end
```

Or for the ultimate in laziness:

```
before do
@app=UIApplication.sharedApplication
end

it “accessible?” do
@app.should.be.accessible
end
```
You may not want to do this however, because it can get confusing navigating
down subview hierarchies, though it will report the path taken. Still, better
to do that then nothing at all.

#### `Accessibility.doctor`
The accessibility doctor will report on what you have to do. It writes this to
the NSLog. If given no arguments it will report on the last object called with
the `accessible?` predicate. It returns the object with the problem, or nil if
it finds nothing wrong. The accessibility inspector returns this as well. If a
spec fails, `accessible?` will call this automatically..

#### `accessibility_test`
Finally, you can specify which accessibility test applies to an object by
setting this value. You may do this in the same way you set other attributes.
You can use a setter:

```
view=UIView.new
view.accessibility_test=:UILabel
```


Or you may define it in a class. If you do this make sure that it returns a symbol of the class you want to test against, since it has no error checking unlike the setter.

```
class Custom_View < UIView

def accessibility_test
:UILabel
end

end
```

#### Accessibility vs. Usability

A difference exists between accessibility and usability, though often the two
get lumped together under the umbrella of the former. Accessibility refers to
whether or not a user can view and interact with something in a meaningful way.
In this case, this means making VoiceOver aware of the different elements of
your app. Usability gets into more intangible realms, and has to do with
whether or not it actually makes sense to a user. In this case this means a
blind human using VoiceOver, and only a blind human using VoiceOver can tell
you this. A computer can test for accessibility, but only a human can test for
usability.

### UIAccessibility Informal Protocol

This informal protocol describes how to convey proper information to VoiceOver,
the piece of software which allows the blind to read the screen. All of the
UIAccessibility attributes   now have Ruby-like names. Just like the protocol,
these methods belong to the NSObject class, so you can use them anywhere.
Usually, you will define them for a UIView.

#### Defining Attributes in a Custom Subclass

You can define these attributes in one of two ways. Firstly you can define a
method in a subclass of UIView.

```
class CustomView < UIView

def accessibility_label
"Hello."
end

end
```

Note that motion-accessibility uses some metaprogramming to accomplish this. It
tries to play nicely with other gems. If another gem has already defined the
`NSObject.method_added` method, it will alias it and run it before its own.

#### Defining Attributes in the Instanciation Code

You can also set these attributes once you've defined a view.

```
view=UIView.alloc.init
view.accessibility_label="Hello."
```

#### `accessibility_label`

What VoiceOver reads. The most important thing to define. Many standard views
set the accessibility label automatically. For example, if you set the text of
a UILabel, it will also set the accessibility label. However, if you make a
custom view you will have to define it. If you set an image for a button, its
title will default to the image name. This can have ugly results. Even more
annoyingly, if you don't set a label a button will just read as "Button". Make
sure to set this.

Labels briefly describe the element. They do not include the control type. They
begin with a capitalized word and do not end with a period. Localize them when
possible.

#### `accessibility_hint`

Hints describe the results of performing an action. Only provide one when not
obvious. They briefly describe results. They begin with a verb and omit the
subject. They use the third person singular declarative form - Plays music
instead of play music. Imagine describing it to a friend. "Tapping the button
plays music." They begin with a capitalized word and end with a period. They do
not include the action or gesture.  They do not include the name or type of the
controller or view. Localized.

#### `accessibility_traits`

Traits describe an element's state, behavior, or usage. They tell VoiceOver how
to respond to a view. To combine them, use the single vertical bar  `|` binary
or operator. Remember to call `super.accessibility_traits` if defining them in
a method.

The `accessibility_traits=` method also accepts a symbol or array of symbols,
and applies the accessibility_traits method to them. For example, if a view
displays an image  that opens a link, you can do this.

```
class ImageLinkView < UIView
# ....  
def accessibility_traits
super.accessibility_traits|:image.accessibility_trait|:link.accessibility_trait
end
end
```

Or, to set it in an instance of a view you can do this.

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
VoiceOver will report the element as selected. For example, a selected row in a
table, or segment in a segmented control.
##### :keyboard_key
The view behaves like a keyboard key.
##### :header
The view contains a header. VoiceOver will announce this as a heading.
VoiceOver allows for navigation between headings. This gives quick access to
different sections.
##### :static_text
The view displays static text.
##### :summary_element
The view provides summary information when the application starts.
##### :plays_sound
The view plays its own sound when activated.
#### :starts_media_session
Silences VoiceOver during a media session that should not be interrupted. For
example, silence VoiceOver speech while the user is recording audio.
#### :updates_frequently
Tells VoiceOver to avoid handling continual notifications. Instead it should
poll for changes when it needs updated information. You do this with the
notifications discussed below.
#### :adjustable
The view has an adjustable value. Also see the `accessibility_increment` and
`accessibility_decrement` methods.
#### :allows_direct_interaction
This tells VoiceOver to allow the user to interact directly with the view. For
example, a piano keyboard.
#### :causes_page_turn
Causes an automatic page turn when VoiceOver finishes reading the text within it.
#### :not_enabled
Not enabled and does not respond to user interaction.

#### `accessibility_value`

The value reported in a slider, for example.

#### `accessibility_language`

The language used by VoiceOver to read the view.

#### `accessibility_frame`

The frame of the accessibility element. This defaults to the frame of the view. Remember to give it in screen coordinates, not the coordinates of the view.

#### `accessibility_activation_point`

The point activated when a VoiceOver user activates the view by double tapping
it. This defaults to the center of the view. In other words, a VoiceOver can
double-tap anywhere on the screen, but it will simulate a sighted user touching
the center of the view.

#### `accessibility_path`

If nil, the default, VoiceOver uses the `accessibility_frame` to highlight the
element. If set, it will use the path. This method accepts a `UIBezierPath`.

#### `accessibility_modal_view?` or `accessibility_view_is_modal`

Ignores elements within views which are siblings of the receiver. If you
present a modal view and want VoiceOver to ignore other views on the screen,
set this to true.

####  `group_accessibility_children?` or `should_group_accessibility_children`

VoiceOver gives two ways to browse the screen. The user can drag their finger
around the screen and hear the contents. They can also swipe right or left with
one finger to hear the next or previous element. When swiping to the next
element, VoiceOver reads the elements from left to right, and from top to
bottom. Sometimes this can get confusing, depending on the layout of the
screen. Setting this to true tells VoiceOver to read the views in the order
defined in the subviews array.

#### `accessibility_elements`

An array which contains the elements which VoiceOver should access. New in iOS
8, this offers a much easier way to create accessibility containers and their
elements. Simply pass an array with the views.

```
sample=UIView.new
label=UILabel.new
button=UIButton.new
sample.accessibilitly_elements = [label, button]
```

#### `accessibility_elements_hidden?` or `accessibility_elements_hidden`

A boolean value which tells VoiceOver to hide the subviews of this view.

#### `accessibility_element?`, or `is_accessibility_element`

Tells VoiceOver whether to regard this as something it can read or not.
Standard views have this set to true. Custom views have this set to false.

#### `accessibility_custom_actions`

iOS 8 offers the ability to allow a VoiceOver user to perform custom actions on
a view. For example, if you have a view which responds to a non-standard wiping
gesture which a VoiceOver user cannot execute, you can implement these actions
to allow them to swipe through a list and select one.

##### Creating a Custom Action

Custom actions belong to the `A11y::Custom_Action` class. Just call the
`initWithName:target:selector` method. It takes the following parameters:
- Name: The name of the action read by VoiceOver
- Target: The object which receives the message to perform the action, usually
   `self`.
- Selector: A string containing the name of the method to call when selected

```
(main)> action=A11y::Custom_Action.alloc.initWithName("Sample Action", target: self, selector: 'sample_action')
=> #<Accessibility::Custom_Action:0xb42e270>
```

##### Using a Hash

Instead of passing an array of custom actions to
`accessibility_custom_actions`, you may provide an array of hashes to create
them.

```
(main)> test_view=UIView.new
=> #<UIView:0xb435030>
(main)> test_view.accessibility_custom_actions = [{name: 'Test', target: self, selector: 'test_action'}, {name: 'Another test', target: self, selector: 'another_test_action'}]
=> [#<Accessibility::Custom_Action:0x10c78d90>, #<Accessibility::Custom_Action:0x10c68f10>]
```

You can then see them in the inspector.

```
(main)> A11y.inspect test_view
#<UIView:0xb435030>
Accessibility label: nil
Accessibility hint: nil
Accessibility traits: None
Accessibility value: nil
Accessibility language: nil
Accessibility frame: x=0.0 y=0.0 width=0.0 height=0.0
Accessibility activation point: x=0.0 y=0.0
Accessibility path: nil
Accessibility view is modal: false
Should group accessibility children: false
Accessibility elements: nil
Accessibility elements hidden: false
Is accessibility element: false
Accessibility custom actions: ["Test", "Another test"]
Accessibility identifier: nil
Accessible: true
=> nil
```

#### `accessibility_identifier`

A unique identifier if you don't want to define the accessibility label.

### UIPickerView

If desired, you can use these methods to make your picker views more
accessible. You only need to do this if the picker contains non-standard views.
#### `accessibility_label_for_component`
Accepts an integer and returns the accessibility label for the component.
#### `accessibility_hint_for_component `
Accepts an integer and returns the accessibility hint for the component.

### UIAccessibility Actions

These methods trigger when the VoiceOver user performs specific actions. You
can implement then in a UIView or an accessibility element.

#### `accessibility_activate`

New in iOS 7, this method performs a custom action when a VoiceOver double-taps
the view. You can use this if the view uses a custom gesture, for example. It
returns true or false depending on the success of the action.

#### `accessibility_perform_escape`

VoiceOver has a special two-finger scrub gesture designed to act as a back
button. The standard back button of a UINavigationController implements this
method. It dismisses a modal view, and returns the success or failure of the
action. For example, you could use this to dismiss a popover.

#### `Accessibility_perform_magic_tap`

VoiceOver has a special two-finger double-tap. This method should toggle the
most important state of the program. For example, if a song plays it will pause
and resume the song. If on a telephone call, doing a magic tap will end it.

#### `accessibility_scroll`

VoiceOver uses three-finger swipes to scroll the screen. These gestures will
trigger this method. It accepts a scroll direction as a parameter. If the
scrolling succeeds, it should return true and post a :scroll notification. 

#### Scroll Directions

`accessibility_scroll` takes one of the following scroll directions.

- :right
- :left
- :up
- :down
- :next
- :previous

#### `accessibility_increment`

Increments the value of the accessibility element. Make sure to have the
:adjustable accessibility trait set for this to work.

#### `accessibility_decrement`

Decrements the value of the accessibility element. Make sure to have the :adjustable accessibility trait set for this to work.

### Accessibility::Element

If you have something in your view that does not inherit from UIView or
UIControl and you want to make it accessible, you need to define it as an
accessibility element. Accessibility elements belong to an accessibility
container, in other words the view which contains them. To create one, just
call `Accessibility::Element.init_with_accessibility_container` with the
container, usually self. Like a UIView, an accessibility element has
attributes, and you get and set them in exactly the same way.

```
class CustomView < UIView

def initWithFrame(frame)
super
# …
accessibility=Accessibility::Element.new(self)
accessibility.label="Hello."
accessibility.hint=“Presses the magic button”
accessibility.frame=view.frame
accessibility.traits=:button
end

end
```

#### Container

The container of the accessibility element.

#### `label`

The accessibility label.

#### `hint`

The accessibility hint.

#### `frame`

The frame which VoiceOver should consider as the element. In a UIView this would default to the frame of the view.

#### `traits`

The accessibility traits. This works exactly like UIView.

#### `value`

The value of the element, if applicable.

#### `is_accessibility_element` or `accessibility_element?`

Returns true if VoiceOver should consider this an accessibility element. Note
that you can only use `is_accessibility_element?=` as a setter.

### UIAccessibilityContainer Informal Protocol

The UIAccessibility Container informal protocol allows VoiceOver to handle a
custom view which acts like a container. It  tells VoiceOver how to read the
subviews in the proper order. It contains accessibility elements. Just
implement these methods in a subclass of UIView.

#### `accessibility_element_at_index`
Accepts an integer and returns the accessibility element. You can  use the standard `Array#[]` method for this.
#### `accessibility_element_count`
Returns the number of accessible elements. You can use `Array#length` for this.
#### `index_of_accessibility_element`
Accepts an accessibility element and returns its index as an integer. You can
use the `Array#index` method for this.
#### `accessibility_element_container?`
Returns true if the object behaves like a container.

### UIAccessibilityFocus Informal Protocol

This protocol lets you take actions if a view gains or loses VoiceOver's focus.
Note that if you use these in an Accessibility::Element that you can leave off
the `accessibility_element_` prefix.
#### `accessibility_element_did_become_focused`
Triggered when the accessibility element becomes focused by VoiceOver.
#### `accessibility_element_did_lose_focus`
Triggered when the accessibility element loses VoiceOver's focus.
#### `accessibility_element_focused?` or `accessibility_element_is_focused`
Returns true if the element currently has VoiceOver focus.

### UIAccessibilityReadingContent Informal Protocol

This protocol gives a seamless reading experience when dealing with
a UIView which contains long pieces of text, such as a book.  -
#### `accessibility_content_for_line_number -`
Accepts an integer and returns the line of text to read.
#### `accessibility_frame_for_line_number -`
Accepts an integer and returns the frame which contains it.
#### `accessibility_line_number_for_point`
Accepts a CGPoint and returns the line number of the text to read.

### Notifications

The UIAccessibility notifications can either come from UIKit or from
applications. You can observe them with the standard notification center. You
can post them with `Accessibility.post_notification`. It takes one of the
following symbols as a parameter. Many notifications have additional parameters
as well. Motion-Accessibility adds an accessibility_notification method to the
Symbol class.

For example, if a view controller removes a subview and adds another, you will want to post the screen changed notification. You can do this with

```
Accessibility.post_notification(:screen_changed)
```

Much easier, don't you think?

#### :layout_changed
Your application should post this notification when a  part of the screen's
layout changes. It has one parameter. You can provide a string which VoiceOver
should speak. You can also provide an accessibility element, such as a UIView,
and VoiceOver will move there.
#### :screen_changed
Your application should post this notification when a major part of the screen
changes. It has the same parameter as `:layout_changed`.
#### :page_scrolled
Post this notification after calling `Accessibility.scroll`. Include a string
which describes the scrolling action, for example "Page 3 of 10".
#### :announcement
Post this notification to make VoiceOver output something. Just include the
string.
#### :announcement_did_finish
UIKit posts this announcement when VoiceOver finishes announcing something. It
accepts a dictionary with the following keys as a parameter. Use the zoom_type
method on these symbols.
- :announcement_key_string_value
- :announcement_key_was_successful
#### :closed_captioning
UIKit posts this when the user toggles closed captioning.
#### :guided_access
UIKit posts this when the user toggles guided access.
#### :inverted_colors
UIKit posts this when the user toggles inverted colors.
#### :mono_audio
UIKit posts this when the user toggles mono audio.
#### :voiceover
UIKit posts this when the user toggles VoiceOver.
#### :bold_text
UIKit posts this when the user toggles the Bold Text accessibility setting.
#### :darker_colors
UIKit posts this when the user toggles the Darker Colors accessibility setting.
#### :grayscale
Posted when the user toggles the Grayscale accessibility setting
#### :reduce_motion
Posted when the user toggles the Reduce Motion accessibility seting. This can
help users who feel dizzy by all the fancy animations.
#### :reduce_transparency
Posted when the user toggles the Reduce Transparency accessibility setting.
#### :speak_selection
Posted when the user toggles the Speak Selection setting located in Accessibility -> Speech
#### :speak_screen
Posted when the user toggles the Speak Screen setting located under Accessibility -> Speech
#### :switch_control
Posted when the user toggles use of a switch control
#### :switch_control_identifier
Contains the unique identifier of the switch control
#### :resume_assistive_technology
Post this notification to resume VoiceOver or other assistive technology

#### :pause_assistive_technology
Post this notification to pause VoiceOver or other assistive technology

### Determining the Status of Accessibility Components
You can use these handy methods to determine the status of different
accessibility components. They take no parameters and return true or false.

- `Accessibility.voiceover_running?`
- `Accessibility.closed_captioning_enabled?`
- `Accessibility.guided_access_enabled?`
- `Accessibility.invert_colors_enabled?`
- `Accessibility.mono_audio_enabled?`
- `Accessibility.darker_system_colors_enabled?`
	- `Accessibility.bold_text_enabled?`
- `Accessibility.grayscale_enabled?`
- `Accessibility.reduce_motion_enabled?`
- `Accessibility.reduce_transparency_enabled?`

- `Accessibility.speak_selection_enabled?`
- `Accessibility.speak_screen_enabled?`
- `Accessibility.switch_control_running?`


Additionally, these two methods relate to the Zoom screen magnification
software.

#### `Accessibility.zoom_focused_changed`
This notifies Zoom that an app's focus has changed. It takes a zoom type
described above, a frame, and the view containing the frame.
#### `Accessibility.register_gesture_conflicts_with_zoom`
This issues a dialog to the user when a three-fingered gesture conflicts with
Zoom. It lets them choose to disable Zoom or continue.

### Speech Attributes

iOS 7 adds some speech attributes to use in attributed strings. To get them,
just call the `speech_attribute` method on the following symbols.
- `:punctuation`
- `:language`
- `:pitch`

### The Apple Watch

Currently limited support for the APple Watch exists. For one thing, nobody can
get one yet. For another, RubyMotion does not yet allow running specs on an
Apple Watch extension. Currently the gem provides wrappers for the Watchkit
methods. Note that Watchkit only provides the setters, not the getters, since
you cannot retrieve values from the running extension.

#### `accessibility_label`
The accessibility label.
#### `accessibility_hint`
The accessibility hint.
#### accessibility_traits
The accessibility traits. Takes the same arguments as the standard method.
#### accessibility_value
The accessibility value.
#### `is_accessibility_element`
Determines if VoiceOver should interact with the element.
#### `accessibility_image_regions`

Unique to WatchKit, this method accepts an array of Accessibility::Image_Region
objects. Each of these objects consists of a `label` and a `frame` to define
the accessible parts of an image.

## contributing


1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## A Special Offer for You

I do [freelance accessibility consulting.](http://austinseraphin.com) If you use my gem I will give you a discount. Contact me for more information.
