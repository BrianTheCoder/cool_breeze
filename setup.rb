require 'lib/cool_breeze'
require 'redis'
require 'rufus/tokyo/tyrant'
require 'twitter'

CoolBreeze::Connections.setup(:redis, Redis.new)
CoolBreeze::Connections.setup(:tokyo, Rufus::Tokyo::Table.new('log/stage.tct'))

Dir['spec/models/*'].each{|m| require m}

def tweets(name = "#sxsw")
  Twitter::Search.new(name)
end