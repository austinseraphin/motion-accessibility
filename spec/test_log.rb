describe "A11y::Test::Log" do

	before do
		@log=A11y::Test::Log.new([UIView.new, UILabel.new], "Test")
	end

	it "#initialize" do
		@log.path.should.be.kind_of(Array)
		@log.path.length.should.equal 2
		@log.message.should.not.be.empty
	end

	it "#to_s" do
		@log.to_s.should.match /UIView.+UILabel.+Test/
	end

	it "Log.add" do
		A11y::Test::Log::Events.clear
		A11y::Test::Log.add (@log.path, @log.message)
		A11y::Test::Log::Events.length.should.equal 1
		A11y::Test::Log.add([UIView.new], "Another Test")
		A11y::Test::Log::Events.length.should.equal 2
	end

end

