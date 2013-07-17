class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
@window=UIWindow.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
@window.makeKeyAndVisible
controller=TestController.alloc.initWithNibName(nil, bundle: nil)
nav=UINavigationController.alloc.initWithRootViewController(controller)
@window.rootViewController=nav
    true
  end
end

class TestController < UIViewController

def viewDidLoad
self.title="Test App"
@label=UILabel.alloc.initWithFrame(CGRect.new([0,0], [view.frame.size.width, view.frame.size.height/3]))
@label.text="Hello!"
view.addSubview(@label)
@textfield=UITextField.alloc.initWithFrame(CGRect.new([0, @label.frame.origin.y], [@label.frame.size.width, @label.frame.size.height]))
@textfield.delegate=self
view.addSubview(@textfield)
@button=UIButton.buttonWithType(UIButtonTypeRoundedRect)
@button.frame=CGRect.new([0, @textfield.frame.origin.y+@textfield.frame.size.height],
[@textfield.frame.size.width, @textfield.frame.size.height/3])
@button.setTitle("Update", forState: UIControlStateNormal)
view.addSubview(@button)
@button.addTarget(self, action: 'tap_update', forControlEvents: UIControlEventTouchUpInside)
end

def textFieldShouldReturn(textfield)
textfield.resignFirstResponder
false
end

def tap_update
@label.text=@textfield.text
end

end
