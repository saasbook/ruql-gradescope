#
#
#  NOTE: you should not need to change anything here except the runtime dependency gems
#
#

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ruql/gradescope/version"

Gem::Specification.new do |spec|
  spec.name          = "ruql-gradescope"
  spec.version       = Ruql::Gradescope::VERSION
  spec.summary     = "Gradescope formatter for RuQL"
  spec.description = "Gradescope formatter for RuQL"
  spec.authors     = ["Michael Ball"]
  spec.email       = 'ball@berkeley.edu'
  spec.homepage    = 'https://github.com/saasbook/ruql-gradescope'
  
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = spec.homepage
    #spec.metadata["changelog_uri"] = ''
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end
  spec.add_runtime_dependency 'ruql', '~> 1.0', '>= 1.0.2'
  #
  #  add any runtime dependency gems here, with bundler syntax:
  #  spec.add_runtime_dependency 'builder', '~> 3.0'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

