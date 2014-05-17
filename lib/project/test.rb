module Accessibility
	module Test

		Options = {
			recurse: true
		}

		Standard_Tests = {
			NSObject: {
			accessibility_label: [String, "You must set an accessibility label to tell VoiceOver what to read."],
			accessibility_traits: [UIAccessibilityTraitNone, "You must set accessibility_trait to :none.accessibility_trait"],
accessibility_value: nil,
			accessibility_frame: [CGRect, "You must set an accessibility_frame to tell VoiceOver the bounds of the view." ],
				accessibility_activation_point: [CGPoint, "You must set an accessibility_activation_point so VoiceOver knows where to touch."],
				accessibility_path: nil,
accessibility_view_is_modal: false,
should_group_accessibility_children: false,
accessibility_elements_hidden: false,
					is_accessibility_element: [true, "You must set is_accessibility_element=true to make VoiceOver aware of it."]
		},
			UIActionSheet: {
			accessibility_label: nil,
			is_accessibility_element: false,
			accessibility_view_is_modal: true
		},
UIActivityIndicatorView: {
			accessibility_label: [String, "You must set the accessibility_label to the title of the activity indicator."],
accessibility_value: [String, "You must set the accessibility_value to the value of the indicator."],
accessibility_elements_hidden: true,
		is_accessibility_element: false
		},
			UIButton: {
			accessibility_label: [String,"You must set the accessibility_label. You can use the setTitle:forState method to do this on a button."],
			accessibility_traits: UIAccessibilityTraitButton,
		},
			UICollectionReusableView: {
			accessibility_label: nil,
			is_accessibility_element: false},
			UIImageView: {
			accessibility_label: nil,
			accessibility_traits: [UIAccessibilityTraitImage, "You must set accessibility_trait to :image"],
		is_accessibility_element: false
		},
			UILabel: {
			accessibility_label: [String, "You must set the accessibility_label. You can use the text method to do this."],
			accessibility_traits: [UIAccessibilityTraitStaticText, "You must set accessibility_traits to :static_text"]
		},
			UINavigationBar: {
accessibility_label: nil,
accessibility_traits: [Bignum, "Apple has this set to a non-standard value."],
accessibility_elements_hidden: false,
should_group_accessibility_children: true,
accessibility_identifier: [String, "You must set the accessibility_identifier to the title of the view. You can set the title of the view controller or of the navigation item."],
is_accessibility_element: false
		},
			_UINavigationBarBackground: {
			accessibility_label: nil,
			accessibility_traits: UIAccessibilityTraitImage,
			accessibility_elements_hidden: true,
		is_accessibility_element: false
		},
			UIPageControl: {
			accessibility_label: nil,
			is_accessibility_element: false,
			accessibility_value: [String, "You must set the accessibility_value to something meaningful, for example 'Page 1 of 1'"],
			accessibility_traits: UIAccessibilityTraitUpdatesFrequently
		},
			UISegment: {
			accessibility_label: String,
			accessibility_traits: [UIAccessibilityTraitButton, "You must make this a button by setting accessibility_trait to :button"],
			accessibility_value: String
		},
			UISegmentedControl: {
			accessibility_label: nil,
			is_accessibility_element: false,
			should_group_accessibility_children: true
		},
			UISlider: {
			accessibility_label: nil,
			accessibility_value: String,
			accessibility_traits: UIAccessibilityTraitAdjustable
		},
			_UIStepperButton: {
			accessibility_traits: [->(trait) {trait==UIAccessibilityTraitButton||trait==UIAccessibilityTraitButton|UIAccessibilityTraitNotEnabled},
				"You must set the accessibility_traits to either :adjustable or :adjustable, :not_enabled"],
		is_accessibility_element: false
		},
			UISwitch: {
			accessibility_label: nil,
			accessibility_traits: [->(t){t>65536||t==UIAccessibilityTraitButton},
				"You must set the accessibility_trait to :button"],
				accessibility_value: [String, "You must set the accessibility_value to \"1\" or \"0\""]
		},
UITextField: {
			accessibility_label: nil,
			accessibility_traits: [->(t){t==262144||t==UIAccessibilityTraitNone}, "Apple has this set to a non-standard value. If making a custom view you can just use :none"],
			accessibility_value: [->(value) {value}, "You must set the text of the textfield."],
		is_accessibility_element: false
		},
			UIView: {
			accessibility_label: nil,
			is_accessibility_element: false
		}
		}

		Custom_Tests = {
			UIView: {
			accessibility_label: [true, "Set the accessibility_label to tell VoiceOver what to say."],
			is_accessibility_element: [true, "Set is_accessibility_element to true to tell VoiceOver it can access this element."]
		}
		}

		Messages=Array.new

		def self.find_tests(obj)
			obj_tests=A11y::Test::Standard_Tests[:NSObject].clone
cl=obj.class
class_name=cl.to_s.to_sym
if obj.accessibility_test
	tests=self::Custom_Tests[class_name]||self::Standard_Tests[class_name]
else
	tests=self::Standard_Tests[class_name]
end
until tests do
	cl=cl.superclass
class_name=cl.to_s.to_sym
if accessibility_test
	tests=self::Custom_Tests[class_name]||self::Standard_Tests[class_name]
else
	tests=self::Standard_Tests[class_name]
end
end
			tests.each do |attribute, test|
				obj_tests[attribute]=test
			end
obj_tests
		end

		def self.run_test(obj, attribute, expected, message=nil)
	value=obj.send(attribute) if obj.respond_to?(attribute)
	result=true
	if expected.class==Class
if value.class!=expected
	result=false
message||="#{attribute} must have an object of type #{expected}"
message=obj.inspect+": "+message
Messages<<message
end
	elsif expected.kind_of?(Proc)
		r=expected.call(value)
		unless r
			result=false
			message||="The test function for #{attribute} failed."
			message=obj.inspect+": "+message
			Messages<<message
		end
	else
		unless expected==value
result=false
message||="#{attribute} must have the value #{expected}"
message=obj.inspect+": "+message
Messages<<message
		end
	end
	result
		end

		def self.run_tests(obj)
			Messages.clear
			tests=self.find_tests(obj)
	tests[:options]||={}
	tests[:options]=self::Options.merge(tests[:options])
result=true
tests.each do |attribute, test|
	next if attribute==:options
	if test.kind_of?(Array)
	(expected, message)=test
	result=result&&self.run_test(obj, attribute, expected, message)
	else
	result=result&&self.run_test(obj, attribute, test)
	end
end
if result&&obj.respond_to?(:subviews)&&obj.subviews
obj.subviews.each {|view| result=result&&A11y::Test.run_tests(view)}	
end
	result
		end

	end

def self.doctor(view=nil)
view.accessible? if view
	A11y::Test::Messages.each {|message| NSLog(message)}
	A11y::Test::Messages.empty?
end

end

	class NSObject

		attr_reader :accessibility_test

		def accessibility_test=(t)
			t=t.to_s.to_sym if t.kind_of?(Class)
			@accessibility_test=t if A11y::Test::Custom_Tests[t]||A11y::Test::Standard_Tests[t]
			@accessibility_test
		end

		def accessible?
			A11y::Test.run_tests(self)
		end

	end

