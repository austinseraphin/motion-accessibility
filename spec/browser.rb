describe Accessibility::Browser do

before do
@view=UIView.new
2.times do |time|
label=UILabel.new
label.text="Label #{time+1}"
label.accessibility_label.should=="Label #{time+1}"
@view.addSubview(label)
end
A11y::Browser.current_view=@view
end

it "finds a view" do
A11y::Browser.find_view(0).should==@view.superview
2.times do |time|
A11y::Browser.find_view(time+1).should==@view.subviews[time]
A11y::Browser.find_view((time+1).to_s).should==@view.subviews[time]
A11y::Browser.find_view("label #{time+1}").should==@view.subviews[time]
end
end

end
