require 'rubygems'
require 'neography'
require 'ostruct'
require 'json'

require_relative './webSiteData.rb'


class DataEndPoints 

    def initialize()
    	@neo = Neography::Rest.new(ENV['GRAPHENEDB_URL'])
    end

    def getNeo
    	@neo
    end
	

	def getDepartment(pFaculty)
        #facultyName : faculty + websites

        pVal = "\"(?i)(^|.* )"+pFaculty+".*\"" 
        return :execute_query, "match (dept:Faculty)-[r1]->(website:Website)-[role]->(person:Person) where dept.name=~#{pVal}  return website,dept,person,role"
	end


    def getPerson(pName)
        # gets all data associated with the person
        #persons name : websites + person
        pVal = "\"(?i)(^|.* )"+pName+".*\""
         return :execute_query, "match (dept:Faculty)-[r1]->(website:Website)-[role]->(person:Person) where person.name=~#{pVal} return website,dept,person,role"
    end



    def getURL(pName)
        #gets all data associated with the URL
        #url : website + department +person+relationship
        pVal = "\".*"+pName+".*\""
        return :execute_query, "match (dept:Faculty)-[r1]->(website:Website)-[role]->(person:Person) where website.url=~#{pVal} or website.title=~#{pVal} return website,dept,person,role"
    end


    def query_data(query_string)
        return @neo.batch getURL(query_string), getPerson(query_string), getDepartment(query_string)
    end

    def get_data(query_string)
         return parseData(query_string,query_data(query_string))
    end


    def parseData(query_string,records)
        
        rows = Hash.new()
        records.each do |blck|
            record =blck["body"]
            if(!(record["data"].empty?))
                array_of_hashes = record["data"].map {|row| Hash[*record["columns"].zip(row).flatten] }
                data            = array_of_hashes.map{|m| OpenStruct.new(m)}
                data.each do |node|
                    if(!rows.has_key?(node.website["data"]["url"]))
                       rows[node.website["data"]["url"]] = WebSiteData.new(node.website["data"]["url"],node.website["data"]["title"],node.dept["data"]["name"])
                    end

                    if(node.role["type"].eql?"Maintainer")
                        rows[node.website["data"]["url"]].maintainer = node.person["data"]["name"]
                
                    else
                        rows[node.website["data"]["url"]].contact = node.person["data"]["name"]
                    end
                    puts "#{rows[node.website["data"]["url"]].inspect}"
                end
            end
        end
        return  {'query' => query_string,'data' => rows.values.map{ |e| e.to_h}}.to_json
    end

end
