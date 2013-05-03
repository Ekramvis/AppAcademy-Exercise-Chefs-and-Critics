require 'sqlite3'
require 'singleton'

class ChefsDatabase < SQLite3::Database

	include Singleton

	def initialize
		super("chefs.db")

		self.results_as_hash = true
		self.type_translation = true
	end

end