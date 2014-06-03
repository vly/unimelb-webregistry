# these are the default values:
Neography.configure do |config|
  config.protocol       = "http://"
  config.server         = "app25955786:4T5X8ANzM9owEs7PeOkd@app25955786.sb02.stations.graphenedb.com"
  config.port           = 24789
  config.directory      = ""  # prefix this path with '/' 
  config.cypher_path    = "/cypher"
  config.gremlin_path   = "/ext/GremlinPlugin/graphdb/execute_script"
  config.log_file       = "neography.log"
  config.log_enabled    = false
  config.max_threads    = 
  config.authentication = nil  # 'basic' or 'digest'
  config.username       = nil
  config.password       = nil
  config.parser         = MultiJsonParser
end