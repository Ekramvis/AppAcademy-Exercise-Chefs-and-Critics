require_relative 'chefs_database'

class Critic
	attr_accessor :id, :screen_name

	extend Model

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

		factory(self, query, query_args)
	end

	def reviews
		query = <<-SQL
			SELECT *
				FROM restaurant_reviews AS rr
				JOIN critcs AS c
				  ON c.id = rr.critic_id
			 WHERE rr.critic_id = :id
		SQL

		query_args = {
			:id => @id
		}

		RestaurantReview.factory(RestaurantReview.new.class, query, query_args)
	end


end