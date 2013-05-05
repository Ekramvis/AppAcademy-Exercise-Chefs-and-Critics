require_relative 'chefs_database'
# REV: Critic.rb looks sound.
class Critic
	attr_accessor :id, :screen_name, :avg_review_score

	extend Model

	def self.critic_factory(query, query_args)
		factory(self, query, query_args)
	end

	def initialize(options = {})
		@id = options['id']
		@screen_name = options['screen_name']
	end

	def self.find_by_screen_name(screen_name)
		query = <<-SQL
			SELECT *
				FROM critics
			 WHERE screen_name = :screen_name
		SQL

		query_args = {
			:screen_name => screen_name
		}

		Critic.critic_factory(query, query_args)
	end

	def reviews
		query = <<-SQL
			SELECT *
				FROM restaurant_reviews AS rr
				JOIN critics AS c
				  ON c.id = rr.critic_id
			 WHERE rr.critic_id = :id
		SQL

		query_args = {
			:id => @id
		}

		RestaurantReview.restaurant_review_factory(query, query_args)
	end

	def average_review_score
		query = <<-SQL
			SELECT AVG(rr.score) AS avg
				FROM restaurant_reviews AS rr
				JOIN critics AS c
				  ON c.id = rr.critic_id
			 WHERE c.id = #{@id}
		GROUP BY c.id
		SQL

		@avg_review_score = ChefsDatabase.instance.execute(query)[0]['avg']
	end


	def unreviewed_restaurants
		query = <<-SQL
			SELECT r.id, r.name, r.neighborhood, r.cuisine
			  FROM restaurants AS r
			 WHERE r.id NOT IN (SELECT rr.restaurant_id 
			 										  FROM restaurant_reviews AS rr
			 										  JOIN critics AS c
 			 										  	ON rr.critic_id = c.id
 			 										 WHERE c.id = #{@id})
		SQL

		query_args = {}

		Restaurant.restaurant_factory(query, query_args)
	end



end