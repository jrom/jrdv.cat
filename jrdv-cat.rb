require 'rubygems'
require 'sinatra'

get '/' do
  @lang = 'ca'
  erb :index
end
