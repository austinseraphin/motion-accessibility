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

		def self.accessibility_activation_point(obj)
			unless obj.accessibility_activation_point
				report "You must set an accessibility_activation_point so VoiceOver knows where to touch."
				false
			else
				true
			end
		end

		def self.is_accessibility_element(obj)
			unless obj.accessibility_element?
				report "You must set is_accessibility_element=true to make VoiceOver aware of it."
				false
			else
				true
			end
		end

		def self.nsobject(obj)
			result=true
			result&&=accessibility_label(obj)
			result&&=accessibility_frame(obj)
			result&&=accessibility_activation_point(obj)
			result&&=is_accessibility_element(obj)
			result
		end

		def self.uiactionsheet(action)
			result=true
			if action.accessibility_element?
				report "A UIActionSheet should have is_accessibility_element set to false." 
result=false
			end
			unless action.accessibility_view_is_modal
				report "You must set accessibility_view_is_modal to true."
				result&&=false
			end
			result
		end

	end
end

	class NSObject

		def accessible?
		c=self.class
		cs=c.to_s.downcase.to_sym
	until A11y::Test.respond_to?(cs)
		c=c.superclass
		cs=c.to_s.downcase.to_sym
	end
	A11y::Test.send(cs,self)
		end

	end

