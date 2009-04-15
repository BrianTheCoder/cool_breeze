# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cool_breeze}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["brianthecoder"]
  s.date = %q{2009-04-15}
  s.email = %q{wbsmith83@gmail.com}
  s.executables = ["cool_breeze", "dump.rdb", "redis.conf"]
  s.extra_rdoc_files = [
    "README.txt"
  ]
  s.files = [
    "History.txt",
    "README.txt",
    "Rakefile",
    "VERSION.yml",
    "bin/cool_breeze",
    "bin/dump.rdb",
    "bin/redis.conf",
    "lib/cool_breeze.rb",
    "lib/cool_breeze/association.rb",
    "lib/cool_breeze/conditions.rb",
    "lib/cool_breeze/connections.rb",
    "lib/cool_breeze/index/abstract.rb",
    "lib/cool_breeze/index/class_index.rb",
    "lib/cool_breeze/index/instance_index.rb",
    "lib/cool_breeze/mixins/associations.rb",
    "lib/cool_breeze/mixins/indices.rb",
    "lib/cool_breeze/model.rb",
    "lib/cool_breeze/query.rb",
    "lib/cool_breeze/types/abstract.rb",
    "lib/cool_breeze/types/counter.rb",
    "lib/cool_breeze/types/list.rb",
    "lib/cool_breeze/types/set.rb",
    "lib/cool_breeze/types/value.rb",
    "spec/association_spec.rb",
    "spec/index_spec.rb",
    "spec/model_spec.rb",
    "spec/models/message.rb",
    "spec/models/user.rb",
    "spec/query_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/BrianTheCoder/cool_breeze}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A new type of orm utilizing two different storage mechanisms to the best of their abilities}
  s.test_files = [
    "spec/association_spec.rb",
    "spec/index_spec.rb",
    "spec/model_spec.rb",
    "spec/models/message.rb",
    "spec/models/user.rb",
    "spec/query_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
