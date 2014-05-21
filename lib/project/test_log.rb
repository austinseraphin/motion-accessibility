class Accessibility
	class Test
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
	end
end

