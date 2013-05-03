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

	
	def self.top_restaurants(n)
		query = <<-SQL
			SELECT r.id, r.name, r.neighborhood, r.cuisine
				FROM restaurants AS r
				JOIN restaurant_reviews AS rr
				  ON r.id = rr.restaurant_id
		GROUP BY r.id
	 	ORDER BY AVG(rr.score) DESC
			 LIMIT #{n} 

		SQL

		query_args = {}

		Restaurant.restaurant_factory(query, query_args)
	end


	def self.frequently_reviewed_restaurants(min_reviews)
		query = <<-SQL
			SELECT r.id, r.name, r.neighborhood, r.cuisine
				FROM restaurants AS r
				JOIN restaurant_reviews AS rr
				  ON r.id = rr.restaurant_id
		GROUP BY r.id
		  HAVING COUNT(rr.score) > #{min_reviews}
		SQL

		query_args = {}

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