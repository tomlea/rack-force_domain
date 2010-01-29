require "rubygems"
require "rake/gempackagetask"
require "rake/rdoctask"

task :default => :test

require "rake/testtask"
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

spec = Gem::Specification.new do |s|
  # Change these as appropriate
  s.name              = "rack-force_domain"
  s.version           = "0.1.1"
  s.summary           = "Force all visitors onto a single domain."
  s.author            = "Tom Lea"
  s.email             = "contrib@tomlea.co.uk"
  s.homepage          = "http://tomlea.co.uk/"

  s.has_rdoc          = true
  s.extra_rdoc_files  = %w(README.markdown)
  s.rdoc_options      = %w(--main README.markdown)

  # Add any extra files to include in the gem
  s.files             = %w(README.markdown) + Dir.glob("{test,lib}/**/*")

  s.require_paths     = ["lib"]

  s.rubyforge_project = "rack-force_domain"
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

Rake::RDocTask.new do |rd|
  rd.main = "README.markdown"
  rd.rdoc_files.include("README.markdown", "lib/**/*.rb")
  rd.rdoc_dir = "rdoc"
end

desc 'Clear out RDoc and generated packages'
task :clean => [:clobber_rdoc, :clobber_package]
