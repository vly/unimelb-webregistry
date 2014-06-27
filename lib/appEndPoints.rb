require 'sinatra'

require_relative 'dataEndPoints.rb'


class AppEndPoints < Sinatra::Base

    def initialize
        @search = DataEndPoints.new
    end


	get '/index' do 
		"Hello World"
	end


	get '/search/:query' do
	@search.getURL(params[:query])
    end





end