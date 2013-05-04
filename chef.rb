require_relative 'chefs_database'
require_relative 'model'

class Chef
	attr_accessor :id, :first_name, :last_name, :mentor, :num_proteges

	extend Model 

	def self.chef_factory(query, query_args)
		factory(self, query, query_args)
	end

	def initialize(options = {})
		@id = options['id']
		@first_name = options['first_name']
		@last_name = options['last_name']
		@mentor = options['mentor']
	end

	def self.find_by_id(id)
		query = <<-SQL
			SELECT *
				FROM chefs
			 WHERE chefs.id = :id
		SQL

		query_args = {
			:id => id
		}

		Chef.chef_factory(query, query_args)
	end

	
	def num_proteges
		query = <<-SQL
			SELECT COUNT(*) AS 'num'
				FROM chefs AS c1
				JOIN chefs AS c2
				  ON c1.id = c2.mentor
			 WHERE c1.id = #{@id}
			 	 AND c1.id = c2.mentor
		GROUP BY c1.id
		SQL

		@num_proteges = ChefsDatabase.instance.execute(query)[0]['num']
	end

	def reviews
		query = <<-SQL
			SELECT rr.id, rr.critic_id, rr.restaurant_id, rr.review_text, rr.score, rr.review_date
				FROM chefs AS c
			 	JOIN chef_tenures AS ct
			 	  ON c.id = ct.chef_id
			 	JOIN restaurant_reviews AS rr
			 		ON rr.restaurant_id = ct.restaurant_id
			 WHERE c.id = :id
			   AND rr.review_date BETWEEN ct.start_date AND ct.end_date
		SQL

		query_args = {
			:id => @id
		}

		RestaurantReview.restaurant_review_factory(query, query_args)
	end



	def co_workers
		query = <<-SQL
			SELECT cx.*
			  FROM (SELECT other_ct.chef_id
						  FROM (SELECT ct.* 
										  FROM chefs AS c
										  JOIN chef_tenures AS ct
										    ON c.id = ct.chef_id
										 WHERE c.id = #{@id}) AS my_ct

						  JOIN (SELECT ct2.* 
										  FROM chefs AS c2
										  JOIN chef_tenures AS ct2
										    ON c2.id = ct2.chef_id
										 WHERE c2.id != #{@id}) AS other_ct

						    ON my_ct.restaurant_id = other_ct.restaurant_id
						 WHERE other_ct.start_date < my_ct.end_date
						    OR my_ct.start_date < other_ct.end_date) AS oci
				JOIN chefs AS cx
				  ON cx.id = oci.chef_id
		SQL

		query_args = {}

		Chef.chef_factory(query, query_args)
	end


end
