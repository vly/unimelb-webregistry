require 'sinatra'

require_relative 'dataEndPoints.rb'


# class AppEndPoints < Sinatra::Base

  get '/search/:query' do |q|
		@search = DataEndPoints.new
		value = @search.get_data(q)
		return value.to_json
  end

# end