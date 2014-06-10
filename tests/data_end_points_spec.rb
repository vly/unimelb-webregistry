
require 'RSpec'

require '../lib/dataEndPoints'

describe DataEndPoints do

	describe '#start' do
	 	before(:each) do
	 		@neo =Neography::Rest.new("http://localhost:9001")
	 	end


		describe '#get_data_person' do
			it "returns data associated with the person" do
        		expect(DataEndPoints.new.getPerson("Mark")).to be_truthy
        		#puts(DataEndPoints.new.getPerson("Peter Griffin"))
			end
		end

				describe '#get_data_url' do
			it "returns data associated with the url" do
        		expect(DataEndPoints.new.getURL("ausa")).to be_truthy
        		puts(DataEndPoints.new.getURL("ausa"))
			end
		end

				describe '#get_data_faculty' do
			it "returns data associated with the faculty" do
        		expect(DataEndPoints.new.getDepartment("Arts")).to be_truthy
        		#puts(DataEndPoints.new.getDepartment("Arts"))
			end
		end
		
	end
end