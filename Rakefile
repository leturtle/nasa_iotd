require 'rake/testtask'
require './lib/nasa_iotd.rb'

task :default => :test

Rake::TestTask.new do |t|
  t.warning = true
end

task :today do
  NASAIOTD.new.today.download
end


