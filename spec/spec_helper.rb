require "data_mapper"
require "dm-rspec"
require "fabrication"
require_relative "../config/config"

Dir[File.join(File.dirname(__FILE__), "..", "lib", "models", "*.rb")]
  .each{|file| require file}

 Dir[File.join(File.dirname(__FILE__), "..", "lib", "models", "OAuth2", "*.rb")]
  .each{|file| require file} 

RSpec.configure do |config|
  config.include(DataMapper::Matchers)

  config.before(:suite) do
    App::Config.SetupDataMapper("postgres://gowansg:@localhost:5432/atta_test")
    config.pattern = "spec/*_spec.rb"
    
    Fabrication.configure do |config|
      config.sequence_start = 1
    end
  end
end 
