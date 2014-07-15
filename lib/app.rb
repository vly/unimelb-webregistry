require 'sinatra'

require_relative 'dataEndPoints.rb'


class AppEndPoints < Sinatra::Base

    


	get '/index' do 
		"Hello World"
	end


	get '/search/:query' do
		@search = DataEndPoints.new
		value = @search.get_data(params[:query])
		return value
    end





end