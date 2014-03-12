Gem::Specification.new do |s|
  # Change these as appropriate
  s.name              = "rack-force_domain"
  s.version           = "0.3.0"
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
