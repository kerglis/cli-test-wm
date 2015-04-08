ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'aruba'
require 'aruba/api'
require 'aruba/reporting'
require 'aruba/in_process'

Dir.glob(::File.expand_path('../support/*.rb', __FILE__)).each { |f| require_relative f }

Aruba::InProcess.main_class = WimduRunner
Aruba.process = Aruba::InProcess

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

  original_stderr = $stderr
  original_stdout = $stdout
  config.before(:all, silent: true) do
    # Redirect stderr and stdout
    $stderr = File.open(File::NULL, "w")
    $stdout = File.open(File::NULL, "w")
  end
  config.after(:all, silent: true) do
    $stderr = original_stderr
    $stdout = original_stdout
  end

end
