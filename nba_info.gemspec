
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nba_info/version"

Gem::Specification.new do |spec|
  spec.name          = "nba_information"
  spec.version       = NbaInfo::VERSION
  spec.authors       = ["RSchaubeck"]
  spec.email         = ["richard.schaubeck@gmail.com"]

  spec.summary       = "nba info"
  spec.description   = "An NBA CLI gem to check current standings, team stats, and the current day's schedule"
  spec.homepage      = "https://github.com/RSchaubeck/nba-info-gem"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   << "nba_information"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "pry", "~> 0.10.3"

  spec.add_dependency "nokogiri", "~> 1.0"
  spec.add_dependency "httparty", "~> 0.18.1"

end
