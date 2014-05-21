module Accessibility
	module Test

		class Log

			Events=Array.new
			attr_reader :path, :message

			def initialize(path, message)
				@path=path||Array.new
				@message=message
			end

			def to_s
				@path.join(" -> ")+": "+@message
			end

			def self.add(path, name)
				event=self.new(path.clone, name)
				Events<<event
			end

		end

			Path=Array.new
			Data= {
				depth: 0,
				debug: false
			}

			Options = {
				recurse: true
			}

			Standard_Tests = {
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
				is_accessibility_element: [true, "You must set is_accessibility_element=true to make VoiceOver aware of it. This will often happen automatically when a view becomes visible by giving it a frame and adding it to a subview."]
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
				UIApplication: {
				accessibility_label: [String,"You must set the accessibility_label. Setting the app's title will do this."],
				is_accessibility_element: false,
				options: {
				test: :application
			}
			},
				UIBarItem: {
				title: [String, "Set the title to tell VoiceOver what to say."],
				accessibility_label: nil,
				is_accessibility_element: false,
			},
			UIButton: {
				accessibility_label: [String,"You must set the accessibility_label. You can use the setTitle:forState method to do this on a button."],
				accessibility_traits: UIAccessibilityTraitButton,
			},
			UICollectionReusableView: {
				accessibility_label: nil,
				is_accessibility_element: false},
				UIDatePicker: {
				accessibility_label: nil,
				is_accessibility_element: false,
				options: {
				recurse: false
			}
			},
				UIImageView: {
				accessibility_label: nil,
				accessibility_traits: [UIAccessibilityTraitImage, "You must set accessibility_trait to :image"],
				is_accessibility_element: false
			},
				UILabel: {
				accessibility_label: [String, "You must set the accessibility_label. You can use the text method to do this."],
				accessibility_traits: [UIAccessibilityTraitStaticText, "You must set accessibility_traits to :static_text"]
			},
				UINavigationBar: {
				accessibility_label: nil,
				accessibility_traits: [Bignum, "Apple has this set to a non-standard value."],
				accessibility_elements_hidden: false,
				should_group_accessibility_children: true,
				accessibility_identifier: [String, "You must set the accessibility_identifier to the title of the view. You can set the title of the view controller or of the navigation item."],
				is_accessibility_element: false,
				options: {
				recurse: false,
				test: :bar
			}
			},
				UINavigationController: {
				accessibility_label: nil,
				is_accessibility_element: false,
				options: {
				recurse: false,
				test: :navigationViewController
			}
			},
				UINavigationTransitionView: {
				accessibility_label: nil,
				should_group_accessibility_children: true,
				is_accessibility_element: false
			},
				UIPageControl: {
				accessibility_label: nil,
				is_accessibility_element: false,
				accessibility_value: [String, "You must set the accessibility_value to something meaningful, for example 'Page 1 of 1'"],
				accessibility_traits: UIAccessibilityTraitUpdatesFrequently
			},
				UIPickerView: {
				accessibility_label: nil,
				is_accessibility_element: false,
				options: {
				recurse: false,
				test: :pickerView
			}
			},
				UIProgressView: {
				accessibility_label: String,
				accessibility_traits: UIAccessibilityTraitUpdatesFrequently,
				accessibility_value: [String, "The accessibility_value should contain a textual representation of the progress, for instance \"50%\""],
				is_accessibility_element: false
			},
				UISegment: {
				accessibility_label: String,
				accessibility_traits: [UIAccessibilityTraitButton, "You must make this a button by setting accessibility_trait to :button"],
				accessibility_value: String
			},
				UISegmentedControl: {
				accessibility_label: nil,
				is_accessibility_element: false,
				should_group_accessibility_children: true
			},
				UISlider: {
				accessibility_label: nil,
				accessibility_value: String,
				accessibility_traits: UIAccessibilityTraitAdjustable,
				options: {recurse: false}
			},
				UIStepper: {
				accessibility_label: nil,
				is_accessibility_element: false,
				options: {recurse: false}
			},
				UISwitch: {
				accessibility_label: nil,
				accessibility_traits: [->(t){t>65536||t==UIAccessibilityTraitButton},
					"You must set the accessibility_trait to :button"],
					accessibility_value: [String, "You must set the accessibility_value to \"1\" or \"0\""]
			},
				UITabBar: {
				accessibility_label: nil,
				accessibility_traits: [Bignum, "Apple has this set to a non-standard value."],
				should_group_accessibility_children: true,
				is_accessibility_element: false,
				options: {
				recurse: false,
				test: :bar
			}
			},
				UITabBarButton: {
				accessibility_label: [String, "You must set the title of this button. You can se tthe title of the UITabBarItem."],
				accessibility_traits: Fixnum
			},
				UITabBarController: {
				accessibility_label: nil,
				is_accessibility_element: false,
				options: {
				recurse: false,
				test: :tabBarViewController
			}
			},
				UITableView: {
				accessibility_label: [String, "You must set the accessibility_label to the default contents of the table view, for example \"Empty List\""],
				accessibility_traits: [Bignum, "Apple has this set to a non-standard value."],
				should_group_accessibility_children: true,
				is_accessibility_element: false
			},
				UITableViewCell: {
				accessibility_label: :ignore,
				accessibility_value: :ignore,
				is_accessibility_element: false,
				options: {
				recurse: false,
				test: :tableViewCell
			}
			},
				UITableViewHeaderFooterView: {
				accessibility_label: [String, "Set the accessibility_label to tell VoiceOver what to read. You can do this with the textLabel.text property."]
			},
				UITextField: {
				accessibility_label: nil,
				accessibility_traits: [->(t){t==262144||t==UIAccessibilityTraitNone}, "Apple has this set to a non-standard value. If making a custom view you can just use :none"],
				accessibility_value: [->(value) {value}, "You must set the text of the textfield."],
				is_accessibility_element: false
			},
				UIToolbar: {
				accessibility_label: nil,
				accessibility_traits: [Bignum, "Apple has this set to a non-standard value."],
				should_group_accessibility_children: true,
				is_accessibility_element:false,
				options: {
				test: :bar
			}
			},
				UIToolbarButton: {
				accessibility_label: [String, "You must set the accessibility_label. You can do this by setting the UIBarButtonItem's title with the setTItle:style:target:action: method."],
				accessibility_traits: UIAccessibilityTraitButton
			},
				UIView: {
				accessibility_label: nil,
				is_accessibility_element: false
			},
				UIViewController: {
				accessibility_label: nil,
				is_accessibility_element: false,
				options: {
				test: :viewController
			}
			},
				UIViewControllerWrapperView: {
				accessibility_label: nil,
				should_group_accessibility_children: true,
				is_accessibility_element: false
			},
				UIWebView: {
				accessibility_label: nil,
				is_accessibility_element: false,
				options: {
				recurse: false
			}
			},
				UIWindow: {
				accessibility_label: nil,
				is_accessibility_element: false,
				options: {
				test: :window
			}
			}
			}

			Custom_Tests = {
				UIView: {
				accessibility_label: [String, "Set the accessibility_label to tell VoiceOver what to say."],
				is_accessibility_element: [true, "Set is_accessibility_element to true to tell VoiceOver it can access this element."]
			}
			}

			def self.debug
				Data[:debug]
			end
			def self.debug=(d)
				Data[:debug]=d
			end

			def self.application(app)
				self.run_tests(app.keyWindow)
			end

			def self.bar(obj)
				result=true
				obj.items {|item| result=result&&self.run_tests(item)}
			result
		end

		def self.navigationViewController(controller)
			result=true
			result&&self.run_tests(controller.navigationBar)
