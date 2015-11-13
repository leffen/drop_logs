# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','drop_logs','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'drop_logs'
  s.version = DropLogs::VERSION
  s.author = 'Leffen'
  s.email = 'leffen@gmail.com'
  s.homepage = 'http://leffen.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A simple tool for listening on zip files dropping into a directory and then analyzing it for logtype to be feed into Logstash. puh'
  s.files = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','drop_logs.rdoc']
  s.rdoc_options << '--title' << 'drop_logs' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'drop_logs'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_development_dependency('test-unit')
  s.add_runtime_dependency('gli','2.13.3')
  s.add_runtime_dependency('paxx','0.1.5')
end
