require_relative 'lib/migration/manager/version'

Gem::Specification.new do |spec|
  spec.name          = "migration-manager"
  spec.version       = Migration::Manager::VERSION
  spec.authors       = ["Rajnish mishra"]
  spec.email         = ["rajnish.mishra@jarvis.consulting"]

  spec.summary       = %q{Write a short summary, because RubyGems requires one.}
  spec.description   = %q{Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/rajnish-jarvis"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = "https://github.com/rajnish-jarvis/migration-manager"
  spec.metadata["source_code_uri"] = "https://github.com/rajnish-jarvis/migration-manager"
  spec.metadata["changelog_uri"] = "https://github.com/rajnish-jarvis/migration-manager"

  # Exclude the .gem file from being listed
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|migration-manager-\d+\.\d+\.\d+\.gem)/}) }
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end