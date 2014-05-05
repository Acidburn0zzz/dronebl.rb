Gem::Specification.new do |s|
  s.name        = 'dronebl.rb'
  s.version     = '0.0.6'
  s.date        = '2014-05-04'
  s.description = "Interface to the DroneBL RPC2 service"
  s.summary     = [
    "This is an interface to the DroneBL.org RPC2 administrative interface. It comes with tools to submit IPs to the service",
    "and to query the data set stored on the server.",
    "NOTE: You should create a ~/.droneblkey file with your key inside of it for the best experience with this.",
  ].join("\n")
  s.authors     = ["Rylee Fowler"]
  s.email       = 'rylee@rylee.me'
  s.files       = ["lib/dronebl-client.rb","bin/dronebl-query", "bin/dronebl-add"]
  s.executables = ["dronebl-query", "dronebl-add"]
  s.homepage    = 'http://github.com/rylai-/dronebl.rb'
  s.license     = 'MIT'
end
