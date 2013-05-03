require_relative 'chefs_database'

class Chef
	attr_accessor :id, :first_name, :last_name, :mentor

	def initialize(options = {})
		@id = options[:id]
		@first_name = options[:first_name]
		@last_name = options[:last_name]
		@mentor = options[:mentor]
	end

end