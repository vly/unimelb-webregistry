#config.ru

root = ::File.dirname(__FILE__)
require ::File.join( root, 'lib/appEndPoints' )
run AppEndPoints.new