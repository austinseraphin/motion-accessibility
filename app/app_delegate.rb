class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
	  return true if RUBYMOTION_ENV=='test'
@window=UIWindow.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
@window.makeKeyAndVisible
test_controller=TestController.alloc.initWithNibName(nil, bundle: nil)
test_nav=UINavigationController.alloc.initWithRootViewController(test_controller)
table_controller=Table_Test.alloc.initWithNibName(nil, bundle: nil)
table_controller.title="Table"
table_nav=UINavigationController.alloc.initWithRootViewController(table_controller)
tab_controller=UITabBarController.alloc.initWithNibName(nil, bundle: nil)
tab_controller.viewControllers=[test_nav, table_nav]
@window.rootViewController=tab_controller
    true
  end
end

class TestController < UIViewController

def initWithNibName(name, bundle: bundle)
super
self.tabBarItem=UITabBarItem.alloc.initWithTitle("Tests", image: nil, tag: 1)
self
end

def viewDidLoad
super
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
