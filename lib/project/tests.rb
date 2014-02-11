module Accessibility
	module Test

		def self.report(message)
			NSLog(message) unless RUBYMOTION_ENV=='test'
		end

		def self.accessibility_label(obj)
unless obj.accessibility_label
			A11y::Test.report "You must set an accessibility label to tell VoiceOver what to read." 
		false
else
	true
end
		end

		def self.accessibility_frame(obj)
			raise "You must set an accessibility_frame to tell VoiceOver the bounds of the view." unless obj.accessibility_frame
		end

		def self.accessibility_activation_point(obj)
			raise "You must set the accessibility_activation_point to tell VoiceOver the point to touch when selecting this view." unless obj.accessibility_activation_point
		end

	end
end

