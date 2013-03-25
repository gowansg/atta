require 'bundler'
require './lib/atta'
require 'data_mapper'
#require all the models
# Dir[File.join(File.dirname(__FILE__),
#   'lib',
#   'models',
#   '*.rb')].each{|file| require file}

Logger.new($stdout, :debug)
# DataMapper.setup(:default, 
#   ENV['DATABASE_URL'] || "postgres://gowansg:@localhost:5432/atta")
# DataMapper.finalize
# DataMapper.auto_migrate!
App::Config.SetupDataMapper("postgres://gowansg:@localhost:5432/atta")

run Atta
