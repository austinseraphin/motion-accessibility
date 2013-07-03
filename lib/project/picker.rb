class UIPickerView

Accessibility::PickerView_Attributes.each {|ruby,ios| define_method(ruby) {|component| self.send(ios, component)}}

if self.respond_to?(:method_added)&&!Accessibility::Data[:object_method_added]
class << self
alias :method_added_pickerview_accessibility :method_added
end
end

def self.method_added(name)
if self.respond_to?(:method_added_pickerview_accessibility)
self.method_added_pickerview_accessibility(name)
end
return unless Accessibility::PickerView_Attributes.flatten.member?(name.to_sym)
if Accessibility::PickerView_Attributes.has_key?(name)
ruby=name
ios=Accessibility::PickerView_Attributes[name]
define_method(ios) {|component| self.send(ruby,  component)}
else
ios=name
ruby=Accessibility::PickerView_Attributes.rassoc(name)
ruby=ruby.first
define_method(ruby) {|component|  self.send(ios, component)}
end
end

end
