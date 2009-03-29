require 'rubygems'
require 'spec' # Satisfies Autotest and anyone else not using the Rake tasks
require 'redis'
require 'rufus/tokyo/tyrant'


require File.expand_path(
    File.join(File.dirname(__FILE__), %w[.. lib cool_breeze]))
    
Dir[File.expand_path(File.join(File.dirname(__FILE__), 'models','*'))].each{|m| require m}

Spec::Runner.configure do |config|
  CoolBreeze::Connections.setup(:redis, Redis.new)
  CoolBreeze::Connections.setup(:tokyo, Rufus::Tokyo::TyrantTable.new('localhost', 45000))
  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
end

# EOF