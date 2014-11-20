# Miscellaneous aliases to determine the status of accessibility components

class Accessibility
class << self

def voiceover_running?
UIAccessibilityIsVoiceOverRunning()
end
def closed_captioning_enabled?
UIAccessibilityIsClosedCaptioningEnabled()
end
def guided_access_enabled?
UIAccessibilityIsGuidedAccessEnabled()
end
def invert_colors_enabled?
UIAccessibilityIsInvertColorsEnabled()
end
def mono_audio_enabled?
UIAccessibilityIsMonoAudioEnabled()
end
def zoom_focused_changed(zoom, frame, view)
zoom=zoom.accessibility_zoom_type if zoom.kind_of?(Symbol)
UIAccessibilityZoomFocusChanged(zoom,frame,view)
end
def registered_gesture_conflict_with_zoom
UIAccessibilityRegisterGestureConflictWithZoom()
end

if UIDevice.currentDevice.systemVersion.to_f>=8.0
	def darker_system_colors_enabled?
		UIAccessibilityDarkerSystemColorsEnabled()
	end
	def bold_text_enabled?
		UIAccessibilityIsBoldTextEnabled()
	end
	def grayscale_enabled?
		UIAccessibilityIsGrayscaleEnabled()
	end
	def reduce_motion_enabled?
		UIAccessibilityIsReduceMotionEnabled()
	end
	def reduce_transparency_enabled?
		UIAccessibilityIsReduceTransparencyEnabled()
	end
	def speak_screen_enabled?
		UIAccessibilityIsSpeakScreenEnabled()
	end
	def speak_selection_enabled?
		UIAccessibilityIsSpeakSelectionEnabled()
	end
	def switch_control_running?
		UIAccessibilityIsSwitchControlRunning()
	end
end

end
end
