module Accessibility
	module Test

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
			accessibility_traits: UIAccessibilityTraitButton,
			is_accessibility_element: false
		},
			UICollectionReusableView: {
			accessibility_label: nil,
			is_accessibility_element: false},
			UILabel: {
			accessibility_traits: [UIAccessibilityTraitStaticText, "You must set accessibility_traits to :static_text"]
		},
			UIImage: {
			accessibility_label: nil,
			is_accessibility_element: false
		},
			UIImageView: {
			accessibility_label: nil,
			accessibility_traits: [UIAccessibilityTraitImage, "You must set accessibility_trait to :image"],
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

		def self.find_tests(obj, accessibility_test=nil)
			obj_tests=A11y::Test::Standard_Tests[:NSObject].clone
cl=obj.class
class_name=cl.to_s.to_sym
if accessibility_test
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

		def self.run(obj, accessibility_test=nil)
			Messages.clear
			tests=self.find_tests(obj, accessibility_test)
result=true
tests.each do |attribute, test|
	if test.kind_of?(Array)
	(expected, message)=test
	else
		expected=test
	end
	unless obj.respond_to?(attribute)
		raise "Unknown method #{attribute}"
	end
	value=obj.send(attribute)
	if expected.class==Class
unless value.class==expected
	result&&=false
message||="#{attribute} must have an object of type #{expected}"
message=obj.inspect+": "+message
Messages<<message
end
	elsif expected.kind_of?(Proc)
		r=expected.call(value)
		result=result&&r
		unless r
			message||="The test function for #{attribute} failed."
			message=obj.inspect+": "+message
			Messages<<message
		end
	else
		unless expected==value
result&&=false
message||="#{attribute} must have the value #{expected}"
message=obj.inspect+": "+message
Messages<<message
		end
	end
		end
if result&&obj.respond_to?(:subviews)&&obj.subviews
obj.subviews.each {|view| result=result&&A11y::Test.run(view)}	
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

		def accessible?
			A11y::Test.run(self)
		end

	end

