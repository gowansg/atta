require "data_mapper"
require "dm-rspec"
require "fabrication"
require "json"
require "rack/test"
require_relative "../config/config"
require_relative "../routes/api"

file = File.dirname(__FILE__)
path = File.join(file, "..", "lib", "models", "*.rb")
Dir[path].each{|f| require f}

path = File.join(file, "..", "lib", "models", "OAuth2", "*.rb")
Dir[path].each{|f| require f} 

def app
  Atta::Api
end

RSpec.configure do |config|
  config.include(DataMapper::Matchers)
  config.include(Rack::Test::Methods)
  config.before(:suite) do
    App::Config.setup_data_mapper("postgres://gowansg:@localhost:5432/atta_test")
    config.pattern = "spec/*_spec.rb"
    Fabrication.configure do |config|
      config.sequence_start = 1
    end
  end
  config.before(:all) do
    DataMapper::Model.descendants.each { |m| m.destroy }
  end
end 
