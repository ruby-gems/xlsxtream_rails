require_relative "lib/xlsxtream_rails/version"

Gem::Specification.new do |spec|
  spec.name = "xlsxtream_rails"
  spec.version = XlsxtreamRails::VERSION
  spec.authors = ["doabit"]
  spec.email = ["doinsist@gmail.com"]
  spec.homepage = "https://github.com/ruby-gems/xlsxtream_rails"
  spec.summary = "Xlsx stream download for rails."
  spec.description = "Xlsx stream download for rails."
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0"
  spec.add_dependency "xlsxtream", ">= 2.4.0"
end
