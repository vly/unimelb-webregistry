# webSiteData.rb
# require 'json'

class  WebSiteData
	attr_accessor :contact, :maintainer

	def initialize(url, name, dept, contact=" ", maintainer=" ")
     	@url        = url
     	@name       = name
     	@dept       = dept
     	@contact    = contact
     	@maintainer = maintainer
 	end 
 
   #  def to_s()
   #        {}"WebSite: "+ @url +  ", Title: " + @name + ", Faculty: "+ @dept + ", Contact: " + @contact + ", Maintainer: "+ @maintainer
   # end
   
   def to_h
        {
        	'WebSite:'    => @url, 
        	'Title:'      => @name, 
        	'Faculty:'    => @dept,
        	'Contact:'    => @contact, 
        	'Maintainer:' => @maintainer
        }
   end
end