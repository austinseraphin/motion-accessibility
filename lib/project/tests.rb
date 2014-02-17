module Accessibility
	module Test

		Tests = {
			NSObject: {
			accessibility_label: [String, "You must set an accessibility label to tell VoiceOver what to read."],
			accessibility_traits: [0, "You must set accessibility_trait to :none.accessibility_trait"],
accessibility_value: [nil],
			accessibility_frame: [CGRect, "You must set an accessibility_frame to tell VoiceOver the bounds of the view." ],
				accessibility_activation_point: [CGPoint, "You must set an accessibility_activation_point so VoiceOver knows where to touch."],
				accessibility_path: [nil],
accessibility_view_is_modal: [false],
should_group_accessibility_children: [false],
accessibility_elements_hidden: [false],
					is_accessibility_element: [true, "You must set is_accessibility_element=true to make VoiceOver aware of it."]
		},
			UIActionSheet: {
			accessibility_label: [nil],
			is_accessibility_element: [false],
			accessibility_view_is_modal: [true]
		},
UIActivityIndicatorView: {
			accessibility_label: [String, "You must set the accessibility_label to the title of the activity indicator."],
accessibility_value: [String, "You must set the accessibility_value to the value of the indicator."],
accessibility_elements_hidden: [true],
		is_accessibility_element: [false]
		},
			UIAlertView: {
		accessibility_label: [nil],
		is_accessibility_element: [false]
		}
		}
		def self.object(obj)
			obj_tests={}
cl=obj.class
cl=cl.superclass until Tests[cl.to_s.to_sym]
cl=cl.to_s.to_sym
			Tests[:NSObject].each {|attribute, test| obj_tests[attribute]=Tests[cl][attribute]||Tests[:NSObject][attribute]}
obj_tests
		end

		def self.run(obj)
			tests=self.object(obj)
result=true
tests.each_pair do |attribute, test|
	(expected, message)=test
	unless obj.respond_to?(attribute)
		raise "Unknown method #{attribute} for accessibility test for #{classname}. Please submit this bug."
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
	result
		end

	end
end

	class NSObject

		def accessible?
			A11y::Test.run(self)
		end

	end

