$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), './'))
require 'config/init_app'

task default: :migrate

desc "Run migrations"
task :migrate do
  ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
end
