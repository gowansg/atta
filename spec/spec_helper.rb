require "data_mapper"
require_relative "../config/config"
Dir[File.join(File.dirname(__FILE__),
  "..",
  "lib",
  "models",
  "*.rb")].each{|file| require file}

RSpec.configure do |config|
	config.before(:suite) do
	  App::Config.SetupDataMapper("postgres://gowansg:@localhost:5432/atta_test")
	  config.pattern = "spec/*_spec.rb"
  end
end 
