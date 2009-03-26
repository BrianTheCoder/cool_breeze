# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

begin
  require 'bones'
  Bones.setup
rescue LoadError
  begin
    load 'tasks/setup.rb'
  rescue LoadError
    raise RuntimeError, '### please install the "bones" gem ###'
  end
end

ensure_in_path 'lib'
require 'cool_breeze'

task :default => 'spec:run'

PROJ.name = 'CoolBreeze'
PROJ.authors = 'Brian Smith'
PROJ.email = 'brian@46blocks.com'
PROJ.url = 'http://github.com/BrianTheCoder/'
PROJ.version = CoolBreeze::VERSION
PROJ.rubyforge.name = 'cool_breeze'

PROJ.spec.opts << '--color'

# EOF
