# frozen_string_literal: true

require_relative "lib/rulers/version"

Gem::Specification.new do |spec|
  spec.name = "rulers"
  spec.version = Rulers::VERSION
  spec.authors = ["Tobias Bales"]
  spec.email = ["git@tobiasbales.dev"]

  spec.summary = "Rulers on rails, like rails but smaller."
  spec.homepage = "https://www.github.com/TobiasBales/rulers"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://www.github.com/TobiasBales/rulers"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://www.github.com/TobiasBales/rulers"
  spec.metadata["changelog_uri"] = "https://www.github.com/TobiasBales/rulers/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "erubis", "~>2.7"
  spec.add_runtime_dependency "rack", "~>3.0"
  spec.add_development_dependency "minitest", "~>5.16"
  spec.add_development_dependency "rack-test", "~>2.0"

  spec.metadata["rubygems_mfa_required"] = "true"
end
