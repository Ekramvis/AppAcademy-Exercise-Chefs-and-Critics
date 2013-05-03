require_relative 'chefs_database'

class Restaurant
	attr_accessor :id, :name, :neighborhood, :cuisine

	extend Model 

	def initialize(options = {})
		@id = options['id']
		@name = options['name']
		@neighborhood = options['neighborhood']
		@cuisine = options['cuisine']
	end


	def self.restaurants_for_neighborhood(neighborhood)
		query = <<-SQL
			SELECT *
				FROM restaurants 
			 WHERE neighborhood = :neighborhood
		SQL

		query_args = {
			:neighborhood => neighborhood
		}

		factory(self, query, query_args)
	end


end