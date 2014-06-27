require 'rubygems'
require 'neography'
require 'ostruct'
require '../lib/appConfig'


class DataEndPoints 

    def initialize()
    	@neo = Neography::Rest.new(ENV['GRAPHENEDB_URL'] || AppConfig::GRAPHENE_DB_URL)
    end

    def getNeo
    	@neo
    end
	

	def getDepartment(pFaculty)
        #facultyName : faculty + websites
		#match (y:Faculty)-[:Owns]->(x:Website) where y.name=~".*Lib.*"  return x
        #http://app25955786:4T5X8ANzM9owEs7PeOkd@app25955786.sb02.stations.graphenedb.com:24789
        pVal = "\".*"+pFaculty+".*\""
		@neo.execute_query("match (y:Faculty)-[:Owns]->(x:Website) where y.name=~#{pVal}  return x,y")

	end


	def getPerson(pName)
     # gets all data associated with the person
     #persons name : websites + person
     pVal = "\".*"+pName+".*\""
     #pVal = "\""+pName+"\""
     @neo.execute_query(" MATCH (x:Website)-[r]->(y:Person) where y.name=~#{pVal} RETURN x,y,r")
	end




    def getURL(pName)
    #gets all data associated with the URL
    #url : website + department +person+relationship
     pVal = "\".*"+pName+".*\""
     #match (y:Faculty)-[:Owns]->(x:Website) where x.url=~'.*melb.*' return y
     results = @neo.execute_query("match (x:Website)-[r]-(y) where x.url=~#{pVal} return x,y,r")
     array_of_hashes = results["data"].map {|row| Hash[*results["columns"].zip(row).flatten] }
     data = array_of_hashes.map{|m| OpenStruct.new(m)}
     return data
    end





end



