require 'bundler'
require './lib/atta'

Logger.new($stdout, :debug)
App::Config.setup_data_mapper("postgres://gowansg:@localhost:5432/atta")

run Atta::API
