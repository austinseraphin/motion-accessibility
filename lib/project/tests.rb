module Accessibility
	module Test

		Tests = {
			basic: {
			accessibility_frame: [CGRect, "You must set an accessibility_frame to tell VoiceOver the bounds of the view." ],
				accessibility_activation_point: [CGPoint, "You must set an accessibility_activation_point so VoiceOver knows where to touch."]
		},
			NSObject: {
			accessibility_label: [String, "You must set an accessibility label to tell VoiceOver what to read."],
					is_accessibility_element: [true, "You must set is_accessibility_element=true to make VoiceOver aware of it."]
		},
			UIActionSheet: {
			is_accessibility_element: [false],
			accessibility_view_is_modal: [true]
		},
UIActivityIndicatorView: {
			accessibility_label: [String, "You must set the accessibility_label to the title of the activity indicator."],
accessibility_value: [String, "You must set the accessibility_value to the value of the indicator."],
accessibility_elements_hidden: [true]
		},
			UIAlertView: {}
		}

		def self.has_test?(classname)
Tests.has_key?(classname.to_s.to_sym)
		end

		def self.report(message)
			NSLog(message) unless RUBYMOTION_ENV=='test'
		end

		def self.run(obj)
classname=obj.class
classname=classname.superclass until has_test?(classname)
tests=Tests[:basic].clone
tests.merge!(Tests[classname.to_s.to_sym])
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
report message
end
	else
		unless expected==value
result&&=false
message||="#{attribute} must have the value #{expected}"
report message
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

