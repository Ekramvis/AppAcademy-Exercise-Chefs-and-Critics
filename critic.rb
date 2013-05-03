require_relative 'chefs_database'

class Critic
	attr_accessor :id, :screen_name

	def initialize(options = {})
		@id = options['id']
		@screen_name = options['screen_name']
	end

end