controller.viewControllers.each {|c| result=result&&self.run_tests(c)}
result
		end

		def self.pickerView(picker)
			result=true
picker.numberOfComponents.times do |component|
picker.numberOfRowsInComponent(component).times do |row|
title=picker.delegate.pickerView(picker, titleForRow: row, forComponent: component)
view=picker.	viewForRow(row, forComponent: component)
if !title&&!self.run_tests(view)
	A11y::Test::Log(Path, picker.inspect+": component #{component} row #{row} not accessible. You can use the pickerView:titleForRow:forComponent or pickerView:accessibility_label_for_component methods to do this.")
	result=false
end
end
end
			      result
		end

		def self.tabBarViewController(controller)
			result=true
			result&&self.run_tests(controller.tabBar)
controller.viewControllers.each {|c| result=result&&self.run_tests(c)}
result
		end

		def self.tableViewCell(cell)
			return true if cell.accessibility_label||cell.textLabel.text
			A11y::Test::Log.add(Path, "Please set the accessibility_label of the UITableViewCell. You can do this by setting the textLabel.text property.")
			false
		end

		def self.viewController(controller)
			self.run_tests(controller.view)
		end

		def self.window(window)
			self.run_tests(window.rootViewController)
		end

		def self.find_tests(obj)
			obj_tests=A11y::Test::Standard_Tests[:NSObject].clone
