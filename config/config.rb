require "data_mapper"

module App
  module Config
	  def self.setup_data_mapper(connection_uri)
	    DataMapper.setup(:default, ENV["DATABASE_URL"] || connection_uri)
	    DataMapper.finalize
	    DataMapper.auto_migrate!
	  end
  end
end