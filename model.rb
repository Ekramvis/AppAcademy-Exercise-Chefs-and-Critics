module Model

	def factory(type, query, query_args)
		results = ChefsDatabase.instance.execute(query, query_args)
		
		results.map { |result| type.new(result) }
	end

end