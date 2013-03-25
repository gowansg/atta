require "data_mapper"
# Dir[File.join(File.dirname(__FILE__),
#   "lib",
#   "models",
#   "*.rb")].each{|file| require file}

module App
	module Config
		extend self

	  def SetupDataMapper(connection_uri)
	    DataMapper.setup(:default, ENV["DATABASE_URL"] || connection_uri)
	    DataMapper.finalize
	    DataMapper.auto_migrate!
	  end
	end
end