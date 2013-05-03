require_relative 'chefs_database'

class ChefTenure
	:id, :chef_id, :restaurant_id, :start_date, :end_date, :head_chef

	def initialize(options = {})
		@id = options[:id]
		@chef_id = options[:chef_id]
		@restaurant_id = options = [:restaurant_id]
		@start_date = options[:start_date]
		@end_date = options[:end_date]
		@head_chef = options[:head_chef]
	end
	
end