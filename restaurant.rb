require_relative 'chefs_database'

class Restaurant
	attr_accessor :id, :name, :neighborhood, :cuisine

	def initialize(options = {})
		@id = options['id']
		@name = options['name']
		@neighborhood = options['neighborhood']
		@cuisine = options['cuisine']
	end

end