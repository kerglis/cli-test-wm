ENV['APP_ENV'] = "test"
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '/../'))

require 'config/init_app'

require 'aruba/api'
require 'aruba/reporting'
require 'database_cleaner'

require 'lib/wimdu_runner'

RSpec.configure do |config|
  config.include Aruba::Api

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do

    # On startup it might take a little longer for output to
    # arrive. On a really slow machine you might need to increase this
    # value even further.
    @aruba_io_wait_seconds = 1

    restore_env
    clean_current_dir
  end
end
