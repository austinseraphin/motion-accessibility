class Container_Test < UIView

	attr_reader :data

def init_data
	@data=(1..10).map do |n|
		element=A11y::Element.alloc.init_with_accessibility_container(self)
		element.accessibility_test=UILabel
		element.label="Test element #{n}"
		element.traits=:static_text
		element.is_accessibility_element=true
element
	end
end

	def accessibility_element_at_index(index)
@data[index]
	end

	def accessibility_element_count
		@data.count
	end

	def index_of_accessibility_element(element)
		@data.index(element)
	end

end


