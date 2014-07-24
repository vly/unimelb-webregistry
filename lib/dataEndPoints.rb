require 'rubygems'
require 'neography'
require 'ostruct'
require 'json'

class DataEndPoints 

    def initialize()
    	@neo = Neography::Rest.new(ENV['GRAPHENEDB_URL'])
    end

    def getNeo
    	@neo
    end
	

	def getDepartment(pFaculty)
        #facultyName : faculty + websites
        pVal = "\".*"+pFaculty+".*\"" 
        return :execute_query, "match (y:Faculty)-[r]->(x:Website) where y.name=~#{pVal}  return x,y,r"
	end


    def getPerson(pName)
        # gets all data associated with the person
        #persons name : websites + person
        pVal = "\".*"+pName+".*\""
         return :execute_query, "match (x:Website)-[r]->(y:Person) where y.name=~#{pVal} return x,y,r"
    end



    def getURL(pName)
        #gets all data associated with the URL
        #url : website + department +person+relationship
        pVal = "\".*"+pName+".*\""
        #match (y:Faculty)-[:Owns]->(x:Website) where x.url=~'.*melb.*' return y
        return :execute_query, "match (x:Website)-[r]-(y) where x.url=~#{pVal} return x,y,r"
    end


    def get_data(query_string)
        return @neo.batch getURL(query_string), getPerson(query_string), getDepartment(query_string)
    end


    def parseData(records)
     array_of_hashes = records["data"].map {|row| Hash[*records["columns"].zip(row).flatten] }
     data1 = array_of_hashes.map{|m| OpenStruct.new(m)}
     rows = Array.new()
     data1.each do |node|
        r = {:x => node.x["data"], :y => node.y["data"], :r => node.r["type"]}
        rows << r
     end
     out = {:columns => records["columns"], :data => rows}
     return out.to_json
    end
end
