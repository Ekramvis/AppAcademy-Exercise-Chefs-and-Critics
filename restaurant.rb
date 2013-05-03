require_relative 'chefs_database'

class Restaurant
	attr_accessor :id, :name, :neighborhood, :cuisine, :avg_review_score

	extend Model 

	def self.restaurant_factory(query, query_args)
		factory(self, query, query_args)
	end

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

		Restaurant.restaurant_factory(query, query_args)
	end

	
	def reviews
		query = <<-SQL
			SELECT *
				FROM restaurant_reviews as rr 
			 WHERE rr.restaurant_id = :id
		SQL

		query_args = {
			:id => @id
		}

		RestaurantReview.restaurant_review_factory(query, query_args)
	end


	def average_review_score
		query = <<-SQL
			SELECT AVG(rr.score) as avg
				FROM restaurant_reviews as rr 
			 WHERE rr.restaurant_id = #{@id}
		SQL

		@avg_review_score = ChefsDatabase.instance.execute(query)[0]['avg']
	end

end