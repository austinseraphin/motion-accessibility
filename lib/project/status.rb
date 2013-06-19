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

end
end
