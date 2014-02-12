module Accessibility
	module Test

		def self.report(message)
			NSLog(message) unless RUBYMOTION_ENV=='test'
		end

		def self.accessibility_label(obj)
unless obj.accessibility_label
			report "You must set an accessibility label to tell VoiceOver what to read." 
		false
else
	true
end
		end
	
		def self.accessibility_frame(obj)
			unless obj.accessibility_frame
				report "You must set an accessibility_frame to tell VoiceOver the bounds of the view." 
				false
			else
				true
			end
		end

	end
end

