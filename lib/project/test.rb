module Accessibility
	module Test

		Tests = {
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
			UIAlertView: {
		accessibility_label: nil,
		is_accessibility_element: false,
		test_subviews: true
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
			UIDatePicker: {
			accessibility_label: nil,
			is_accessibility_element: false,
			test_subviews: true
		},
			_UIDatePickerView: {
			accessibility_label: nil,
			is_accessibility_element: false
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
			UIView: {
			accessibility_label: nil,
			is_accessibility_element: false
		}
		}

		def self.object(obj)
			obj_tests=A11y::Test::Tests[:NSObject].clone
cl=obj.class
cl=cl.superclass until Tests[cl.to_s.to_sym]
cl=cl.to_s.to_sym
			Tests[cl].each do |attribute, test|
				obj_tests[attribute]=test
			end
obj_tests
		end

		def self.run(obj)
			tests=self.object(obj)
result=true
tests.each do |attribute, test|
	next if attribute=~/test/
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
NSLog message
end
	else
		unless expected==value
result&&=false
message||="#{attribute} must have the value #{expected}"
message=obj.inspect+": "+message
NSLog message
		end
	end
		end
if result&&obj.respond_to?(:subviews)&&obj.subviews
obj.subviews.each {|view| result=result&&A11y::Test.run(view)}	
end
	result
		end

	end
end

	class NSObject

		def accessible?
			A11y::Test.run(self)
		end

	end

