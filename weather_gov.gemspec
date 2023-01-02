# frozen_string_literal: true

require_relative "lib/weather_gov/version"

Gem::Specification.new do |spec|
  spec.name          = "weather_gov"
  spec.version       = WeatherGov::VERSION
  spec.authors       = ["Jeremy Cole"]
  spec.email         = ["jeremy@jcole.us"]

  spec.summary       = "Ruby implementation of the NWS API Web Service"
  spec.description   = "Ruby implementation of the NWS API Web Service"
  spec.homepage      = "https://github.com/jeremycole/weather_gov"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency("activesupport", "~> 6.1")
  spec.add_dependency("httparty", ">= 0.18.1", "< 0.22.0")

  spec.add_development_dependency("rake", "~> 13.0")
  spec.add_development_dependency("rspec", "~> 3.0")

  spec.add_development_dependency("rubocop", "~> 1.18")
  spec.add_development_dependency("rubocop-rake", "~> 0.6.0")
  spec.add_development_dependency("rubocop-rspec", "~> 2.4")
end
