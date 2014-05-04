Gem::Specification.new do |s|
  s.name        = 'dronebl.rb'
  s.version     = '0.0.1'
  s.date        = '2014-05-04'
  s.summary     = "Interface to the DroneBL RPC2 service"
  s.description = "NOTE: You should create a ~/.droneblkey file with your key inside of it for the best experience with this."
  s.authors     = ["Rylee Fowler"]
  s.email       = 'rylee@rylee.me'
  s.files       = ["lib/dronebl-client.rb","bin/dronebl-query", "bin/dronebl-add"]
  s.executables = ["dronebl-query", "dronebl-add"]
  s.homepage    = 'http://github.com/rylai-/dronebl.rb'
  s.license     = 'MIT'
end
