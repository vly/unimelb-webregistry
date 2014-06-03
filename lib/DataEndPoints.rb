require 'rubygems'
require 'neography'


class DataEndPoints

    def initialize()
    	@neo = Neography::Rest.new("http://app25955786:4T5X8ANzM9owEs7PeOkd@app25955786.sb02.stations.graphenedb.com:24789")
    end

    def getNeo
    	@neo
    end
	

	def getFacultyData
		#match (y:Faculty)-[:Owns]->(x:Websites) return x,y
        #http://app25955786:4T5X8ANzM9owEs7PeOkd@app25955786.sb02.stations.graphenedb.com:24789
		@neo.execute_query("match (y:Faculty)-[:Owns]->(x:Websites) return x,y")

	end


	def getDataPerson(pName)
    #pVal = "\".*"+pName+"*.\""
    pVal = "\""+pName+"\""
     #match (x:Website)-[]->(y:Person) where y.name=~".*rew*." return x,y;
     @neo.execute_query(" MATCH (x:Website)-[]->(y:Person) where y.name=~#{pVal} RETURN x")
	end


end



