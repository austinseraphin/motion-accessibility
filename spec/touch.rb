describe "Object#touch" do

it UITextField do
@text=UITextField.new
@text.touch "Test"
@text.text.should=="Test"
end

it UIButton do
@button=UIButton.buttonWithType(UIButtonTypeRoundedRect)
$button_tapped=false
@button.addTarget(self,'tap_button', forControlEvents: UIControlEventTouchUpInside)
@button.touch
$button_tapped.should==true
end

def tapp_button
$button_tapped=true
end


end
