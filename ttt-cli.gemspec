# frozen_string_literal: true

require_relative 'lib/ttt-cli/version'

Gem::Specification.new do |spec|
  spec.name          = 'ttt-cli'
  spec.version       = TttCli::VERSION
  spec.authors       = ['dionixs']
  spec.email         = ['dionixs@tutanota.com']

  spec.summary       = 'Консольная реализация игры "Крестики-нолики"'
  spec.homepage      = 'https://github.com/dionixs/ttt-cli'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.executables = ['ttt-cli']
  spec.require_paths = ['lib']
  spec.files = Dir.glob('{bin,lib,spec}/**/*') + %w[LICENSE README.md]

  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')
  spec.add_development_dependency 'bundler', '~> 2.1.2'
  spec.add_development_dependency 'pry', '~> 0.12.2'
  spec.add_development_dependency 'rake', '~> 13.0', '>= 13.0.1'
  spec.add_development_dependency 'rspec', '~> 3.9'

  spec.add_dependency 'rainbow', '~> 3.0'
  spec.add_dependency 'tty-prompt', '~> 0.21.0'
  spec.add_dependency 'tty-table', '~> 0.11.0'
end
