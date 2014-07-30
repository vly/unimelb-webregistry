require 'sinatra'
require_relative './dataEndPoints.rb'

class AppEndPoints < Sinatra::Base
	get '/search/:query' do
		@search = DataEndPoints.new
		value = @search.get_data(params[:query])
		response.headers['Access-Control-Allow-Origin'] = '*'
		response.headers['Access-Control-Allow-Methods'] = 'GET,INFO'
		return value
    end

    get'/'do
    	status 200
    	body ''
	end
end