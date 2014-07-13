require 'spec_helper'

describe DataEndPoints do

	describe '#initalize' do
		it "creates neo object" do
			data_end_point = DataEndPoints.new
            expect(data_end_point.getNeo).to be_an_instance_of(Neography::Rest)
		end
	end     

	describe '#get_data_person' do
		it "returns data associated with the person" do
	    		expect(DataEndPoints.new.getPerson("Mark")).to be_truthy
	    		#puts "#{DataEndPoints.new.getPerson("Peter Griffin")}"
		end
	end

	describe '#get_data_url' do
		it "returns data associated with the url" do
	    		expect(DataEndPoints.new.getURL("ausa")).to be_truthy
	    		#puts "#{DataEndPoints.new.getURL("ausa")}"
		end
	end

	describe '#get_data_faculty' do
		it "returns data associated with the faculty" do
	    		expect(DataEndPoints.new.getDepartment("Arts")).to be_truthy
	    		#puts "#{DataEndPoints.new.getDepartment("Arts")}"
		end
	end

	describe '#get_from_single_endpoint' do
		it "returns data if value present" do
			expect(DataEndPoints.new.get_data("Arts")).to be_truthy
		end
	end

end
