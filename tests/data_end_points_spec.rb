
require 'RSpec'

require '../lib/dataEndPoints'

describe DataEndPoints do

	describe '#start' do
	 	before(:each) do
	 		@neo =Neography::Rest.new("http://localhost:9001")
	 	end


		describe '#get_data_person' do
			it "returns data associated with the person" do
        		expect(DataEndPoints.new.getDataPerson("Mark")).to be_truthy
        		#empty object returned above
        		puts(DataEndPoints.new.getDataPerson("Peter Griffin"))
			end
		end


		
	end
end