cl=obj.class
class_name=cl.to_s.to_sym
if obj.accessibility_test
	tests=self::Custom_Tests[obj.accessibility_test]||self::Standard_Tests[obj.accessibility_test]
else
	tests=self::Standard_Tests[class_name]
until tests do
	cl=cl.superclass
class_name=cl.to_s.to_sym
	tests=self::Standard_Tests[class_name]
end
end
return self.find_tests(tests) if tests.kind_of?(Symbol)
			tests.each do |attribute, test|
				obj_tests[attribute]=test
			end
obj_tests
		end

		def self.run_test(obj, attribute, expected, message=nil)
			return true if expected==:ignore
	value=obj.send(attribute) if obj.respond_to?(attribute)
	result=true
	if expected.class==Class
if value.class!=expected
	result=false
message||="#{attribute} must have an object of type #{expected} instead of #{value}"
end
	elsif expected.kind_of?(Proc)
		r=expected.call(value)
		unless r
			result=false
			message||="The test function for #{attribute} failed."
		end
	else
		unless expected==value
result=false
message||="#{attribute} must have the value \"#{expected}\" instead of \"#{value}\""
		end
	end
	A11y::Test::Log.add(Path, message) unless result
	puts "Testing #{attribute}... #{result}" if Data[:debug]
	result
		end

		def self.run_tests(obj)
			puts "Entering run_tests: #{obj.inspect}" if Data[:debug]
			if Data[:depth]==0
			A11y::Test::Log::Events.clear
			Path.clear
			end
			Path<<obj
			tests=self.find_tests(obj)
	tests[:options]||={}
	tests[:options]=self::Options.merge(tests[:options])
result=true
tests.each do |attribute, test|
	next if attribute==:options
	if test.kind_of?(Array)
	(expected, message)=test
	this_result=self.run_test(obj, attribute, expected, message)
	else
	this_result=self.run_test(obj, attribute, test)
	end
	result=result&&this_result
end
after=tests[:options][:test]
 if after&&self.respond_to?(after)
	 puts "Running the after test: #{after}" if Data[:debug]
			Data[:depth]=Data[:depth]+1
	 this_result=self.send(after, obj)
	 result=result&&this_result
			Data[:depth]=Data[:depth]-1
 end
if result&&tests[:options][:recurse]&&obj.respond_to?(:subviews)&&obj.subviews
	puts "Recursing..." if Data[:debug]
	Data[:depth]=Data[:depth]+1
obj.subviews.each {|view| result=result&&A11y::Test.run_tests(view)}	
Data[:depth]=Data[:depth]-1
end
Path.pop
puts "Returning #{result}" if Data[:debug]
	result
		end

	end

def self.doctor(view=nil)
view.accessible? if view
return if A11y::Test::Log::Events.empty?
	A11y::Test::Log::Events.each do |event|
	       NSLog(event.to_s)
	end
	A11y::Test::Log::Events.last.path.last
end

end

	class NSObject

		attr_reader :accessibility_test

		def accessibility_test=(t)
			t=t.to_s.to_sym if t.kind_of?(Class)
			@accessibility_test=t if A11y::Test::Custom_Tests[t]||A11y::Test::Standard_Tests[t]
			@accessibility_test
		end

		def accessible?
			A11y::Test::Data[:depth]=0
			A11y::Test.run_tests(self)
		end

	end

