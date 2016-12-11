Gem::Specification.new do |s|
  s.name = 'sampler'
  s.version = '0.0.1'
  s.summary = "minimal downsampler for CSV files"
  s.summary = 'Downsamples a file according to sample amount and strategy'
  s.authors = ['Lucia Escanellas']
  s.email = 'raviolicode at gmail'
  s.license = 'MIT'
  s.files = Dir["README.md", "LICENSE", "bin/*", "lib/**/*.rb"]

  s.add_dependency "thor", "~> 0.19"

  s.add_development_dependency "rspec", "~> 5.10"
  s.add_development_dependency "aruba", "~> 0.14.2"
end

