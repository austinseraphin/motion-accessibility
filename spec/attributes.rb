describe "Accessibility::Attributes" do

before do
@view=UIView.new
end

it "Sets attributes" do
Accessibility::All_Attributes.each do |ruby,ios|
next unless ruby=~/=$/
key=ios.to_s
key.gsub!(/^set/,'')
key[0]=key[0].downcase
key=key.to_sym
next unless A11y.attribute_type(key)
value=A11y::Default_Type_Values[Accessibility.attribute_type(key)]
result=@view.send(ruby, value)
result.should==@view
end
Accessibility::Attributes.each do |ruby,ios|
next unless A11y.attribute_type(ios)
next if ruby=~/=$/
@view.send(ruby).should==A11y::Default_Type_Values[A11y.attribute_type(ios)]
end
nil
end

it "sets custom accessibility actions" do
	@view.accessibility_custom_actions=[A11y::Custom_Action.alloc.initWithName("test", target: self, selector: 'test')]
	@view.accessibility_custom_actions.should.be.kind_of(Array)
	@view.accessibility_custom_actions[0].should.be.kind_of(A11y::Custom_Action)
	@view.accessibility_custom_actions = [{name: "Test", target: self, selector: 'test'}]
	@view.accessibility_custom_actions.should.be.kind_of(Array)
	@view.accessibility_custom_actions[0].should.be.kind_of(A11y::Custom_Action)
end


end
