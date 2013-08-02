describe Accessibility::Browser do
before do
@view=UIView.new
2.times do |time|
label=UILabel.new
label.text="Label #{time+1}"
label.accessibility_label.should=="Label #{time+1}"
@view.addSubview(label)
end
@tree=A11y::Browser::Tree.build(@view)
end

it "#views" do
@tree.views.length.should==3
end

it "builds a tree" do
@tree.view.class.should==UIView
@tree.subviews.each {|node| node.view.class.should==UILabel}
end

it "finds a view" do
puts @tree.views
found=@tree.find(1)
found.view.accessibility_label.should=="Label 1"
found=@tree.find("1")
found.kind_of?(A11y::Browser::Tree).should.be.true
found.view.accessibility_label.should=="Label 1"
end

end
