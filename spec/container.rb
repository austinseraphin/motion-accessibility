describe "Accessibility Container" do

	before do
		@container=Container_Test.new
		@container.init_data
	end

	it "responds to all methods" do
		A11y::Container_Attributes.each do |ruby,ios|
			@container.respond_to?(ruby).should.be.true
			@container.respond_to?(ios).should.be.true
		end
	end

	it "#accessibility_element_count" do
@container.accessibility_element_count.should.equal 10
	end

	it "accessibility_element_at_index" do
		@container.accessibility_element_at_index(0).should.equal @container.data.first
	end

	it "index_of_accessibility_element" do
		@container.index_of_accessibility_element(@container.data.first).should.equal 0
	end

	it "Object.container" do
		@container.should.be.accessibility_element_container
		nil.should.not.be.accessibility_element_container
	end

end

