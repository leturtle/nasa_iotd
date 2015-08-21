lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH

Gem::Specification.new do |s|
  s.name = 'nasa_iotd'
  s.version = '0.0.1'

  s.files = [
    'lib/nasa_iotd.rb'
  ]

  s.author = 'Turtle'
end