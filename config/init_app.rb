require 'active_record'
require 'sqlite3'
require 'logger'
require 'thor'
require 'pry'

env = ENV['APP_ENV'] || "development"
ROOT_PATH = File.join(File.dirname(__FILE__), '/../')

ActiveRecord::Base.logger = Logger.new("#{ROOT_PATH}log/debug.log")
configuration = YAML::load(IO.read("#{ROOT_PATH}config/database.yml"))
ActiveRecord::Base.establish_connection(configuration[env])

Dir['./lib/models/**/*.rb'].each { |f| require f }
