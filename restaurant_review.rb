require_relative 'chefs_database'

class RestaurantReview
	:id, :critic_id, :restaurant_id, :review_text, :score, :review_date

	def initialize(options = {})
		@id = options[:id]
		@critic_id = options[:critic_id]
		@restaurant_id = options[:restaurant_id]
		@review_text = options[:review_text]
		@score = options[:score]
		@review_date = options[:review_date]
	end

end