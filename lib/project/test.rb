module Accessibility
	module Test

		Tests = {
			NSObject: {
			accessibility_label: [String, "You must set an accessibility label to tell VoiceOver what to read."],
			accessibility_traits: [0, "You must set accessibility_trait to :none.accessibility_trait"],
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
			accessibility_traits: [64, "You must set accessibility_traits to :static_text"]
		},
			UIDatePicker: {
			accessibility_label: nil,
			is_accessibility_element: false,
			test_subviews: true
		},
			_UIDatePickerView: {
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
NSLog message
end
	else
		unless expected==value
result&&=false
message||="#{attribute} must have the value #{expected}"
NSLog message
		end
	end
		end
if result&&tests[:test_subviews]
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

