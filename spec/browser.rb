describe Accessibility::Console do
before do
@view=UIView.new
2.times do |time|
label=UILabel.new
label.text="Label #{time+1}"
label.accessibility_label.should=="Label #{time+1}"
@view.addSubview(label)
end
@tree=A11y::Console::Tree.build(@view)
end

it "has superviews" do
@tree.subviews.each {|node| node.superview.should==@tree}
end

it "#browsable_nodes" do
@tree.browsable_nodes.length.should==3
end

it "builds a tree" do
@tree.view.class.should==UIView
@tree.subviews.each {|node| node.view.class.should==UILabel}
end

it "finds a view" do
found=@tree.find(1)
found.kind_of?(A11y::Console::Tree).should.be.true
found.superview.should==@tree
found.view.accessibility_label.should=="Label 1"
found=@tree.find("1")
found.kind_of?(A11y::Console::Tree).should.be.true
found.superview.should==@tree
found.view.accessibility_label.should=="Label 1"
end

it "#==" do
other=@tree.copy
@tree.should==other
other=A11y::Console::Tree.new(view: UIView.new)
@tree.should.not==other
other=@tree.copy
other.subviews.pop
@tree.should.not==other
end

end
